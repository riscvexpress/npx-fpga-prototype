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
`include "ervp_axi_define.vh"
`include "dca_matrix_lsu_inst.vh"




module DCA_MODULE_02
(
  dca_port_14,
  dca_port_03,
  dca_port_11,
  dca_port_01,

  dca_port_09,
  dca_port_04,
  dca_port_07,

  dca_port_00,
  dca_port_10,
  dca_port_02,
  dca_port_05,

  dca_port_13,
  dca_port_12,
  dca_port_08,
  dca_port_06
);




parameter LSU_PARA = 0;
parameter AXI_PARA = 32;
parameter MATRIX_SIZE_PARA = 4;

`include "ervp_axi_lpara.vb"
`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire dca_port_14;
input wire dca_port_03;
input wire dca_port_11;
input wire dca_port_01;

`include "dca_lsu_util.vb"
`include "dca_lsu_lpara.vb"

input wire dca_port_09;
input wire [BW_TXN_INFO-1:0] dca_port_04;
output wire dca_port_07;

output wire dca_port_00;
input wire dca_port_10;
input wire dca_port_02;
input wire [BW_AXI_DATA-1:0] dca_port_05;

input wire dca_port_13;
output wire dca_port_12;
output reg [BW_MEMORY_ROW_BUFFER-1:0] dca_port_08;
output wire [BW_TXN_INFO-1:0] dca_port_06;

integer i;

wire [BW_BITADDR-1:0] dca_signal_2;
wire [`BW_AXI_ALEN-1:0] dca_signal_5;
wire dca_signal_3;
wire dca_signal_1;

wire dca_signal_7;
wire dca_signal_6;
wire [MAX_NUM_AXI_DATA-1:0] dca_signal_4;
reg dca_signal_0;

assign {dca_signal_1, dca_signal_3, dca_signal_5, dca_signal_2} = dca_port_04;
assign dca_port_07 = dca_port_12 & dca_port_13;

assign dca_port_00 = dca_port_09 & (~dca_port_12);
assign dca_signal_7 = dca_port_10 & dca_port_00;
assign dca_signal_6 = dca_signal_7 & dca_port_02;

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(MAX_NUM_AXI_DATA),
  .CIRCULAR(0)
)
i_dca_instance_0
(
  .clk(dca_port_14),
  .rstnn(dca_port_03),
  .enable(dca_port_01),
  .init(dca_signal_6),
  .count(dca_signal_7),
  .value(dca_signal_4),
  .is_first_count(),
  .is_last_count()
);

always@(posedge dca_port_14, negedge dca_port_03)
begin
  if(dca_port_03==0)
    dca_signal_0 <= 0;
  else if(dca_port_01)
  begin
    if(dca_signal_0)
      dca_signal_0 <= ~dca_port_13;
    else
      dca_signal_0 <= dca_signal_6;
  end
end

assign dca_port_12 = dca_port_09 & (dca_signal_1? 1 : dca_signal_0);

always@(posedge dca_port_14, negedge dca_port_03)
begin
  if(dca_port_03==0)
    dca_port_08 <= 0;
  else if(dca_port_01)
  begin
    for(i=0; i<MAX_NUM_AXI_DATA; i=i+1)
      if(dca_signal_7)
      begin
        if(dca_signal_4[i])
          dca_port_08[BW_AXI_DATA*(i+1)-1-:BW_AXI_DATA] <= dca_port_05;
        else if(dca_signal_4[0])
          dca_port_08[BW_AXI_DATA*(i+1)-1-:BW_AXI_DATA] <= 0;
      end
  end
end

assign dca_port_06 = dca_port_04;

endmodule
