/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
localparam HOR_PIXELS = 800;
localparam VER_PIXELS = 600;

// Add VGA timing parameters here and refer to them in other modules.
localparam HOR_TOT_PIX = 1055; 
localparam VER_TOT_PIX = 627;

localparam HOR_SYNC_START = 840; 
localparam VER_SYNC_START = 601; 

localparam HOR_SYNC_END = 967; 
localparam VER_SYNC_END = 605; 

localparam X_posision = 400;
localparam Y_posision = 300;
localparam W_OF_REC = 49;
localparam H_OF_REC = 63;
localparam color = 12'h0_0_f;

localparam RECT_CHAR_Y = 100;
localparam RECT_CHAR_X = 655;
localparam LETTERS = 12'hf_0_0; 
localparam BG = 12'hf_f_f;

localparam SPACE = 7'h20;
//localparam ! = 7'h21;
localparam A = 7'h41;
localparam B = 7'h42;
localparam C = 7'h43;
localparam D = 7'h44;
localparam E = 7'h45;
localparam F = 7'h46;
localparam G = 7'h47;
localparam H = 7'h48;
localparam I = 7'h49;
localparam J = 7'h4a;
localparam K = 7'h4b;
localparam L = 7'h4c;
localparam M = 7'h4d;
localparam N = 7'h4e;
localparam O = 7'h4f;
localparam P = 7'h50;
localparam Q = 7'h51;
localparam R = 7'h52;
localparam S = 7'h53;
localparam T = 7'h54;
localparam U = 7'h55;
localparam V = 7'h56;
localparam W = 7'h57;
localparam X = 7'h58;
localparam Y = 7'h59;
localparam Z = 7'h5a;

localparam a = 7'h61;
localparam b = 7'h62;
localparam c = 7'h63;
localparam d = 7'h64;
localparam e = 7'h65;
localparam f = 7'h66;
localparam g = 7'h67;
localparam h = 7'h68;
localparam i = 7'h69;
localparam j = 7'h6a;
localparam k = 7'h6b;
localparam l = 7'h6c;
localparam m = 7'h6d;
localparam n = 7'h6e;
localparam o = 7'h6f;
localparam p = 7'h70;
localparam q = 7'h71;
localparam r = 7'h72;
localparam s = 7'h73;
localparam t = 7'h74;
localparam u = 7'h75;
localparam v = 7'h76;
localparam w = 7'h77;
localparam x = 7'h78;
localparam y = 7'h79;
localparam z = 7'h7a;

localparam SERCE = 7'h03;
localparam DOT = 7'h2e;
localparam ZERO = 7'h30;
localparam JEDEN = 7'h31;
localparam DWA = 7'h32;
localparam TRZY = 7'h33;
localparam CZTERY = 7'h34;
localparam PIEC = 7'h35;
localparam SZESC = 7'h36;
localparam SIEDEM = 7'h37;
localparam OSIEM = 7'h38;
localparam DZIEWIEC = 7'h39;


// Add VGA timing parameters here and refer to them in other modules.

endpackage