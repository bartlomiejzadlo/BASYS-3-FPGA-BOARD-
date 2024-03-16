`timescale 1 ns / 1 ps

module uart_ascii_hex_display(
    input  wire clk,
    input  wire rst,
    input  wire rx,
    input wire btnu,

    output wire tx,
    output wire [3:0] an,
    output wire [7:0] sseg
);

wire tick_btn; 
wire [7:0] rec_data, prev_rec_data; 

debounce u_debounce(
    .clk(clk), 
    .reset(rst), 
    .sw(btnu),
    .db_level(), 
    .db_tick(tick_btn)
);

uart u_uart(
    .clk(clk), 
    .reset(rst),
    .rx(rx),
    .tx_start(tick_btn), 
    .rx_data_out(rec_data),
    .rx_data_out_prev(prev_rec_data),
    .tx(tx)
);
    

    
disp_hex_mux u_disp(
    .clk(clk), 
    .reset(rst),
    .hex3(prev_rec_data[7:4]), 
    .hex2(prev_rec_data[3:0]), 
    .hex1(rec_data[7:4]), 
    .hex0(rec_data[3:0]),
    .dp_in(4'b1011), 
    .an(an), 
    .sseg(sseg)
);


endmodule
