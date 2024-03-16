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
    input  logic clk40MHz,
    input logic clk100MHz,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    inout  wire  ps2_clk,
    inout  wire  ps2_data
);


/**
 * Signals assignments
 */

assign vs = dmouse_out_if.vsync;
assign hs = dmouse_out_if.hsync;
assign {r,g,b} = dmouse_out_if.rgb;


/**
* Local variables and signals
*/
logic [11:0] xpos;
logic [11:0] ypos;
logic [11:0] xpos_d;
logic [11:0] ypos_d;


//declarations of interfaces
vga_if tim_dbg_if();
vga_if dbg_drect_if();
vga_if drect_dmouse_if();
vga_if dmouse_out_if();

/**
 * Submodules instances
*/

vga_timing u_vga_timing (
    .clk(clk40MHz),
    .rst,
    .out(tim_dbg_if)
);

draw_bg u_draw_bg (
    .clk(clk40MHz),
    .rst,
    .in(tim_dbg_if),
    .out(dbg_drect_if)
);

MouseCtl u_MouseCtl (
    .clk(clk100MHz),
    .rst,
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .xpos(xpos_d),
    .ypos(ypos_d)
);

d_bufor u_d_bufor(
    .clk(clk40MHz),
    .xpos_nxt(xpos_d),
    .ypos_nxt(ypos_d),
    .xpos(xpos),
    .ypos(ypos)
);


draw_rect u_draw_rect (
    .clk(clk40MHz),
    .rst,
    .xpos(xpos),
    .ypos(ypos),
    .in(dbg_drect_if),
    .out(drect_dmouse_if)
);

draw_mouse u_draw_mouse (
    .clk40MHz(clk40MHz),
    .rst,
    .xpos(xpos),
    .ypos(ypos),
    .in(drect_dmouse_if),
    .out(dmouse_out_if)
);





endmodule
