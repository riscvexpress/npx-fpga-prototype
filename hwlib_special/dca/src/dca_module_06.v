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





module DCA_MODULE_06
(
  dca_port_00,
  dca_port_01,
  dca_port_03,
  dca_port_06,

  dca_port_07,
  dca_port_09,
  dca_port_04,
  dca_port_05,
  dca_port_02,
  dca_port_08
);





parameter LSU_PARA = 0;
parameter AXI_PARA = 32;
parameter MATRIX_SIZE_PARA = 4;
parameter DCA_GPARA_0 = 4;

`include "ervp_axi_lpara.vb"
`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire dca_port_00;
input wire dca_port_01;
input wire dca_port_03;
input wire dca_port_06;

`include "dca_lsu_util.vb"
`include "dca_lsu_lpara.vb"

output wire dca_port_07;
input wire dca_port_09;
input wire [BW_TXN_INFO-1:0] dca_port_04;
output wire dca_port_05;
output wire [BW_TXN_INFO-1:0] dca_port_02;
input wire dca_port_08;

wire [BW_TXN_INFO-1:0] dca_signal_10;
wire [BW_BITADDR-1:0] dca_signal_06;
wire [`BW_AXI_ALEN-1:0] dca_signal_08;
wire dca_signal_19;
wire dca_signal_13;

wire [BW_BITADDR-1:0] dca_signal_17;
wire [`BW_AXI_ALEN-1:0] dca_signal_05;
wire dca_signal_12;
wire dca_signal_18;

wire dca_signal_03;
reg dca_signal_16;
wire [BW_TXN_INFO-1:0] dca_signal_11;
wire dca_signal_07;
wire dca_signal_15;
wire [BW_TXN_INFO-1:0] dca_signal_00;

wire dca_signal_09;
wire dca_signal_04;

reg dca_signal_01;
reg [BW_TXN_INFO-1:0] dca_signal_14;
reg dca_signal_02;

assign dca_signal_10 = dca_port_04;
assign {dca_signal_13, dca_signal_19, dca_signal_08, dca_signal_06} = dca_signal_10;
assign {dca_signal_18, dca_signal_12, dca_signal_05, dca_signal_17} = dca_signal_14;

assign dca_signal_09 = dca_port_09 & dca_port_07;
assign dca_signal_04 = dca_signal_16 & dca_signal_03;

assign dca_port_07 = dca_signal_01? dca_signal_03 : 1;

always@(posedge dca_port_00 or negedge dca_port_01)
begin
  if(dca_port_01==0)
    dca_signal_01 <= 0;
  else if(dca_port_06)
  begin
    if(dca_port_09)
      dca_signal_01 <= 1;
    else if(dca_signal_04)
      dca_signal_01 <= 0;
  end
end

always@(posedge dca_port_00 or negedge dca_port_01)
begin
  if(dca_port_01==0)
    dca_signal_14 <= 0;
  else if(dca_port_06 && dca_signal_09)
    dca_signal_14 <= dca_port_04;
end

ERVP_FIFO
#(
  .BW_DATA(BW_TXN_INFO),
  .DEPTH(DCA_GPARA_0)
)
i_dca_instance_0
(
  .clk(dca_port_00),
  .rstnn(dca_port_01),
  .enable(dca_port_06),
  .clear(dca_port_03),
  .wready(dca_signal_03),
  .wfull(),
  .wrequest(dca_signal_16),
  .wdata(dca_signal_11),
  .wnum(),
  .rready(dca_signal_07),
  .rempty(),
  .rrequest(dca_signal_15),
  .rdata(dca_signal_00),
  .rnum()
);

always@(*)
begin
  dca_signal_16 = 0;
  dca_signal_02 = 0;
  if(dca_signal_01)
  begin
    if(dca_signal_12)
    begin
      dca_signal_16 = 1;
      dca_signal_02 = 0;
    end
    else if(dca_port_09)
    begin
      dca_signal_16 = 1;
      dca_signal_02 = dca_signal_13;
    end
  end
end

assign dca_signal_11 = {dca_signal_02, dca_signal_12, dca_signal_05, dca_signal_17};

assign dca_port_05 = dca_signal_07;
assign dca_port_02 = dca_signal_00;
assign dca_signal_15 = dca_port_08;

endmodule
