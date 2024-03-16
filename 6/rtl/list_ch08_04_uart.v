//Listing 8.4
module uart
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      parameter DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                DVSR = 326,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                DVSR_BIT = 9, // # bits of DVSR
                FIFO_W = 1    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
   )
   (
    input wire clk, reset,
    input wire rx,
    input wire tx_start,
    output wire tx,
    output wire [7:0] rx_data_out,
    output wire [7:0] rx_data_out_prev
   );

   // signal declaration
   wire tick, rx_done_tick, tx_done_tick;


   //body
   mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
      (.clk(clk), .reset(reset), .q(), .max_tick(tick));

   uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
      (.clk(clk), .reset(reset), .rx(rx), .s_tick(tick),
       .rx_done_tick(rx_done_tick), .dout(rx_data_out));

   fifo #(.B(DBIT), .W(FIFO_W)) fifo_rx_unit
      (.clk(clk), .reset(reset), .rd(1'b1),
       .wr(rx_done_tick), .w_data(rx_data_out),
       .r_data(rx_data_out_prev));


   uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit
      (.clk(clk), .reset(reset), .tx_start(tx_start),
       .s_tick(tick), .din(rx_data_out),
       .tx_done_tick(tx_done_tick), .tx(tx));


endmodule