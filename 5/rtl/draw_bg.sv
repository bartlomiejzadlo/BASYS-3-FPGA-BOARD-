/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */



 `timescale 1 ns / 1 ps

 module draw_bg (
     input  logic clk,
     input  logic rst,
     vga_if_tim.in in,
     vga_if.out out
 );
 
    logic [11:0] rgb_nxt;
    import vga_pkg::*;
 
 
 /**
  * Internal logic
  */
 
 always_ff @(posedge clk) begin : bg_ff_blk
     if (rst) begin
         out.vcount <= '0;
         out.vsync  <= '0;
         out.vblnk  <= '0;
         out.hcount <= '0;
         out.hsync  <= '0;
         out.hblnk  <= '0;
         out.rgb    <= '0;
     end else begin
         out.vcount <= in.vcount;
         out.vsync  <= in.vsync;
         out.vblnk  <= in.vblnk;
         out.hcount <= in.hcount;
         out.hsync  <= in.hsync;
         out.hblnk  <= in.hblnk;
         out.rgb    <= rgb_nxt;
     end
 end
 
    
    always_comb begin : bg_comb_blk
        if (in.vblnk || in.hblnk) begin             // Blanking region:
            rgb_nxt = 12'h0_0_0;                    // - make it it black.
        end else begin                              // Active region:
    // Add your code here.
    //B
            if((in.hcount >=10) && (in.hcount <= 30) && (in.vcount >=10) && (in.vcount<=100)) rgb_nxt = 12'hf_f_0;
            else if((in.hcount >=30) && (in.hcount <= 80) && (in.vcount >=10) && (in.vcount<=20)) rgb_nxt = 12'hf_0_0;
            else if((in.hcount >=60) && (in.hcount <= 80) && (in.vcount >=20) && (in.vcount<=40)) rgb_nxt = 12'hf_f_0;
            else if((in.hcount >=30) && (in.hcount <= 80) && (in.vcount >=40) && (in.vcount<=50)) rgb_nxt = 12'hf_0_0;
            else if((in.hcount >=30) && (in.hcount <= 80) && (in.vcount >=90) && (in.vcount<=100)) rgb_nxt = 12'hf_0_0;
            else if((in.hcount >=60) && (in.hcount <= 80) && (in.vcount >=50) && (in.vcount<=90)) rgb_nxt = 12'hf_f_0;
    //Z
            else if((in.hcount >=140) && (in.hcount <=210) && (in.vcount >=10) && (in.vcount<=20)) rgb_nxt = 12'hf_f_0;
            else if((in.hcount >=190) && (in.hcount <=210) && (in.vcount>=20) && (in.vcount<=100)) rgb_nxt = 12'hf_0_0;
            else if((in.hcount >=210) && (in.hcount <=260) && (in.vcount >=90) && (in.vcount<=100)) rgb_nxt = 12'hf_f_0;
            else if((in.hcount >=170) && (in.hcount <=230) && (in.vcount >=30) && (in.vcount<=50)) rgb_nxt = 12'hf_f_0;
            else if (in.vcount == 0)                     // - top edge:
                rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
            else if (in.vcount == VER_PIXELS - 1)   // - bottom edge:
                rgb_nxt = 12'hf_0_0;                // - - make a red line.
            else if (in.hcount == 0)                // - left edge:
                rgb_nxt = 12'h0_f_0;                // - - make a green line.
            else if (in.hcount == HOR_PIXELS - 1)   // - right edge:
                rgb_nxt = 12'h0_0_f;                // - - make a blue line.
            else                                    // The rest of active display pixels:
                rgb_nxt = 12'h8_8_8;                // - fill with gray.
        end
    end
    
endmodule