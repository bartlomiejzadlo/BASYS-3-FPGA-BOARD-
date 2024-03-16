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
    output logic [10:0] vcount,
    output logic vsync,
    output logic vblnk,
    output logic [10:0] hcount,
    output logic hsync,
    output logic hblnk
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

// Add your signals and variables here.


/**
 * Internal logic
 */

// Add your code here.
  // Declare counters
logic [10:0] hcounter_nxt;
logic [10:0] vcounter_nxt;
logic hblnk_nxt;
logic vblnk_nxt;
logic hsync_nxt;
logic vsync_nxt;

  // horizontal counter  
always_ff @(posedge clk) begin
    if (rst) begin
        hcount <= 0;
    end else begin
        hcount <= hcounter_nxt;
    end
end

always_comb begin
    if (hcount == HOR_TOT_PIX - 1) //1055
        hcounter_nxt = 0;
    else
        hcounter_nxt = hcount + 1;
end



// vertical counter
always_ff @(posedge clk) begin
    if (rst) begin
        vcount<= 0;
    end else begin
        vcount <= vcounter_nxt;
    end
end

always_comb begin
    if (hcount == HOR_TOT_PIX - 1) //1055
        if (vcount == VER_TOT_PIX - 1) //627
            vcounter_nxt = 0;
        else
            vcounter_nxt = vcount + 1;
    else vcounter_nxt = vcount; 
end



//sync/blanck

always_comb begin
    if(rst) begin
        hblnk = 0;
        vblnk = 0;
        hsync = 0;
        vsync = 0;
    end else begin
        hblnk = hblnk_nxt;
        vblnk = vblnk_nxt;
        hsync = hsync_nxt;
        vsync = vsync_nxt;
    end
end

always_comb begin
    if(hcount > HOR_PIXELS - 1 && hcount< HOR_TOT_PIX) //799 && 1056 //798 1055
        hblnk_nxt = 1;
    else
        hblnk_nxt = 0;
   

    if (vcount > VER_PIXELS-1 && vcount < VER_TOT_PIX) //799 && 628
        vblnk_nxt = 1;
    else
        vblnk_nxt = 0;

    if(hcount > HOR_SYNC_START - 1 && hcount < HOR_SYNC_END) //839 && 968
        hsync_nxt = 1;
    else
        hsync_nxt = 0;
    
      
    if (vcount > VER_SYNC_START - 1 && vcount < VER_SYNC_END) //600 && 605
        vsync_nxt = 1;
    else
        vsync_nxt = 0;

    
end


//po lewo jeden w dol
//jezeli warunek, to nastepny cykl bedzie taki i taki...


endmodule


//dulous svassertions