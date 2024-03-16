/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author:
 *
 * Description:
 * Draw mouse
 */


`timescale 1 ns / 1 ps

module draw_mouse (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,

    vga_if.in in,
    vga_if.out out

);

import vga_pkg::*;


 /**
  * Internal logic
  */
 
always_ff @(posedge clk) begin : mouse_ff_blk
    if(rst) begin
        out.hblnk <= '0;
        out.hcount <= '0;
        out.hsync <= '0;
        out.vblnk <= '0;
        out.vcount <= '0;
        out.vsync <= '0;
        
    end else begin 
        out.hblnk <= in.hblnk;
        out.hcount <= in.hcount;
        out.hsync <= in.hsync;
        out.vblnk <= in.vblnk;
        out.vcount <= in.vcount;
        out.vsync <= in.vsync;
        
    end


end

MouseDisplay uMouseDisplay (
    .rgb_in(in.rgb),
    .xpos,
    .ypos,
    .hcount(in.hcount),
    .vcount(in.vcount),
    .pixel_clk(clk),
    .blank(in.hblnk||in.vblnk),
    .rgb_out(out.rgb),
    .enable_mouse_display_out()
    
);

endmodule
