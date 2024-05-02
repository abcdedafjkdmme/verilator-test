`default_nettype none
module cpu_datapath (
    input wire i_clk,
    input wire [15:0] i_instr,
    input wire [15:0] i_m,
    output wire [15:0] o_m,
    output wire [15:0] o_m_addr,
    output wire o_m_we,
    input wire [15:0] i_a_reg_data,
    output wire [15:0] o_a_reg_data,
    output wire o_a_we,
    input wire [15:0] i_d_reg_data,
    output wire [15:0] o_d_reg_data,
    output wire o_d_we,
    input wire [15:0] i_pc,
    output reg [15:0] o_pc
);

    wire o_pc_we;
    
    always @(posedge i_clk) begin
        o_pc <= o_pc_we ? control_unit_o_pc : (i_pc + 1);
    end

    wire [15:0] o_alu_i_a_or_m;
    wire [15:0] o_alu_i_d;
    wire [5:0] o_alu_comp;
    wire [2:0] o_alu_comp_jmp;
    wire [15:0] alu_o;
    wire alu_jmp;

    wire [15:0] control_unit_o_pc;

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
      .i_m           (i_m),
      .o_m           (o_m),
      .o_m_we        (o_m_we),
      .o_m_addr      (o_m_addr),
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
      .o_pc_we       (o_pc_we)
  );

endmodule
