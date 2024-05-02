module register 
#(parameter WIDTH = 16)
(
    output wire [WIDTH-1:0] o_data,
    input wire [WIDTH-1:0] i_data,
    input wire i_we,
    input wire i_clk,
    input wire i_reset
);

reg [WIDTH-1:0] r_data = 0; 
assign o_data = r_data;

always @(posedge i_clk) begin
    if(i_reset) r_data <= 0;
    else if(i_we) r_data <= i_data; 
end
endmodule