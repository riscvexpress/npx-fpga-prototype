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





module DCA_MODULE_26 
(
  dca_port_11,
  dca_port_09,
  dca_port_03,

  dca_port_00,
  dca_port_08,

  dca_port_05,
  dca_port_04,
  
  dca_port_01,
  dca_port_12,

  dca_port_02,
  dca_port_06,
  dca_port_07,
  dca_port_10
);





parameter DCA_GPARA_3 = 10;
parameter DCA_GPARA_1 = 10;
parameter DCA_GPARA_2 = 8;
parameter DCA_GPARA_0 = 8;

input wire dca_port_11;
input wire dca_port_09;
input wire dca_port_03;

input wire [DCA_GPARA_2-1:0] dca_port_00;
input wire [DCA_GPARA_0-1:0] dca_port_08;

input wire dca_port_05;
output wire dca_port_04;

output wire dca_port_01;
output wire dca_port_12;

output wire dca_port_02;
output wire dca_port_06;
output wire dca_port_07;
output wire dca_port_10;

localparam  DCA_LPARA_5 = 2;
localparam  DCA_LPARA_2 = 0;
localparam  DCA_LPARA_0 = 1;
localparam  DCA_LPARA_6 = 2;

reg [DCA_LPARA_5-1:0] dca_signal_18;
wire dca_signal_14;

localparam  DCA_LPARA_4 = DCA_GPARA_2;

reg [DCA_LPARA_4-1:0] dca_signal_03;
wire dca_signal_02;

wire dca_signal_16;
wire dca_signal_10;
wire [DCA_LPARA_4-1:0] dca_signal_08;
wire dca_signal_17;

localparam  DCA_LPARA_3 = DCA_GPARA_0 + 1;

reg [DCA_LPARA_3-1:0] dca_signal_19;
reg [DCA_LPARA_3-1:0] dca_signal_05;
wire dca_signal_09;
wire dca_signal_01;

wire dca_signal_00;
wire dca_signal_12;
wire [DCA_LPARA_3-1:0] dca_signal_11;
wire dca_signal_15;

localparam  DCA_LPARA_1 = `MAX(DCA_GPARA_1,DCA_GPARA_3);

wire dca_signal_07;
wire dca_signal_06;
wire [DCA_LPARA_1-1:0] dca_signal_04;

wire dca_signal_13;
wire dca_signal_20;

always@(posedge dca_port_11, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_18 <= DCA_LPARA_2;
  else if(dca_port_03)
  begin
    if(dca_port_04)
      dca_signal_18 <= DCA_LPARA_2;
    else if(dca_port_05)
      dca_signal_18 <= DCA_LPARA_6;
    else if(dca_signal_10)
      dca_signal_18 <= DCA_LPARA_0;
    else if(dca_signal_18==DCA_LPARA_0)
      dca_signal_18 <= DCA_LPARA_6;
  end
end

assign dca_signal_14 = (dca_signal_18==DCA_LPARA_6);

always@(posedge dca_port_11, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_03 <= 0;
  else if(dca_port_03)
  begin
    if(dca_port_05)
      dca_signal_03 <= dca_port_00;
    else if(dca_signal_10)
      dca_signal_03 <= (dca_signal_03>>1);
  end
end

assign dca_signal_02 = dca_signal_14 & dca_signal_03[0];

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_4),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_0
(
  .clk(dca_port_11),
  .rstnn(dca_port_09),
  .enable(dca_port_03),
  .init(dca_signal_16),
  .count(dca_signal_10),
  .value(dca_signal_08),
  .is_first_count(),
  .is_last_count(dca_signal_17)
);

assign dca_signal_16 = dca_port_05;
assign dca_signal_10 = dca_signal_12 & dca_signal_15;

always@(posedge dca_port_11, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_19 <= 0;
  else if(dca_port_03)
  begin
    if(dca_port_05 || dca_signal_10)
      dca_signal_19 <= dca_port_08;
    else if(dca_signal_12)
      dca_signal_19 <= (dca_signal_19>>1);
  end
end

assign dca_signal_09 =  dca_signal_02 & dca_signal_19[0];

always@(posedge dca_port_11, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_05 <= 0;
  else if(dca_port_03)
  begin
    if(dca_port_05 || dca_signal_10)
      dca_signal_05 <= {dca_port_08,1'b 0};
    else if(dca_signal_12)
      dca_signal_05 <= (dca_signal_05>>1);
  end
end

assign dca_signal_01 = dca_signal_02 & dca_signal_05[0];

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_3),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_2
(
  .clk(dca_port_11),
  .rstnn(dca_port_09),
  .enable(dca_port_03),
  .init(dca_signal_00),
  .count(dca_signal_12),
  .value(dca_signal_11),
  .is_first_count(),
  .is_last_count(dca_signal_15)
);

assign dca_signal_00 = dca_port_05 | dca_signal_10;
assign dca_signal_12 = dca_signal_14 & dca_signal_20;
assign dca_signal_13 = dca_signal_09 | dca_signal_01;
assign dca_signal_20 = dca_signal_13? dca_signal_04[DCA_LPARA_1-1] : 1;

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_1),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_1
(
  .clk(dca_port_11),
  .rstnn(dca_port_09),
  .enable(dca_port_03),
  .init(dca_signal_07),
  .count(dca_signal_06),
  .value(dca_signal_04),
  .is_first_count(),
  .is_last_count()
);

assign dca_signal_07 = dca_port_05;
assign dca_signal_06 = dca_signal_13;

assign dca_port_01 = dca_signal_09 & dca_signal_04[0];
assign dca_port_12 = dca_signal_01 & dca_signal_04[0];

assign dca_port_04 = dca_signal_10 & dca_signal_17;

assign dca_port_02 = dca_signal_14 & dca_signal_15 & dca_signal_04[0];
assign dca_port_06 = dca_signal_14 & (~dca_signal_15) & dca_signal_04[0];
assign dca_port_07 = dca_signal_09 & dca_signal_04[DCA_GPARA_3-1];
assign dca_port_10 = dca_signal_01 & dca_signal_04[DCA_GPARA_1-1];

endmodule
