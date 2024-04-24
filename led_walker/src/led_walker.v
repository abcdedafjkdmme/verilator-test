`default_nettype none
module led_walker #(
    parameter NUM_LEDS = 8
) (
    input wire i_clk,
    input wire i_reset,
    /* verilator lint_off UNUSED */
    input wire [$clog2(NUM_LEDS)-1:0] i_addr,
    input wire i_cyc,
    /* lint_on */
    input wire i_we,
    input wire i_data,
    input wire i_stb,
    output reg o_ack,
    output wire o_stall,
    output wire [NUM_LEDS-1:0] o_data

);


  //  reg r_busy = 0;
  //  reg [NUM_LEDS-1:0] r_leds = 0;


  //  always @(posedge i_clk) begin
  //    o_ack <= (i_stb) && (!o_stall);
  //  end
  //  assign o_stall = r_busy && i_we;
  //  assign o_data  = r_leds;
  //
  //  reg [$clog2(NUM_LEDS)-1:0] r_state = 0;
  //  always @(posedge i_clk) begin
  //    if (i_stb && !r_busy) begin
  //      r_state <= i_addr + 1;
  //      /* verilator lint_off WIDTH */
  //    
  //    end else if (r_state == (NUM_LEDS - 1)) begin
  //      /* lint_on*/
  //      r_state <= 0;
  //    end else if (r_state != 0) begin
  //      r_state <= r_state + 1;
  //    end
  //  end
  //  assign r_busy = (r_state != 0);
  //
  //  always @(*) 
  //    r_leds = 0;
  //    if (r_state != 0) r_leds[r_state-1] = 1;
  //  end

  reg [NUM_LEDS-1:0] r_leds = 0;
  assign o_data = r_leds;
  reg [$clog2(NUM_LEDS)-1:0] r_counter = 0;

  // always @(posedge i_clk) begin
  //   if (i_reset) r_counter <= 0;
  //   else if (i_we && r_state == WRITE && r_counter == 0) r_counter <= i_addr;
  //   else if (r_state == WRITE) r_counter <= r_counter + 1;
  // end

  localparam IDLE = 0;
  localparam WRITE = 1;
  localparam READ = 2;
  localparam FINISHED = 3;
  integer r_state = IDLE;

  wire w_busy;
  assign w_busy = (r_state != IDLE);
  assign o_stall = w_busy;

  always @(posedge i_clk) begin

//   if (i_reset || (r_state == FINISHED)) r_state <= IDLE;
//   else if (i_stb && i_we && !w_busy) r_state <= WRITE;
//   else if (i_stb && !i_we && !w_busy) r_state <= READ;
//   /* verilator lint_off WIDTH */
//   else if (i_stb && (r_state == READ) || r_counter == (NUM_LEDS - 1)) r_state <= FINISHED;
//   /* lint_on*/
//   else r_state <= IDLE;

    case (r_state)
      IDLE: begin
        if      ( i_we && !o_stall && i_stb) r_state <= WRITE;
        else if ( !i_we && !o_stall && i_stb) r_state <= READ;
      end
      WRITE: begin
        /* verilator lint_off WIDTH */
        if( r_counter == (NUM_LEDS - 1)) r_state <= FINISHED;
        else r_state <= WRITE;
        /* lint_on*/
      end
      READ: begin
        r_state <= FINISHED;
      end
      FINISHED: begin
        r_state <= IDLE;
      end
      default: begin
        `ifdef FORMAL
        assert(0);
        `endif
      end
    endcase
  end

  always @(posedge i_clk) begin
    if(i_reset) r_counter <= 0;

    case (r_state)
      IDLE: begin
        o_ack  <= 0;
        if (i_we && r_counter == 0) r_counter <= i_addr;
      end
      WRITE: begin
        o_ack <= 0;
        r_counter <= r_counter + 1;

        r_leds = 0;
        r_leds[r_counter] = 1;
        
      end
      READ: begin
        o_ack  <= 0;
      end
      FINISHED: begin
        o_ack  <= 1;
      end
`ifdef FORMAL
      default: assert (0);
`endif
    endcase
  end

`ifdef FORMAL

  always @(*) begin
    assert (r_state < NUM_LEDS);
    if(i_stb) assert (w_busy == (r_state != IDLE));
  end

  reg is_past_valid = 0;
  always @(posedge i_clk) begin
    is_past_valid <= 1;
  end

  always @(posedge i_clk) begin
    if ($past(i_stb) && (!$past(i_reset)) && (!$past(o_stall)) && $past(i_we) && is_past_valid) assert(r_state == WRITE);
    if ($past(i_stb) && $past(r_state) == WRITE && $past(r_counter) == (NUM_LEDS - 1) && is_past_valid) assert(r_state == FINISHED);
    if ($past(i_stb) && (!$past(i_we)) && is_past_valid && ($past(r_state) == READ)) assert(r_state == FINISHED);
    if($past(i_stb) && $past(r_state) == IDLE && $past(i_we) && $past(r_counter) == 0 && is_past_valid) assert(r_counter == $past(i_addr));
    if($past(i_stb) && $past(r_state) == WRITE && $past(r_counter) != 0 && is_past_valid) assert(o_data == (1 << $past(r_counter)));
    
  end

`endif

endmodule
