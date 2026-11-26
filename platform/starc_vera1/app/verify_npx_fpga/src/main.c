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

#define SKIP_SIM 1

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

    printf_section(SKIP_SIM, "Verify NPX: %s", app_name);

    npx_network_t *net = npx_parse_network_cfg(filename.network, filename.operator);
    npx_network_load_parameters(net, filename.parameter);
    npx_network_map_matrix_operator(net, -1, mop_mapping);
    npx_network_print(net);

    while (1)
    {
      npx_filename_set_sample(&filename, sample_index);
      if (!fakefile_exists(filename.sample))
        break;
      printf_subsection(SKIP_SIM, "Iteration %d", sample_index);
      npx_network_reset(net);
      const npx_rawinput_t *npx_sample = npx_load_sample(filename.sample, filename.preprocess);
      const npx_layerio_tsseq_t *input_tsseq = npx_preprocess(filename.preprocess, net, npx_sample->tensor, npx_sample->scaled);
      npx_testvector_t *tv = npx_load_testvector(filename.testvector, net);

      npx_layerio_state_t state;
      state.input_tsseq = input_tsseq;
      state.output_tsseq = NULL;

      for (int layer_index = 0; layer_index < net->num_layer; layer_index++)
      {
        state.output_tsseq = npx_inference(net, state.input_tsseq, layer_index, layer_index + 1);
        assert(state.output_tsseq != NULL);
        npx_verify_with_testvector(state.output_tsseq, tv, layer_index);
        if (layer_index >= 1)
          npx_layer_output_release(net, layer_index - 1);
        state.input_tsseq = state.output_tsseq;
        state.output_tsseq = NULL;
      }
      npx_layer_output_release(net, net->num_layer - 1);
      sample_index++;
    }

    printf("\n\nVerify NPX Complete");
  }

  return 0;
}
