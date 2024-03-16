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
localparam HOR_TOT_PIX = 1056; 
localparam VER_TOT_PIX = 628;

localparam HOR_SYNC_START = 840; 
localparam VER_SYNC_START = 601; 

localparam HOR_SYNC_END = 968; 
localparam VER_SYNC_END = 605; 

endpackage
