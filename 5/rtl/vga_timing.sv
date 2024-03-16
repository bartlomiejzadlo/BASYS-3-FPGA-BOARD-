/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

 `timescale 1 ns / 1 ps

 module vga_timing (
     input  logic clk,
     input  logic rst,
 
     vga_if_tim.out out
     
 );
 
 import vga_pkg::*;
 
 
 logic [10:0] hcount_nxt=0;
 logic [10:0] vcount_nxt=0;
 logic hblnk_nxt = 0;
 logic hsync_nxt = 0;
 logic vblnk_nxt = 0;
 logic vsync_nxt = 0;
 
 
 
 //horizontal counter
 always_ff @(posedge clk) begin
   if(rst) 
     out.hcount <= 11'b0;
   else 
     out.hcount <= hcount_nxt;
 end
  
 always_comb begin
     if(out.hcount==1055)
       hcount_nxt = 11'b0;
     else
       hcount_nxt = out.hcount + 1;
 end
  
   
 
 //vertical counter
 always_ff @(posedge clk) begin
   if(rst)
     out.vcount <= 11'b0;
   else 
     out.vcount <= vcount_nxt;
 end
 
 always_comb begin
     if(out.hcount==1055) begin
       if (out.vcount==627)
         vcount_nxt = 11'b0;
       else
         vcount_nxt = out.vcount + 1;
     end
     else
         vcount_nxt =  out.vcount;
 
 end 
 
 
 always_ff @(posedge clk) begin
     if(rst) begin
     out.hblnk <= 0;
     out.hsync <= 0;
     out.vblnk <= 0;
     out.vsync <= 0;
     end
     else begin
     out.hblnk <= hblnk_nxt;
     out.hsync <= hsync_nxt;
     out.vblnk <= vblnk_nxt;
     out.vsync <= vsync_nxt;
     end
 end
 
 
 //timing controller 
 always_comb begin
   
     if(out.hcount >= (HOR_SYNC_START - 1) && out.hcount <= (HOR_SYNC_END-1))
       hsync_nxt = 1;
     else 
       hsync_nxt = 0;
 
     if (out.hcount >= (HOR_PIXELS - 1) && out.hcount <= (HOR_TOT_PIX - 1))
         hblnk_nxt = 1;
       else 
         hblnk_nxt = 0;
 
 
     if (((out.hcount == HOR_TOT_PIX && out.vcount == (VER_PIXELS - 1))||(out.vcount >= (VER_SYNC_START - 1) && out.vcount <= VER_TOT_PIX)) && !(out.vcount == VER_TOT_PIX && out.hcount == HOR_TOT_PIX))
         vblnk_nxt = 1;
     else
         vblnk_nxt = 0;
 
     if (((out.hcount == HOR_TOT_PIX && out.vcount == VER_PIXELS) || (out.vcount >= VER_SYNC_START && out.vcount <= (VER_SYNC_END - 1))) && !(out.vcount == (VER_SYNC_END - 1) && out.hcount == HOR_TOT_PIX))
         vsync_nxt = 1;
     else
         vsync_nxt = 0;
 
   end
 /**
  * Local variables and signals
  */
 
 // Add your signals and variables here.
 
 
 /**
  * Internal logic
  */
 
 // Add your code here.
 
 
 endmodule