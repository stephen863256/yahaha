`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 10:55:22
// Design Name: 
// Module Name: pclk
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


module pclk(
    input clk,
    output pclk
    );
    clk_wiz_0  pclk1(
    .clk_out1(pclk),     // output clk_out1
    .clk_in1(clk)          // input clk_in1
);
endmodule
