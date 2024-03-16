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
    input  logic clk100MHz,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    inout  logic ps2_clk,
    inout  logic ps2_data

);


/**
 * Local variables and signals
 */

/**
 * Signals assignments
 */

assign vs = draw_mouse_if.vsync;
assign hs = draw_mouse_if.hsync;
assign {r,g,b} = draw_mouse_if.rgb;

vga_if_tim tim_bg_if ();
vga_if draw_rect_if ();
vga_if draw_bg_if();
vga_if draw_mouse_if();
vga_if draw_rect_char_if();

wire [11:0] xpos;
wire [11:0] ypos;
wire [11:0] xpos_mouse;
wire [11:0] ypos_mouse;

logic [11:0] address;
logic [11:0] pixel_image;

logic left;
reg [7:0] char_pixels;

logic [7:0] char_xy;
logic [3:0] char_line;
logic [6:0] char_code;

/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .out(tim_bg_if)
);

draw_bg u_draw_bg (
    .clk,
    .rst,
    .in(tim_bg_if),
    .out(draw_bg_if)

    
);

MouseCtl u_MauseCtl (
    .ps2_clk,
    .ps2_data,
    .clk(clk100MHz),
    .xpos(xpos_mouse),
    .ypos(ypos_mouse),
    .rst,
    .value(),
    .setx(),
    .sety(),
    .setmax_x(),
    .setmax_y(),
    .zpos(),
    .left(left),
    .middle(),
    .new_event(),
    .right()

);


draw_rect u_draw_rect (
    .clk,
    .rst,
    .in(draw_bg_if),
    .out(draw_rect_if),
    .xpos(xpos),
    .ypos(ypos),
    .rgb_pixel(pixel_image),
    .pixel_addr(address)


);


draw_mouse u_draw_mouse (
    .clk,
    .rst,
    .in(draw_rect_char_if),
    .out(draw_mouse_if),
    .xpos(xpos_mouse),
    .ypos(ypos_mouse)

);

image_rom u_image_rom(
    .clk,
    .address(address),
    .rgb(pixel_image)
);

draw_rect_ctl u_draw_rect_ctl(
    .clk,
    .mouse_left(left),
    .mouse_xpos(xpos_mouse),
    .mouse_ypos(ypos_mouse),
    .rst,
    .xpos(xpos),
    .ypos(ypos)

);

draw_rect_char u_draw_rect_char(
    .clk,
    .rst,
    .char_pixels(char_pixels),
    .char_line,
    .char_xy,
    .in(draw_rect_if),
    .out(draw_rect_char_if)

);


font_rom u_font_rom(
    .clk,
    .addr({char_code,char_line}),
    .char_line_pixels(char_pixels)
 );

 char_rom_16x16 u_char_rom_16x16(
    .char_code,
    .char_xy

 );

endmodule
