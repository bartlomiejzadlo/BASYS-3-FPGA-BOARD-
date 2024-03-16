/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 *
 *
 * Description:
 * 
 */


 `timescale 1 ns / 1 ps

 module draw_rect_char (
    input  logic clk,
    input  logic rst,
    input  reg [7:0] char_pixels,
    output logic [7:0] char_xy,
    output logic [3:0] char_line,
 
    vga_if.in in,
    vga_if.out out
 
 );
 


 /**
  * Local variables and signals
  */
 import vga_pkg::*;

logic [10:0] hcount, vcount, vcount_in_rect, hcount_in_rect;
logic hsync, hblnk, vsync, vblnk;
logic [11:0] rgb, rgb_next;

 /**
  * Internal logic
  */

 

 always_ff @(posedge clk) begin 
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
    end else begin
        out.vcount <= vcount;
        out.vsync  <= vsync;
        out.vblnk  <= vblnk;
        out.hcount <= hcount;
        out.hsync  <= hsync;
        out.hblnk  <= hblnk;
        out.rgb    <= rgb_next;

    end
 end
 
 always_ff @(posedge clk) begin 
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
 
always_comb begin

    if (in.vcount <= 128 + RECT_CHAR_Y && in.vcount >= RECT_CHAR_Y && in.hcount <= 128 + RECT_CHAR_X && in.hcount >= RECT_CHAR_X) begin
        if (char_pixels[4'b1000 - hcount_in_rect[2:0]])
            rgb_next =LETTERS;
        else 
            rgb_next= BG;
    end
    else begin
        rgb_next = rgb;
    end

end

assign vcount_in_rect = in.vcount - RECT_CHAR_Y;
assign hcount_in_rect = in.hcount - RECT_CHAR_X;

assign char_xy = {vcount_in_rect[7:4], hcount_in_rect[6:3]};
assign char_line = vcount_in_rect[3:0];

 endmodule
 