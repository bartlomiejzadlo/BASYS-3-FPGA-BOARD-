`timescale 1 ns / 1 ps

module top_uart(
    input  wire clk,
    input  wire rst,
    input  wire rx, 
    input  wire loopback_enable,
    input wire btnu,

    output wire tx,
    output wire tx_monitor,
    output wire rx_monitor,
    output wire [3:0] an,
    output wire [7:0] sseg
);


uart_monitor u_uart_monitor (
    .clk(clk),
    .rx(rx),
    .loopback_enable(loopback_enable),
    .tx(),
    .tx_monitor(tx_monitor),
    .rx_monitor(rx_monitor)
);

uart_ascii_hex_display u_uart_ascii_hex_display(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .btnu(btnu),
    .tx(tx),
    .an(an),
    .sseg(sseg)
);



endmodule
