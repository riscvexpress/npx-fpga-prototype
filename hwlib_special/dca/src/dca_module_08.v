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




module DCA_MODULE_08
(
  dca_port_11,
  dca_port_21,
  dca_port_19,
  dca_port_20,
  dca_port_09,

  dca_port_22,
  dca_port_18,
  dca_port_08,

  dca_port_05,
  dca_port_01,
  dca_port_17,

  dca_port_03,
  dca_port_04,
  dca_port_06,
  dca_port_14,
  dca_port_13,
  dca_port_07,
  dca_port_15,
  dca_port_00,
  dca_port_02,
  dca_port_12,
  dca_port_16,
  dca_port_10
);




parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_0.vh"

input wire dca_port_11;
input wire dca_port_21;
input wire dca_port_19;
input wire dca_port_20;
output wire dca_port_09;

localparam  DCA_LPARA_1 = `BW_DCA_MATRIX_MAC_INST;

input wire dca_port_22;
input wire [DCA_LPARA_1-1:0] dca_port_18;
output wire dca_port_08;
input wire dca_port_05;
input wire dca_port_01;
input wire dca_port_17;

input wire dca_port_03;
output wire dca_port_04;
output reg [BW_BLOCKED_STEP_INST-1:0] dca_port_06;

input wire dca_port_14;
output wire dca_port_13;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_07;

input wire dca_port_15;
output wire dca_port_00;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_02;

input wire dca_port_12;
output wire dca_port_16;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_10;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_54;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_59;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_63;
wire [`BW_DCA_MATRIX_MAC_OPCODE-1:0] dca_signal_20;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_29;
wire dca_signal_28;
wire dca_signal_19;
wire dca_signal_30;
reg dca_signal_06;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_17;
wire dca_signal_67;
wire dca_signal_68;
wire dca_signal_64;
wire dca_signal_55;
wire dca_signal_49;
wire dca_signal_48;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_56;
wire dca_signal_53;
wire dca_signal_04;
wire dca_signal_09;
reg dca_signal_13;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_40;
wire dca_signal_34;
wire dca_signal_05;
wire dca_signal_52;
wire dca_signal_35;
wire dca_signal_18;
wire dca_signal_45;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_12;
wire dca_signal_38;
wire dca_signal_44;
wire dca_signal_36;
reg dca_signal_42;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_33;
wire dca_signal_37;
wire dca_signal_41;
wire dca_signal_58;
wire dca_signal_62;
wire dca_signal_51;
wire dca_signal_21;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_25;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_65;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_07;

localparam  DCA_LPARA_0 = 1;
localparam  DCA_LPARA_3 = 0;
localparam  DCA_LPARA_4 = 1;

reg [DCA_LPARA_0-1:0] dca_signal_39;
wire dca_signal_57;
wire dca_signal_11;
wire dca_signal_43;
wire dca_signal_00;

reg dca_signal_24;

localparam  DCA_LPARA_2 = 3;

reg [DCA_LPARA_2-1:0] dca_signal_50;
wire dca_signal_70;
wire dca_signal_32;

wire dca_signal_69;
wire dca_signal_08;
wire dca_signal_16;
wire dca_signal_27;
wire dca_signal_26;
wire dca_signal_14;

wire dca_signal_66;
wire dca_signal_10;
wire dca_signal_60;
wire dca_signal_31;
wire dca_signal_61;
wire dca_signal_23;
wire dca_signal_22;
wire dca_signal_02;
wire dca_signal_01;

wire [MATRIX_NUM_ROW-1:0] dca_signal_15;
wire [MATRIX_NUM_COL-1:0] dca_signal_46;
wire [MATRIX_MAX_DIM-1:0] dca_signal_03;

wire [MATRIX_NUM_ROW-1:0] dca_signal_47;

assign {dca_signal_20,dca_signal_63,dca_signal_59,dca_signal_54} = dca_port_18;

assign dca_signal_66 = dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_MULT_COND];
assign dca_signal_10 = 0;
assign dca_signal_60 = dca_signal_66 & dca_signal_67;
assign dca_signal_31 = dca_signal_66 & dca_signal_68;
assign dca_signal_61 = dca_signal_10;
assign dca_signal_23 = dca_signal_10;

assign dca_signal_22 = dca_signal_60 | dca_signal_61;
assign dca_signal_02 = dca_signal_31 | dca_signal_23;

assign dca_signal_01 = dca_signal_48 & dca_signal_21;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_1
(
  .clk(dca_port_11),
  .rstnn(dca_port_21),
  .clear(dca_port_19),
  .enable(dca_port_20),

  .matrix_info(dca_signal_29),
  .init(dca_signal_28),
  .is_col_first(dca_signal_19),
  .iterate(dca_signal_30),
  .go_next_base(dca_signal_06),

  .block_info(dca_signal_17),
  .is_first_x(dca_signal_67),
  .is_last_x(dca_signal_68),
  .is_first_y(dca_signal_64),
  .is_last_y(dca_signal_55),
  .is_first_element(dca_signal_49),
  .is_last_element(dca_signal_48),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_29 = dca_signal_54;
assign dca_signal_28 = dca_signal_57;
assign dca_signal_19 = 1;
assign dca_signal_30 = dca_signal_00 & dca_signal_08;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_0
(
  .clk(dca_port_11),
  .rstnn(dca_port_21),
  .clear(dca_port_19),
  .enable(dca_port_20),

  .matrix_info(dca_signal_56),
  .init(dca_signal_53),
  .is_col_first(dca_signal_04),
  .iterate(dca_signal_09),
  .go_next_base(dca_signal_13),

  .block_info(dca_signal_40),
  .is_first_x(dca_signal_34),
  .is_last_x(dca_signal_05),
  .is_first_y(dca_signal_52),
  .is_last_y(dca_signal_35),
  .is_first_element(dca_signal_18),
  .is_last_element(dca_signal_45),
  .valid_row_list(dca_signal_47),
  .valid_col_list()
);

assign dca_signal_56 = dca_signal_59;
assign dca_signal_53 = dca_signal_57;
assign dca_signal_04 = ~dca_signal_66;
assign dca_signal_09 = dca_signal_00 & dca_signal_16;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_2
(
  .clk(dca_port_11),
  .rstnn(dca_port_21),
  .clear(dca_port_19),
  .enable(dca_port_20),

  .matrix_info(dca_signal_12),
  .init(dca_signal_38),
  .is_col_first(dca_signal_44),
  .iterate(dca_signal_36),
  .go_next_base(dca_signal_42),

  .block_info(dca_signal_33),
  .is_first_x(dca_signal_37),
  .is_last_x(dca_signal_41),
  .is_first_y(dca_signal_58),
  .is_last_y(dca_signal_62),
  .is_first_element(dca_signal_51),
  .is_last_element(dca_signal_21),
  .valid_row_list(dca_signal_15),
  .valid_col_list(dca_signal_46)
);

assign dca_signal_12 = dca_signal_63;
assign dca_signal_38 = dca_signal_57;
assign dca_signal_44 = 1;
assign dca_signal_36 = dca_signal_00 & dca_signal_27;

always@(*)
begin
  dca_signal_06 = 0;
  dca_signal_13 = 0;
  dca_signal_42 = 0;
  if(dca_signal_00 && dca_signal_11)
  begin
    if(dca_signal_66)
    begin
      dca_signal_06 = dca_signal_31 & dca_signal_41;
      dca_signal_13 = dca_signal_05;
      dca_signal_42 = dca_signal_31 & dca_signal_41;
    end
    else
    begin
      dca_signal_06 = dca_signal_68;
      dca_signal_13 = dca_signal_05;
      dca_signal_42 = dca_signal_41;
    end
  end
end

assign dca_signal_69 = dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_INIT_ACC] & dca_signal_22;
assign dca_signal_08 = (~dca_signal_26) & dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_16 = (~dca_signal_26) & dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU1_REQ];
assign dca_signal_27 = dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU2_REQ] & (~dca_signal_26) & (dca_signal_66? dca_signal_31 : 1);
assign dca_signal_26 = dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC] & (~dca_signal_24);
assign dca_signal_14 = dca_signal_27 | dca_signal_26;

always@(posedge dca_port_11, negedge dca_port_21)
begin
  if(dca_port_21==0)
    dca_signal_39 <= DCA_LPARA_3;
  else if(dca_port_20)
    case(dca_signal_39)
      DCA_LPARA_3:
        if(dca_signal_57)
          dca_signal_39 <= DCA_LPARA_4;
      DCA_LPARA_4:
        if(dca_signal_43)
          dca_signal_39 <= DCA_LPARA_3;
    endcase
end

assign dca_signal_57 = (dca_signal_39==DCA_LPARA_3) & dca_port_22;
assign dca_signal_00 = dca_port_03 & dca_port_04;
assign dca_signal_11 = dca_signal_20[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC]? dca_signal_24 : 1;
assign dca_signal_43 = dca_signal_00 & dca_signal_01 & dca_signal_11;

always@(posedge dca_port_11, negedge dca_port_21)
begin
  if(dca_port_21==0)
    dca_signal_24 <= 0;
  else if(dca_signal_00)
  begin
    if(dca_signal_24 && dca_signal_02)
      dca_signal_24 <= 0;
    else if(dca_signal_26)
      dca_signal_24 <= 1;
  end
end

always@(posedge dca_port_11, negedge dca_port_21)
begin
  if(dca_port_21==0)
    dca_signal_50 <= 1;
  else if(dca_signal_32)
  begin
    if(dca_signal_00 & dca_signal_70)
      ;
    else
      dca_signal_50 <= dca_signal_50>>1;
  end
  else if(dca_signal_00 & dca_signal_70)
    dca_signal_50 <= dca_signal_50<<1;
end

assign dca_signal_70 = dca_signal_08 | dca_signal_16 | dca_signal_26;
assign dca_signal_32 = dca_port_05 | dca_port_01 | dca_port_17;

assign dca_port_08 = dca_signal_43;

assign dca_port_04 = (dca_signal_39==DCA_LPARA_4) & dca_port_03 & (dca_signal_08? dca_port_14 : 1) & (dca_signal_16? dca_port_15 : 1) & (dca_signal_14? dca_port_12 : 1) & ((dca_signal_70)? (~dca_signal_50[DCA_LPARA_2-1]) : 1);

assign dca_signal_03 = dca_signal_47;

always@(*)
begin
  dca_port_06 = {dca_signal_03, dca_signal_15, dca_signal_46, dca_signal_01, dca_signal_20};
  if(dca_signal_26)
    dca_port_06[`BW_DCA_MATRIX_MAC_OPCODE-1:0] = `DCA_MATRIX_MAC_OPCODE_NO_CAL;
  dca_port_06[`DCA_MATRIX_MAC_OPCODE_INDEX_INIT_ACC] = dca_signal_69;
  dca_port_06[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU0_REQ] = dca_signal_08;
  dca_port_06[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU1_REQ] = dca_signal_16;
  dca_port_06[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU2_REQ] = dca_signal_27;
  dca_port_06[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC] = dca_signal_26;
end

assign dca_port_13 = dca_port_04 & dca_signal_08;
assign dca_port_00 = dca_port_04 & dca_signal_16;
assign dca_port_16 = dca_port_04 & dca_signal_14;

assign dca_signal_25 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_65 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_07 = dca_signal_26? `DCA_MATRIX_LSU_INST_OPCODE_READ : `DCA_MATRIX_LSU_INST_OPCODE_WRITE;

assign dca_port_07 = {dca_signal_17, dca_signal_25};
assign dca_port_02 = {dca_signal_40, dca_signal_65};
assign dca_port_10 = {dca_signal_33, dca_signal_07};

assign dca_port_09 = (dca_signal_39==DCA_LPARA_4);

endmodule
