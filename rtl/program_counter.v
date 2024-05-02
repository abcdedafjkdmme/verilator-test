module program_counter #(
    parameter WIDTH = 16
) (
    output wire [WIDTH-1:0] o_data,
    input wire [WIDTH-1:0] i_data,
    input wire i_we,
    input wire i_increment,
    input wire i_reset,
    input wire i_clk
);

  reg [WIDTH-1:0] r_counter = 0;
  assign o_data = r_counter;

  always @(posedge i_clk) begin

    if (i_reset) begin
      r_counter <= 0;
    end else if (i_we) begin
      r_counter <= i_data;
    end else if (i_increment) begin
      r_counter <= r_counter + 1;
    end else begin
`ifdef VERILATOR
      assert (0);
`endif
    end

  end
endmodule
