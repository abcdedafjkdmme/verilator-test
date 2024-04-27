`include "uart_tx_comb.v"

`default_nettype none
module uart_tx #(
    parameter WIDTH = 8
) (
    input wire i_stb,
    input wire [WIDTH-1:0] i_data,
    input wire i_wr,
    input wire i_clk,
    output wire o_busy,
    output reg o_uart_tx
);

  reg [WIDTH-1:0] r_data = 0;
  always @(posedge i_clk) begin
    if (i_wr && !o_busy && i_stb) r_data <= i_data;
  end


  localparam IDLE = 0;
  localparam LAST_STATE = 8 + 1 + 1;
  integer r_state = IDLE;

  always @(posedge i_clk) begin
    if (!i_wr && !o_busy) r_state <= IDLE;
    else if (r_state < LAST_STATE && i_stb) r_state <= r_state + 1;
    else r_state <= IDLE;
  end

  assign o_busy = !(r_state == IDLE);

  uart_tx_comb uart_tx_comb_inst(
    .r_state   (r_state   ),
    .r_data    (r_data    ),
    .o_uart_tx (o_uart_tx )
  );
  

`ifdef FORMAL

  reg is_past_valid = 0;
  always @(posedge i_clk) begin
    is_past_valid <= 1;
  end

  localparam IDLE_BIT = 1;
  localparam START_BIT = 0;
  localparam END_BIT = 1;
  

  always @(posedge i_clk) begin
    if ( (i_wr) && (r_state) != IDLE && (r_state) != LAST_STATE)
      assert (r_state == $past(r_state) + 1);
    if ( $past(r_state) == LAST_STATE && is_past_valid) assert (r_state == IDLE);
  end

  always @(*) begin
    if ( (r_state) == 1 ) assert (o_uart_tx == START_BIT);
    if (!o_busy) assert (r_state == IDLE);
    if (r_state == IDLE) assert (!o_busy);

    if (r_state== IDLE) assert (o_uart_tx == IDLE_BIT);
    if ( (r_state) == LAST_STATE) assert (o_uart_tx == END_BIT);
    if ( (r_state) > 1 && (r_state) < LAST_STATE)
      assert (o_uart_tx == r_data[r_state-2]);
  end

  cover property(o_uart_tx == 1);
`endif
endmodule
