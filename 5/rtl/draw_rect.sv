/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: BZ
 *
 * Description:
 * Draw rectangle.
 */


 `timescale 1 ns / 1 ps

`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr,

    vga_if.in in,
    vga_if.out out

);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt, rgb, rgb2;
logic [5:0] addrx, addry;
logic [10:0] hcount, vcount;
logic hsync, hblnk, vsync, vblnk;

logic [10:0] hcount2, vcount2;
logic hsync2, hblnk2, vsync2, vblnk2;
/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vcount <= '0;
        vsync  <= '0;
        vblnk  <= '0;
        hcount <= '0;
        hsync  <= '0;
        hblnk  <= '0;
        rgb    <= '0;
    end else begin
        vcount <= in.vcount;
        vsync  <= in.vsync;
        vblnk  <= in.vblnk;
        hcount <= in.hcount;
        hsync  <= in.hsync;
        hblnk  <= in.hblnk;
        rgb    <= in.rgb;

    end
end
 

always_ff @(posedge clk) begin : bg_ff_blk2
    if (rst) begin
        vcount2 <= '0;
        vsync2  <= '0;
        vblnk2  <= '0;
        hcount2 <= '0;
        hsync2  <= '0;
        hblnk2  <= '0;
        rgb2    <= '0;
    end else begin
        vcount2 <= vcount;
        vsync2  <= vsync;
        vblnk2  <= vblnk;
        hcount2 <= hcount;
        hsync2  <= hsync;
        hblnk2  <= hblnk;
        rgb2    <= rgb;
    end
end





always_ff @(posedge clk) begin
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
        pixel_addr <= '0;
    end else begin
        out.vcount <= vcount2;
        out.vsync  <= vsync2;
        out.vblnk  <= vblnk2;
        out.hcount <= hcount2;
        out.hsync  <= hsync2;
        out.hblnk  <= hblnk2;
        out.rgb    <= rgb_nxt;
        pixel_addr <= {addry, addrx};
    end
end



always_comb begin 
        if((in.hcount >= xpos+2) && (in.hcount <= xpos + W_OF_REC) && (in.vcount >= ypos) && (in.vcount <= ypos + H_OF_REC)) 
            rgb_nxt = rgb_pixel;      
        else                                    
            rgb_nxt = rgb2;         
end

always_comb begin
    addry = in.vcount - ypos;
    addrx = in.hcount - xpos;
end

endmodule
