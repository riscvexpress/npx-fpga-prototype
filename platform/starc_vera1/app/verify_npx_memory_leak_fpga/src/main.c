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
#define NUM_ITER 10

int main()
{
  if (EXCLUSIVE_ID == 0)
  {
    ervp_mop_mapping_t *mop_mapping = matrix_op_mapping_alloc();
#ifdef INCLUDE_DCA
    map_your_matrix_function(mop_mapping);
#endif

    npx_filename_init(&filename, app_name);

    printf_section(SKIP_SIM, "Verify App: %s", app_name);

    npx_network_t *net = npx_parse_network_cfg(filename.network, filename.operator);
    npx_network_load_parameters(net, filename.parameter);
    npx_network_map_matrix_operator(net, -1, mop_mapping);
    npx_network_print(net);

    npx_filename_set_sample(&filename, 0);
    const npx_rawinput_t *npx_sample = npx_load_sample(filename.sample, filename.preprocess);
    const npx_layerio_tsseq_t *input_tsseq = npx_preprocess(filename.preprocess, net, npx_sample->tensor, npx_sample->scaled);

    for (int i = 0; i < NUM_ITER; i++)
    {
      if (!fakefile_exists(filename.sample))
        break;
      printf_subsection(SKIP_SIM, "Iteration %d", i);

      npx_network_reset(net);
      npx_layerio_state_t state;
      state.input_tsseq = input_tsseq;
      state.output_tsseq = npx_inference(net, state.input_tsseq, 0, net->num_layer);
      npx_layer_output_release(net, net->num_layer - 1);
      //
      assert(!has_memory_leak());
    }
  }

  return 0;
}
