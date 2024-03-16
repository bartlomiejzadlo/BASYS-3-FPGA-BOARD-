`timescale 1ns / 1ps


module memory_write
    #(WIDTH = 16)
    (
    input wire clk,
    input wire reset,
    input wire rx_done,
    input wire [7:0] data,

    output wire ram_enable,
    output wire [7:0] ram_wa,
    output wire [WIDTH-1:0] ram_din
    );
    
    reg [WIDTH-1:0] ram, ram_nxt;
    reg [5:0] ctr = -1, ctr_nxt = -1;
    
    
    always_ff@(posedge clk) begin
        if(reset) begin
            ctr <= -1;
            ram <= 0;
        end else begin
            ram <= ram_nxt;
            ctr <= ctr_nxt;
        end
    end
    
    always_comb begin
        if(rx_done) begin
            ctr_nxt = ctr + 1;
            ram_nxt[15:8] = ram[7:0];
            ram_nxt[7:0] = data;
        end else begin
            ram_nxt = ram;
            ctr_nxt = ctr;
        end
    end
    

    assign ram_din = ram;
    assign ram_enable = ctr[0];
    assign ram_wa = {3'b000, ctr[5:1]};
    
endmodule