`default_nettype none
module cpu_control_unit 
(
    input wire [15:0] i_instr,
    input wire [15:0] i_alu_o,
    input wire [15:0] i_m,
    output reg [15:0] o_m,
    output wire [15:0] o_m_addr,
    output reg o_m_we,
    input wire [15:0] i_a_reg_data,
    output reg [15:0] o_a_reg_data,
    output reg o_a_we,
    input wire [15:0] i_d_reg_data,
    output reg [15:0] o_d_reg_data,
    output reg o_d_we,
    input wire i_alu_jmp,
    output wire [15:0] o_alu_i_a_or_m,
    output wire [15:0] o_alu_i_d,
    output reg [5:0] o_alu_comp,
    output reg [2:0] o_alu_comp_jmp,
    output reg [15:0] o_pc,
    output reg o_pc_we
);

  `define INSTR_GET_COMP(instr) instr[11:6]
  `define INSTR_GET_DEST(instr) instr[5:3]
  `define INSTR_GET_JMP(instr) instr[2:0]
  `define INSTR_GET_A(instr) instr[12]
  `define IS_A_INSTR(instr) (instr[15] == 0)
  `define IS_C_INSTR(instr) (instr[15:13] == 3'b111)

  

  assign o_alu_i_a_or_m = `INSTR_GET_A(i_instr) ? i_m : i_a_reg_data;
  assign o_alu_i_d = i_d_reg_data;
  assign o_alu_comp = `INSTR_GET_COMP(i_instr);
  assign o_alu_comp_jmp = `INSTR_GET_JMP(i_instr);

  assign o_m_addr = i_a_reg_data;

  assign o_m = i_alu_o;
  assign o_a_reg_data = `IS_A_INSTR(i_instr) ? i_instr : i_alu_o;
  assign o_d_reg_data = i_alu_o;

  assign o_pc = i_a_reg_data;
  assign o_pc_we = i_alu_jmp && `IS_C_INSTR(i_instr);

  always @(*) begin

    o_a_we = 0;
    o_d_we = 0;
    o_m_we = 0;

    if (`IS_A_INSTR(i_instr)) begin
      o_a_we = 1;
    end else if (`IS_C_INSTR(i_instr)) begin
      case (
      `INSTR_GET_DEST(i_instr)
      )
        3'b000: {o_a_we, o_m_we, o_d_we} = 'b000;
        3'b001: {o_m_we} = 1;
        3'b010: {o_d_we} = 1;
        3'b011: {o_m_we, o_d_we} = 'b11;
        3'b100: {o_a_we} = 1;
        3'b101: {o_a_we, o_m_we} = 'b11;
        3'b110: {o_a_we, o_d_we} = 'b11;
        3'b111: {o_a_we, o_m_we, o_d_we} = 'b111;

        default: begin
`ifdef VERILATOR
          assert (0);
`endif
        end
      endcase
    end else begin
`ifdef VERILATOR
      assert (0);
`endif
    end
  end


endmodule
