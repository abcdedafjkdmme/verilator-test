`default_nettype none
module cpu_datapath (
    input wire i_clk,
    input wire i_reset,
    input wire [15:0] i_instr,
   // input wire [15:0] i_m,
   // output wire [15:0] o_m,
   // output wire [15:0] o_m_addr,
   // output wire o_m_we,
    output wire [15:0] o_pc
);

  wire o_pc_we;

  wire [15:0] o_alu_i_a_or_m;
  wire [15:0] o_alu_i_d;
  wire [5:0] o_alu_comp;
  wire [2:0] o_alu_comp_jmp;
  wire [15:0] alu_o;
  wire alu_jmp;

  wire [15:0] control_unit_o_pc;
  wire control_unit_o_pc_increment;


  wire [15:0] i_a_reg_data;
  wire [15:0] o_a_reg_data;
  wire o_a_we;
  wire [15:0] i_d_reg_data;
  wire [15:0] o_d_reg_data;
  wire o_d_we;
  
  wire [15:0] o_m_data;
  wire [15:0] control_unit_o_m_data;
  wire [15:0] control_unit_o_m_addr;
  wire  control_unit_o_m_we;


  register a_reg_i (
      .o_data (i_a_reg_data),
      .i_data (o_a_reg_data),
      .i_we   (o_a_we),
      .i_clk  (i_clk),
      .i_reset(i_reset)
  );

  register d_reg_i (
      .o_data (i_d_reg_data),
      .i_data (o_d_reg_data),
      .i_we   (o_d_we),
      .i_clk  (i_clk),
      .i_reset(i_reset)
  );

  alu alu_i (
      .i_a_or_m  (o_alu_i_a_or_m),
      .i_d       (o_alu_i_d),
      .i_comp    (o_alu_comp),
      .i_comp_jmp(o_alu_comp_jmp),
      .o_jmp     (alu_jmp),
      .o_q       (alu_o)
  );

  cpu_control_unit cpu_control_unit_i (
      .i_instr       (i_instr),
      .i_alu_o       (alu_o),
      .i_m           (o_m_data),
      .o_m           (control_unit_o_m_data),
      .o_m_we        (control_unit_o_m_we),
      .o_m_addr      (control_unit_o_m_addr),
      .i_a_reg_data  (i_a_reg_data),
      .o_a_reg_data  (o_a_reg_data),
      .o_a_we        (o_a_we),
      .i_d_reg_data  (i_d_reg_data),
      .o_d_reg_data  (o_d_reg_data),
      .o_d_we        (o_d_we),
      .i_alu_jmp     (alu_jmp),
      .o_alu_i_a_or_m(o_alu_i_a_or_m),
      .o_alu_i_d     (o_alu_i_d),
      .o_alu_comp    (o_alu_comp),
      .o_alu_comp_jmp(o_alu_comp_jmp),
      .o_pc          (control_unit_o_pc),
      .o_pc_we       (o_pc_we),
      .o_pc_increment(control_unit_o_pc_increment)
  );

  program_counter program_counter_i (
      .o_data     (o_pc),
      .i_data     (control_unit_o_pc),
      .i_we       (o_pc_we),
      .i_increment(control_unit_o_pc_increment),
      .i_reset    (i_reset),
      .i_clk      (i_clk)
  );

  block_ram block_ram_i (
      .i_clk (i_clk),
      .i_we  (control_unit_o_m_we),
      .i_addr(control_unit_o_m_addr),
      .i_data(control_unit_o_m_data),
      .o_data(o_m_data)
  );

endmodule
