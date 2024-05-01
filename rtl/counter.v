module counter #(
    parameter WIDTH = 8
) (
    input  wire             i_clk,
    input  wire             i_reset,
    input  wire             i_enable,
    output reg  [WIDTH-1:0] o_data
);

  always @(posedge i_clk) begin
    if (i_reset) o_data <= 0;
    else if (i_enable) o_data <= o_data + 1;
  end

endmodule
