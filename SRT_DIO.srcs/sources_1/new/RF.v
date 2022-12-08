`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/03 18:45:34
// Design Name: 
// Module Name: RF
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


module  register_file # (
    parameter AW = 5,		//地址宽度
    parameter DW = 16		//数据宽度
)(
    input clk,			//时钟
    input [AW-1:0] ra0,
    input [AW-1:0] ra1,		//读地址
    output  [DW-1:0] rd0, 
    output  [DW-1:0] rd1, 	//读数据
    input [AW-1:0] wa, 		//写地址
    input [DW-1:0] wd,		//写数据
    input we		//写使能

);
    reg [DW-1:0] rf [0: (1<<AW)-1];		//寄存器堆
    initial begin 
    rf[0] <= 0;rf[1] <= 0;rf[2] <= 0;rf[3] <= 0;
    rf[4] <= 0;rf[5] <= 0;rf[6] <= 16'h05da;rf[7] <= 0;
    rf[8] <= 0;rf[9] <= 0;rf[10] <= 0;rf[11] <= 0;
    rf[12] <= 0;rf[13] <= 0;rf[14] <= 16'h0369;rf[15] <= 0;
    rf[16] <= 0;rf[17] <= 0;rf[18] <= 0;rf[19] <= 16'h25fb;
    rf[20] <= 0;rf[21] <= 16'h2889;rf[22] <= 0;rf[23] <= 0;
    rf[24] <= 0;rf[25] <= 16'h0264;rf[26] <= 0;rf[27] <= 0;
    rf[28] <= 0;rf[29] <= 0;rf[30] <= 0;rf[31] <= 16'h4366;
    end

    assign rd0 = rf[ra0];assign rd1 = rf[ra1];	//读操作
    always  @ (posedge clk)
        if (we)  rf[wa]  <=  wd;		//写操作
endmodule

