`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 19:24:46
// Design Name: 
// Module Name: sel35_1
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


module sel35_1(
    input [34:0] din,
    input [11:0] di, dj,
    output dout
    );
    assign dout = din[dj * 5 + di];
endmodule
