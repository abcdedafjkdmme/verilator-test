`default_nettype none
module block_ram 
#(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 16
)
(
    input wire i_clk,
    input wire i_we, 
    input wire [ADDR_WIDTH-1:0] i_addr,
    input wire [DATA_WIDTH-1:0] i_data,
    output wire [DATA_WIDTH-1:0] o_data);

    reg [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    always @(posedge i_clk) 
        if (i_we)
            mem[i_addr] <= i_data;

    assign o_data = mem[i_addr];

endmodule