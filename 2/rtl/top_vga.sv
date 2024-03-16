/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Signals assignments
 */

assign vs = drect_out_if.vsync;
assign hs = drect_out_if.hsync;
assign {r,g,b} = drect_out_if.rgb;



//declarations of interfaces
vga_if tim_dbg_if();
vga_if dbg_drect_if();
vga_if drect_out_if();


/**
 * Submodules instances
*/

vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(tim_dbg_if.out)
);

draw_bg u_draw_bg (
    .clk,
    .rst,
    .in(tim_dbg_if.in),
    .out(dbg_drect_if.out)
);

draw_rect u_draw_rect (
    .clk,
    .rst,
    .in(dbg_drect_if.in),
    .out(drect_out_if.out)
);



endmodule
