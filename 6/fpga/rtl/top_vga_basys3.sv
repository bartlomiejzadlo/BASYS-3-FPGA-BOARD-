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
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

 `timescale 1 ns / 1 ps

 module top_vga_basys3 (
     input  wire clk,
     input  wire btnC,
     input  wire rx, 
     input  wire loopback_enable,
     input  wire btnU,
 
     output wire tx,
     output wire rx_monitor,
     output wire tx_monitor,
     output wire [7:0] sseg ,
     output wire [3:0] an 
 );
 
 
 /**
  * Local variables and signals
  */
 
 
 wire clk40MHz, clk100MHz;
 wire pclk;
 
 
 (* KEEP = "TRUE" *)
 (* ASYNC_REG = "TRUE" *)
 // For details on synthesis attributes used above, see AMD Xilinx UG 901:
 // https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes
 
 
 /**
  * Signals assignments
  */
 
 
 
 
 /**
  * FPGA submodules placement
  */
 clk_wiz_0 clk0_wiz(
       // Clock out ports
     .clk100MHz(clk100MHz),
     .clk40MHz(clk40MHz),
     // Status and control signals
     .locked(locked),
     .clk(clk)
 );
 
 ODDR pclk_oddr (
     .Q(pclk),
     .C(clk40MHz),
     .CE(1'b1),
     .D1(1'b1),
     .D2(1'b0),
     .R(1'b0),
     .S(1'b0)
 );
 
 /**
  *  Project functional top module
  */
 
  top_uart u_top_uart (
     .clk(clk100MHz),
     .rst(btnC),
     .btnu(btnU),
     .rx(rx),
     .loopback_enable(loopback_enable),
     .tx(tx),
     .rx_monitor(rx_monitor),
     .tx_monitor(tx_monitor),
     .sseg(sseg),
     .an(an)
 );
 
 endmodule
 