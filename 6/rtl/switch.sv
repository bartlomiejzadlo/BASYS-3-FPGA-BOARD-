`timescale 1 ns / 1 ps

module switch(
    input logic btnu,
    input logic ascii_tx_in,
    input logic monitor_tx_in,

    output logic tx_out
);

always_comb begin: switch_blk
    if(btnu) begin
        tx_out = ascii_tx_in;
    end else begin
        tx_out = monitor_tx_in;
    end
end



endmodule