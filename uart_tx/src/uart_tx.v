`default_nettype none
module uart_tx #(
    parameter WIDTH = 8
) (
    input wire [WIDTH-1:0] i_data,
    input wire i_wr,
    input wire i_clk,
    output wire o_busy,
    output reg o_uart_tx
);

  reg [WIDTH-1:0] r_data = 0;
  always @(posedge i_clk) begin
    if (i_wr && !o_busy) r_data <= i_data;
  end


  localparam IDLE = 0;
  integer r_state = IDLE;

  localparam IDLE_BIT = 1;
  localparam START_BIT = 0;
  localparam END_BIT = 1;
  localparam LAST_STATE = 8+1+1;

  always @(posedge i_clk) begin
    if(!i_wr && !o_busy) r_state <= IDLE;
    else if(r_state < LAST_STATE) r_state <= r_state + 1;
    else r_state <= IDLE;


    if (r_state == IDLE) o_uart_tx <= IDLE_BIT;
    else if (r_state == 1) o_uart_tx <= START_BIT;
    else if (r_state < LAST_STATE) o_uart_tx <= r_data[r_state-2];
    else if (r_state == LAST_STATE) o_uart_tx <= END_BIT;
    else begin
`ifdef FORMAL
      assert (0);
`endif
    end
  end

  assign o_busy = !(r_state == IDLE);




`ifdef FORMAL

  reg is_past_valid = 0;
  always @(posedge i_clk) begin
    is_past_valid <= 1;
  end

  always @(posedge i_clk) begin
    if ($past(r_state) == 1 && is_past_valid) assert(o_uart_tx == START_BIT);
    if ($past(i_wr) && $past(r_state) != IDLE && $past(r_state) != LAST_STATE && is_past_valid) assert(r_state == $past(r_state) + 1);
    if ($past(r_state) == LAST_STATE && is_past_valid) assert(r_state == IDLE);
    if (!o_busy) assert (r_state == IDLE);
    if ($past(r_state) == IDLE && is_past_valid) assert (o_uart_tx == IDLE_BIT);
    if ($past(r_state) == LAST_STATE && is_past_valid) assert(o_uart_tx == END_BIT);
    if ($past(r_state) > 1 && $past(r_state) < LAST_STATE && is_past_valid) assert(o_uart_tx == r_data[$past(r_state) - 2]);
  end
`endif
endmodule
