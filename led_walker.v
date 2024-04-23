`default_nettype none
module led_walker #(
    parameter NUM_LEDS = 8
) (
    input wire i_clk,
    input wire i_req,
    output reg [NUM_LEDS-1:0] o_leds,
    output wire o_busy

);

reg[$clog2(NUM_LEDS)-1:0] r_counter = 0;

always @(posedge i_clk) begin
    r_counter <= r_counter + 1;
end

always @(*) begin
    o_leds = 0;
    if(i_req && !o_busy) begin
         o_leds[r_counter] = 1;
    end else begin
        o_leds = 0;
    end
end

assign o_busy = !(r_counter == 0);

endmodule
