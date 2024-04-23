module blinky #(
    parameter WIDTH = 2
) (
    input  wire i_clk,
    output wire o_led
);
  reg [WIDTH-1:0] r_counter = 0;

  always @(posedge i_clk) begin
    r_counter <= r_counter + 1;
  end

  assign o_led = r_counter[WIDTH-1];


endmodule

