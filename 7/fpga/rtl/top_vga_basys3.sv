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
     input  wire rst,
     input  wire rx,
     input  wire PCsw,
     input  wire extCtl_btn,
     input  wire PCenable_btn,
     input  wire RFData_en,
     input  wire PC_en,
     input  wire Instr_en,
     input  wire [15:12] sw,

     output wire blink,
     output wire tx,
     output wire [1:1] led,
     output wire [7:0] sseg,
     output wire [3:0] an 
 );
 
 
 /**
  * Local variables and signals
  */
 
  wire clk100MHz;
  wire [3:0] Dig1, Dig2, Dig3, Dig4, monRFSrc;
  wire [15:0] monPC, monInstr, monRFData;
  wire PCenable, extCtl, PCbutt;
  wire rx_done, ram_enable;
  wire [7:0] data, ram_wa;
  wire [15:0] ram_din;
 
 
 
 (* KEEP = "TRUE" *)
 (* ASYNC_REG = "TRUE" *)
 
 
 /**
  * Signals assignments
  */
 
 assign monRFSrc = sw[15:12];
 assign PCenable = PCsw ? PCsw : PCbutt;
 assign blink = RFData_en || Instr_en;
 
 
 /**
  * FPGA submodules placement
  */
 clk_wiz_0 clk0_wiz(
     .clk100MHz(clk100MHz),
     .clk40MHz(),
     .locked(),
     .clk(clk)
 );
 
 uart u_uart(
     .clk(clk100MHz),
     .reset(rst),
     .rx(rx),
     .rx_done(rx_done),
     .rx_data_out(data),
     .tx(tx)
 );
 
 memory_write u_memory_write(
     .clk(clk100MHz),
     .reset(rst),
     .rx_done(rx_done),
     .data(data),
     .ram_enable(ram_enable),
     .ram_wa(ram_wa),
     .ram_din(ram_din)
 );
 
 
  debounce u_debounce(
     .clk(clk100MHz), 
     .reset(rst), 
     .sw(PCenable_btn),
     .db_level(), 
     .db_tick(PCbutt)
 );
 
 debounce u_debounce2(
     .clk(clk100MHz), 
     .reset(rst), 
     .sw(extCtl_btn),
     .db_level(extCtl), 
     .db_tick()
 );
 
 
 micro u_micro
 (
     .clk(clk100MHz),
     .reset(rst),
     .iram_wa(ram_wa),
     .iram_wen(ram_enable),
     .iram_din(ram_din),
     .PCenable(PCenable), 
     .extCtl(extCtl),     
     .monRFSrc(monRFSrc),  
     .monRFData(monRFData), 
     .monInstr(monInstr),
     .monPC(monPC),
     .led(led[1:1])
 );
 
 select_out_display u_select_out_display(
     .clk(clk100MHz),
     .rst(rst),
     .monRFData(monRFData),
     .monPC(monPC),
     .monInstr(monInstr),
     .RFData_en(RFData_en),
     .PC_en(PC_en),
     .Instr_en(Instr_en),
     .Dig1(Dig1),
     .Dig2(Dig2),
     .Dig3(Dig3),
     .Dig4(Dig4)
 
 );
 
 
 disp_hex_mux u_disp(
     .clk(clk100MHz), 
     .reset(rst),
     .hex3(Dig4), 
     .hex2(Dig3), 
     .hex1(Dig2), 
     .hex0(Dig1),
     .dp_in(4'b1011), 
     .an(an), 
     .sseg(sseg)
 );
 
 endmodule
 