`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 10:10:49
// Design Name: 
// Module Name: VRAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module VRAM(
    input [11:0] wdata,
    input [14:0] waddr,
    output [11:0] rdata,
    input [14:0] raddr,
    input clk,
    input pclk,
    input we
    );
    
    blk_mem_gen_0  VRAM1(
  .clka(clk),        // input wire clka
  .wea(we),        // input wire [0 : 0] wea
  .addra(waddr),   // input wire [12 : 0] addra
  .dina(wdata),        // input wire [11 : 0] dina
  .clkb(pclk),         // input wire clkb
  .addrb(raddr),    // input wire [12 : 0] addrb
  .doutb(rdata)     // output wire [11 : 0] doutb
);

endmodule
