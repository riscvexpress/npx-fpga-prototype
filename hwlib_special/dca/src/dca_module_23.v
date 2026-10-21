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





module DCA_MODULE_23
(
  dca_port_03,
  dca_port_00,
  dca_port_09,
  dca_port_07,

  dca_port_18,

  dca_port_12,
  dca_port_06,
  dca_port_01,
  dca_port_04,
  dca_port_11,
  dca_port_17,
  dca_port_16,

  dca_port_08,
  dca_port_05,
  dca_port_13,
  dca_port_10,

  dca_port_02,
  dca_port_14,
  dca_port_15
);





parameter DCA_GPARA_1 = 32;
parameter DCA_GPARA_2 = 32;
parameter DCA_GPARA_0 = 4;

input wire dca_port_03;
input wire dca_port_00;
input wire dca_port_09;
input wire dca_port_07;

input wire dca_port_18;

input wire dca_port_12;
input wire dca_port_06;
input wire dca_port_01;
input wire [DCA_GPARA_1-1:0] dca_port_04;
output reg dca_port_11;
output wire dca_port_17;
output wire [DCA_GPARA_0-1:0] dca_port_16;

input wire dca_port_08;
input wire [DCA_GPARA_0-1:0] dca_port_05;
output wire dca_port_13;
output wire [DCA_GPARA_2-1:0] dca_port_10;

input wire dca_port_02;
input wire [DCA_GPARA_2-1:0] dca_port_14;
output wire dca_port_15;

localparam  DCA_LPARA_0 = 4;

genvar i;

wire dca_signal_01;
reg [DCA_GPARA_0-1:0] dca_signal_04;
reg [DCA_GPARA_0-1:0] dca_signal_11;
reg [DCA_GPARA_2-1:0] dca_signal_12[DCA_GPARA_0-1:0];
wire [DCA_GPARA_2*DCA_GPARA_0-1:0] dca_signal_00;

wire dca_signal_09;
reg [DCA_GPARA_0-1:0] dca_signal_10;
wire [DCA_GPARA_0-1:0] dca_signal_08;
wire [DCA_GPARA_0-1:0] dca_signal_06;
wire [DCA_GPARA_0-1:0] dca_signal_02;
reg [DCA_GPARA_1-1:0] dca_signal_05[DCA_GPARA_0-1:0];

reg [DCA_LPARA_0-1:0] dca_signal_07[DCA_GPARA_0-1:0];
wire [DCA_GPARA_0-1:0] dca_signal_03;
wire [DCA_GPARA_0-1:0] dca_signal_13;

assign dca_signal_01 = dca_port_02 & dca_port_15;
assign dca_port_15 = 1;

always@(posedge dca_port_03, negedge dca_port_00)
begin
  if (dca_port_00 == 0) begin
    dca_signal_04 <= 1;
    dca_signal_11 <= 0;
  end else if (dca_port_09 | dca_port_18) begin
    dca_signal_04 <= 1;
    dca_signal_11 <= 0;
  end else if (dca_signal_01) begin
    dca_signal_04 <= {
      dca_signal_04, dca_signal_04[DCA_GPARA_0-1]
    };
    dca_signal_11 <= dca_signal_11 | dca_signal_04;
  end
end

generate
for (i = 0; i < DCA_GPARA_0; i = i + 1)
begin : i_generate_write_data
  always@(posedge dca_port_03, negedge dca_port_00) begin
    if (dca_port_00 == 0) dca_signal_12[i] <= 0;
    else if (dca_signal_01 & dca_signal_04[i]) dca_signal_12[i] <= dca_port_14;
  end
  assign dca_signal_00[DCA_GPARA_2*(i+1)-1-:DCA_GPARA_2] = dca_signal_12[i];
end
endgenerate

assign dca_signal_09 = dca_port_12 & dca_port_11 & dca_port_06 & (~dca_port_17);

always@(posedge dca_port_03, negedge dca_port_00)
begin
  if (dca_port_00 == 0) dca_signal_10 <= 1;
  else if (dca_port_09 | dca_port_18) dca_signal_10 <= 1;
  else if (dca_signal_09)
  dca_signal_10 <= {
    dca_signal_10, dca_signal_10[DCA_GPARA_0-1]
  };
end

generate
for (i = 0; i < DCA_GPARA_0; i = i + 1)
begin : i_generate_write_addr
  always@(posedge dca_port_03, negedge dca_port_00)
  begin
    if (dca_port_00 == 0)
      dca_signal_07[i] <= 0;
    else if (dca_port_09 | dca_port_18)
      dca_signal_07[i] <= 0;
    else if (dca_signal_03[i] & (~dca_signal_13[i]))
      dca_signal_07[i] <= {dca_signal_07[i], 1'b1};
    else if (dca_signal_13[i] & (~dca_signal_03[i]))
      dca_signal_07[i] <= {dca_signal_07[i][DCA_LPARA_0-1:1]};
  end
  assign dca_signal_03[i] = dca_port_12 & dca_port_11 & (dca_port_17? (dca_port_01? dca_port_16[i] : 0) : (dca_port_06? (dca_signal_10[i] & (~dca_signal_08[i])) : 0));
  assign dca_signal_13[i] = dca_port_08 & dca_port_13 & dca_port_05[i];
  assign dca_signal_08[i] = dca_signal_07[i][0];
  assign dca_signal_06[i] = dca_signal_07[i][1];
  assign dca_signal_02[i] = dca_signal_07[i][DCA_LPARA_0-1];

  always@(posedge dca_port_03, negedge dca_port_00)
  begin
    if (dca_port_00 == 0)
      dca_signal_05[i] <= 0;
    else if (dca_signal_09 & dca_signal_10[i])
      dca_signal_05[i] <= dca_port_04;
  end

  assign dca_port_16[i] = dca_signal_08[i] & (dca_port_04 == dca_signal_05[i]);
end
endgenerate

assign dca_port_17 = (dca_port_16 != 0);

always@(*)
begin
  dca_port_11 = 0;
  if (dca_port_17)
  begin
    if(!dca_port_01)
      dca_port_11 = 1;
    if((dca_port_16 & (~dca_signal_02))!= 0)
      dca_port_11 = 1;
  end
  else if(dca_port_06)
  begin
    if ((dca_signal_10 & (~dca_signal_08))!=0)
      dca_port_11 = 1;
    if ((dca_signal_10 & (~dca_signal_06) & dca_signal_11)!=0)
      dca_port_11 = 1;
  end
  else
    dca_port_11 = 1;
end

ERVP_MUX_WITH_ONEHOT_ENCODED_SELECT
#(
  .BW_DATA (DCA_GPARA_2),
  .NUM_DATA(DCA_GPARA_0)
)
i_dca_instance_0
(
  .data_input_list(dca_signal_00),
  .select(dca_port_05),
  .data_output(dca_port_10)
);

assign dca_port_13 = ((dca_signal_11 & dca_port_05) != 0);

endmodule
