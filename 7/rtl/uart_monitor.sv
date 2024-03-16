`timescale 1 ns / 1 ps

module uart_monitor(
    input logic clk,
    input logic rx,
    input logic loopback_enable,
    
    output logic tx,
    output logic tx_monitor,
    output logic rx_monitor
);

always_ff @(posedge clk) begin: uart_blk
    if(loopback_enable) begin
        tx <= rx;
    end else begin
        tx <= '0;
    end
    tx_monitor <= tx;
    rx_monitor <= rx;
end



endmodule