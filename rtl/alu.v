module alu #(
    parameter WIDTH = 16
) (
    input wire [WIDTH-1:0] i_a_or_m,
    input wire [WIDTH-1:0] i_d,
    input wire [5:0] i_comp,
    input wire [2:0] i_comp_jmp,
    output reg o_jmp,
    output reg [WIDTH-1:0] o_q
);

  always @(*) begin
    o_q = 0;
    case (i_comp)
      6'b101010: o_q = 0;
      6'b111111: o_q = 1;
      6'b111010: o_q = -1;
      6'b001100: o_q = i_d;
      6'b110000: o_q = i_a_or_m;
      6'b001101: o_q = ~i_d;
      6'b110001: o_q = ~i_a_or_m;
      6'b001111: o_q = -i_d;
      6'b110011: o_q = -i_a_or_m;
      6'b011111: o_q = i_d + 1;
      6'b110111: o_q = i_a_or_m + 1;
      6'b001110: o_q = i_d - 1;
      6'b110010: o_q = i_a_or_m - 1;
      6'b000010: o_q = i_d + i_a_or_m;
      6'b010011: o_q = i_d - i_a_or_m;
      6'b000111: o_q = i_a_or_m - i_d;
      6'b000000: o_q = i_d & i_a_or_m;
      6'b010101: o_q = i_d | i_a_or_m;
      default: begin
`ifdef VERILATOR
        assert (0);
`endif
      end
    endcase
  end

  always @(*) begin
    case (i_comp_jmp)
      3'b000: o_jmp = 0;
      3'b001: o_jmp = $signed(o_q) > 0;
      3'b010: o_jmp = $signed(o_q) == 0;
      3'b011: o_jmp = $signed(o_q) >= 0;
      3'b100: o_jmp = $signed(o_q) < 0;
      3'b101: o_jmp = $signed(o_q) != 0;
      3'b110: o_jmp = $signed(o_q) <= 0;
      3'b111: o_jmp = 1;
      default: begin
`ifdef VERILATOR
        assert (0);
`endif
      end
    endcase
  end
endmodule


