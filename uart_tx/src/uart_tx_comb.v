`default_nettype none
module uart_tx_comb #(
    parameter WIDTH = 8,
    parameter STATES_WIDTH = 32,
    parameter IDLE = 0,
    parameter LAST_STATE = 8 + 1 + 1,
    parameter IDLE_BIT = 1,
    parameter START_BIT = 0,
    parameter END_BIT = 1
) (
    input wire[STATES_WIDTH-1:0] r_state,
    input wire[WIDTH-1:0] r_data,
    output reg o_uart_tx
);
  always @(*) begin
    o_uart_tx = 0;
    if (r_state == IDLE) o_uart_tx = IDLE_BIT;
    else if (r_state == 1) o_uart_tx = START_BIT;
    else if (r_state > 1 && r_state < LAST_STATE) o_uart_tx = r_data[r_state-2];
    else if (r_state == LAST_STATE) o_uart_tx = END_BIT;
    else begin
`ifdef FORMAL
      assert (0);
`endif
    end
  end
endmodule