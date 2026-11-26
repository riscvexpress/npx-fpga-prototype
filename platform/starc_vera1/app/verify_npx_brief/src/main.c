#include "platform_info.h"
#include "ervp_printf.h"
#include "ervp_printf_section.h"
#include "ervp_core_id.h"
#include "ervp_matrix_op_sw.h"

#ifdef INCLUDE_DCA
#include "map_your_matrix_hw.h"
#endif

#include "npx_parser.h"
#include "npx_filename.h"
#include "npx_layer.h"
#include "npx_network.h"
#include "npx_sample.h"
#include "npx_preprocess.h"

#include "npx_app_name.h" // exists in ${APP_DIR}/include

npx_filename_t filename;

#define VERIFY_LAYER_START 0
#define VERIFY_LAYER_END 3
#define NUM_TIMESTEPS 1


#define SKIP_SIM 1

static npx_layerio_tsseq_t *load_layer_output_from_testvector(npx_network_t *net, npx_testvector_t *tv, int layer_index, const npx_layerio_tsseq_t *network_input, int timesteps)
{
  int num_dim = network_input->sequence[0]->num_dim;
  ervp_matrix_datatype_t datatype = network_input->sequence[0]->datatype;
  float scaled = network_input->scaled;
  for (int i = 0; i <= layer_index; i++)
  {
    npx_layer_compute_t *layer_compute = net->layer_compute_seq[i];
    npx_layer2d_iodata_t *iodata = &(((npx_conv2d_layer_t *)layer_compute->layer)->iodata);
    switch (layer_compute->layer_type)
    {
    case NPXL_CONV2D:
      num_dim = 3;
      datatype = iodata->out_datatype;
      break;
    case NPXL_LINEAR:
      datatype = iodata->out_datatype;
      break;
    case NPXL_MAXPOOL2D:
    case NPXL_AVGPOOL2D:
      break;
    case NPXL_SUMPOOL2D:
    {
      npx_sumpool2d_layer_t *layer = (npx_sumpool2d_layer_t *)(layer_compute->layer);
      scaled *= (layer->kernel_size * layer->kernel_size);
      break;
    }
    case NPXL_LEAKY:
#ifdef USE_SUBBYTE_NPX
      datatype = MATRIX_DATATYPE_UINT01;
#else
      datatype = MATRIX_DATATYPE_SINT08;
#endif
      scaled = 1;
      break;
    case NPXL_FLATTEN:
      num_dim = 2;
      break;
    default:
      assert_msg(0, "%s", npx_layer_type_to_str(layer_compute->layer_type));
    }
  }

  npx_layer_compute_t *layer_compute = net->layer_compute_seq[layer_index];
  npx_layer2d_iodata_t *iodata = &(((npx_conv2d_layer_t *)layer_compute->layer)->iodata);
  npx_tensor_dim_size_t size_array[3];
  if (num_dim == 3)
  {
    size_array[0] = iodata->out_size[0];
    size_array[1] = iodata->out_size[1];
    size_array[2] = iodata->out_channels;
  }
  else
  {
    size_array[0] = 1;
    size_array[1] = iodata->out_size[0] * iodata->out_size[1] * iodata->out_channels;
  }

  npx_layerio_tsseq_t *tsseq = npx_output_tsseq_alloc(timesteps, network_input->is_boundary, scaled, datatype, num_dim, size_array);
  assert(npx_tensor_elements(tsseq->sequence[0]) == tv->layer_output_size[layer_index]);

  const int32_t *tv_data = (const int32_t *)(tv->tv_data);
  for (int t = 0; t < timesteps; t++)
  {
    NpxTensorInfo *tensor = tsseq->sequence[t];
    tensor->is_binary = iodata->out_is_binary;
    ErvpMatrixInfo output_matrix;
    ErvpMatrixInfo tv_matrix;
    npx_tensor_to_flattened_matrix_info(tensor, &output_matrix);
    const int32_t *addr = tv_data + (t * tv->testvector_acc_size[tv->num_layer - 1]) + (tv->testvector_acc_size[layer_index] - tv->layer_output_size[layer_index]);
    matrix_init_info(MATRIX_DATATYPE_SINT32, output_matrix.num_row, output_matrix.num_col, (void *)addr, &tv_matrix);
    matrix_copy_sw(&tv_matrix, &output_matrix, 0);
  }
  return tsseq;
}

int main()
{
  if (EXCLUSIVE_ID == 0)
  {
    ervp_mop_mapping_t *mop_mapping = matrix_op_mapping_alloc();
#ifdef INCLUDE_DCA
    map_your_matrix_function(mop_mapping);
#endif

    int sample_index = 0;
    npx_filename_init(&filename, app_name);

    printf_section(SKIP_SIM, "Verify NPX layer by layer: %s", app_name);

    npx_network_t *net = npx_parse_network_cfg(filename.network, filename.operator);
    npx_network_load_parameters(net, filename.parameter);
    npx_network_map_matrix_operator(net, -1, mop_mapping);
    npx_network_print(net);

    const int layer_start = VERIFY_LAYER_START;
    const int layer_end = (VERIFY_LAYER_END < 0) ? net->num_layer : VERIFY_LAYER_END;
    assert((layer_start >= 0) && (layer_start < layer_end) && (layer_end <= net->num_layer));

    while (1)
    {
      npx_filename_set_sample(&filename, sample_index);
      if (!fakefile_exists(filename.sample))
        break;
      printf_subsection(SKIP_SIM, "Sample %d", sample_index);
      const npx_rawinput_t *npx_sample = npx_load_sample(filename.sample, filename.preprocess);
      npx_layerio_tsseq_t *network_input = npx_preprocess(filename.preprocess, net, npx_sample->tensor, npx_sample->scaled);
      npx_testvector_t *tv = npx_load_testvector(filename.testvector, net);

      const int all_timesteps = network_input->timesteps;
      const int timesteps = ((NUM_TIMESTEPS > 0) && (NUM_TIMESTEPS < all_timesteps)) ? NUM_TIMESTEPS : all_timesteps;
      network_input->timesteps = timesteps;

      for (int layer_index = layer_start; layer_index < layer_end; layer_index++)
      {
        npx_network_reset(net);
        npx_layerio_tsseq_t *input_tsseq = network_input;
        if (layer_index > 0)
        {
          npx_layer_compute_t *prev_compute = net->layer_compute_seq[layer_index - 1];
          input_tsseq = load_layer_output_from_testvector(net, tv, layer_index - 1, network_input, timesteps);
          prev_compute->output_tsseq = input_tsseq;
          prev_compute->output_usage_count = 1;
        }
        npx_layerio_tsseq_t *output_tsseq = npx_inference(net, input_tsseq, layer_index, layer_index + 1);
        assert(output_tsseq != NULL);
        npx_verify_with_testvector(output_tsseq, tv, layer_index);
        printf("\nlayer %02d (%s): correct", layer_index, npx_layer_type_to_str(net->layer_compute_seq[layer_index]->layer_type));
        while (net->layer_compute_seq[layer_index]->output_tsseq != NULL)
          npx_layer_output_release(net, layer_index);
      }
      network_input->timesteps = all_timesteps;
      sample_index++;
    }

    printf("\n\nVerify NPX Complete");
  }

  return 0;
}
