`timescale 1 ns / 1 ps

module top_micro(
    input  wire clk,
    input  wire rx, 
    input  wire loopback_enable,

    output wire tx_monitor,
    output wire rx_monitor
);


uart_monitor u_uart_monitor (
    .clk(clk),
    .rx(rx),
    .loopback_enable(loopback_enable),
    .tx(),
    .tx_monitor(tx_monitor),
    .rx_monitor(rx_monitor)
);


endmodule
