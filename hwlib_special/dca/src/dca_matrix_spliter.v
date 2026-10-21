// ****************************************************************************
// ****************************************************************************
// Copyright SoC Design Research Group, All rights reservxd.
// Electronics and Telecommunications Research Institute (ETRI)
// 
// THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
// WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
// TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
// REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
// SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
// IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
// COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
// ****************************************************************************
// 2026-09-30
// Kyuseung Han (han@etri.re.kr)
// ****************************************************************************
// ****************************************************************************

`include "ervp_global.vh"

`include "dca_matrix_info.vh"
`include "dca_matrix_lsu_inst.vh"
`include "dca_module_memorymap_offset.vh"



module DCA_MATRIX_SPLITER
(
  clk,
  rstnn,
  clear,
  enable,

  matrix_info,
  init,
  is_col_first,
  iterate,
  go_next_base,

  block_info,
  is_first_x,
  is_last_x,
  is_first_y,
  is_last_y,
  is_first_element,
  is_last_element,
  valid_row_list,
  valid_col_list
);



parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire clk;
input wire rstnn;
input wire clear;
input wire enable;

input wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] matrix_info;
input wire init;
input wire is_col_first;
input wire iterate;
input wire go_next_base;

output wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] block_info;
output wire is_first_x;
output wire is_last_x;
output wire is_first_y;
output wire is_last_y;
output wire is_first_element;
output wire is_last_element;

output wire [MATRIX_NUM_ROW-1:0] valid_row_list;
output wire [MATRIX_NUM_COL-1:0] valid_col_list;

genvar i;

`include "ervp_log_util.vf"
`include "ervp_bitwidth_util.vf"

localparam  DCA_LPARA_02 = LOG2RU(MATRIX_NUM_ROW); 
localparam  DCA_LPARA_07 = `BW_DCA_MATRIX_INFO_NUM_ROW_M1-DCA_LPARA_02;
localparam  DCA_LPARA_01 = LOG2RU(MATRIX_NUM_COL); 
localparam  DCA_LPARA_06 = `BW_DCA_MATRIX_INFO_NUM_COL_M1-DCA_LPARA_01;

wire [`BW_DCA_MATRIX_INFO_ADDR-1:0] dca_signal_42;
wire [`BW_DCA_MATRIX_INFO_STRIDE_LS3-1:0] dca_signal_44;
wire [`BW_DCA_MATRIX_INFO_NUM_ROW_M1-1:0] dca_signal_25;
wire [`BW_DCA_MATRIX_INFO_NUM_COL_M1-1:0] dca_signal_36;
wire [`BW_DCA_MATRIX_INFO_IS_SIGNED-1:0] dca_signal_21;
wire [`BW_DCA_MATRIX_INFO_IS_FLOAT-1:0] dca_signal_32;
wire [`BW_DCA_MATRIX_INFO_ADDR_LSA_P3-1:0] dca_signal_02;
wire [`BW_DCA_MATRIX_INFO_BIT_OFFSET-1:0] dca_signal_33;

wire [`MAX(DCA_LPARA_02,1)-1:0] dca_signal_40;
wire [DCA_LPARA_07-1:0] dca_signal_15;
wire [`MAX(DCA_LPARA_01,1)-1:0] dca_signal_05;
wire [DCA_LPARA_06-1:0] dca_signal_24;

localparam  DCA_LPARA_09 = REQUIRED_BITWIDTH_UNSIGNED(32*MATRIX_NUM_COL);

localparam  DCA_LPARA_04 = DCA_LPARA_09;
localparam  DCA_LPARA_03 = `BW_DCA_MATRIX_INFO_ADDR_LSA_P3;

wire [DCA_LPARA_04-1:0] dca_signal_16;
wire [DCA_LPARA_03-1:0] dca_signal_10;
wire [DCA_LPARA_04-1:0] dca_signal_43;

localparam  DCA_LPARA_08 = `BW_DCA_MATRIX_INFO_ADDR+3;

wire [DCA_LPARA_08-1:0] dca_signal_41;
wire [DCA_LPARA_08-1:0] dca_signal_06;
wire [DCA_LPARA_08-1:0] dca_signal_07;
wire [DCA_LPARA_08-1:0] dca_signal_01;

localparam  DCA_LPARA_00 = DCA_LPARA_07;
localparam  DCA_LPARA_05 = DCA_LPARA_06;

wire dca_signal_17;
wire [DCA_LPARA_00-1:0] dca_signal_38;
wire [DCA_LPARA_05-1:0] dca_signal_11;
wire dca_signal_04;
wire dca_signal_19;
wire dca_signal_39;
wire dca_signal_13;
wire dca_signal_20;
wire dca_signal_35;
wire dca_signal_30;
wire dca_signal_03;
wire dca_signal_26;
wire dca_signal_00;
wire dca_signal_37;
wire dca_signal_22;

reg [DCA_LPARA_08-1:0] dca_signal_12, dca_signal_18;
wire [DCA_LPARA_08-1:0] dca_signal_34;
wire [DCA_LPARA_08-1:0] dca_signal_27;

wire [`BW_DCA_MATRIX_INFO_ADDR-1:0] dca_signal_08;
wire [`BW_DCA_MATRIX_INFO_STRIDE_LS3-1:0] dca_signal_14;
wire [`BW_DCA_MATRIX_INFO_NUM_ROW_M1-1:0] dca_signal_31;
wire [`BW_DCA_MATRIX_INFO_NUM_COL_M1-1:0] dca_signal_23;
wire [`BW_DCA_MATRIX_INFO_IS_SIGNED-1:0] dca_signal_28;
wire [`BW_DCA_MATRIX_INFO_IS_FLOAT-1:0] dca_signal_29;
wire [`BW_DCA_MATRIX_INFO_ADDR_LSA_P3-1:0] dca_signal_09;

assign {dca_signal_33, dca_signal_02, dca_signal_32, dca_signal_21, dca_signal_36, dca_signal_25, dca_signal_44, dca_signal_42} = matrix_info;
assign dca_signal_15 = dca_signal_25[`BW_DCA_MATRIX_INFO_NUM_ROW_M1-1:DCA_LPARA_02];
assign dca_signal_40 = (DCA_LPARA_02==0)? 0 : dca_signal_25;
assign dca_signal_24 = dca_signal_36[`BW_DCA_MATRIX_INFO_NUM_COL_M1-1:DCA_LPARA_01];
assign dca_signal_05 = (DCA_LPARA_01==0)? 0 : dca_signal_36;

ERVP_BARREL_SHIFTER
#(
  .BW_DATA(DCA_LPARA_04),
  .BW_SHIFT_AMOUNT(DCA_LPARA_03),
  .SIGNED_AMOUNT(0),
  .PLUS_TO_LEFT(1),
  .CIRCULAR_SHIFT(0),
  .LSB_FILL_VALUE(0)
)
i_dca_instance_0
(
  .data_input(dca_signal_16),
  .shift_amount(dca_signal_10),
  .data_output(dca_signal_43)
);

assign dca_signal_16 = MATRIX_NUM_COL;
assign dca_signal_10 = dca_signal_02;

assign dca_signal_41 = dca_signal_43;
assign dca_signal_06 = dca_signal_44<<DCA_LPARA_02;

assign dca_signal_07 = is_col_first? dca_signal_41 : dca_signal_06;
assign dca_signal_01 = is_col_first? dca_signal_06 : dca_signal_41;

DCA_MATRIX_ITERATOR
#(
  .BW_NUM_ROW(DCA_LPARA_00),
  .BW_NUM_COL(DCA_LPARA_05)
)
i_dca_instance_1
(
  .clk(clk),
  .rstnn(rstnn),
  .clear(clear),
  .enable(enable),

  .is_col_first(dca_signal_17),
  .num_row_m1(dca_signal_38),
  .num_col_m1(dca_signal_11),
  .iterate(dca_signal_04),
  .go_next_base(dca_signal_19),

  .is_first_row(dca_signal_39),
  .is_last_row(dca_signal_13),
  .is_first_col(dca_signal_20),
  .is_last_col(dca_signal_35),
  .is_first_element(dca_signal_30),
  .is_last_element(dca_signal_03),
  .is_first_x(dca_signal_26),
  .is_last_x(dca_signal_00),
  .is_first_y(dca_signal_37),
  .is_last_y(dca_signal_22)
);

assign dca_signal_17 = is_col_first;
assign dca_signal_38 = dca_signal_15 + dca_signal_33;
assign dca_signal_11 = dca_signal_24 + dca_signal_33;
assign dca_signal_04 = iterate;
assign dca_signal_19 = go_next_base;

assign is_first_x = dca_signal_26;
assign is_last_x = dca_signal_00;
assign is_first_y = dca_signal_37;
assign is_last_y = dca_signal_22;
assign is_first_element = dca_signal_30;
assign is_last_element = dca_signal_03 & (dca_signal_33==0);

always@(posedge clk, negedge rstnn)
begin
  if(rstnn==0)
  begin
    dca_signal_12 <= 0;
    dca_signal_18 <= 0;
  end
  else if(enable)
  begin
    if(init)
    begin
      dca_signal_12 <= {dca_signal_42,3'b 000};
      dca_signal_18 <= {dca_signal_42,3'b 000};
    end
    else if(go_next_base)
    begin
      if(is_last_y)
      begin
        dca_signal_12 <= {dca_signal_42,3'b 000};
        dca_signal_18 <= {dca_signal_42,3'b 000};
      end
      else
      begin
        dca_signal_12 <= dca_signal_27;
        dca_signal_18 <= dca_signal_27;
      end
    end
    else if(iterate)
    begin
      if(is_last_x)
        dca_signal_12 <= dca_signal_18;
      else
        dca_signal_12 <= dca_signal_34;
    end
  end
end

assign dca_signal_34 = dca_signal_12 + dca_signal_07;
assign dca_signal_27 = dca_signal_18 + dca_signal_01;

assign dca_signal_08 = dca_signal_12>>3;
assign dca_signal_14 = dca_signal_44;
assign dca_signal_31 = dca_signal_13? dca_signal_40 : (MATRIX_NUM_ROW-1);
assign dca_signal_23 = dca_signal_35? dca_signal_05 : (MATRIX_NUM_COL-1);
assign dca_signal_28 = dca_signal_21;
assign dca_signal_29 = dca_signal_32;
assign dca_signal_09 = dca_signal_02;

assign block_info = {dca_signal_09, dca_signal_29, dca_signal_28, dca_signal_23, dca_signal_31, dca_signal_14, dca_signal_08};

generate
  for(i=0; i<MATRIX_NUM_ROW; i=i+1)
  begin : i_gen_valid_row_list
    assign valid_row_list[i] = (i<=dca_signal_31);
  end
endgenerate

generate
  for(i=0; i<MATRIX_NUM_COL; i=i+1)
  begin : i_gen_valid_col_list
    assign valid_col_list[i] = (i<=dca_signal_23);
  end
endgenerate

endmodule
