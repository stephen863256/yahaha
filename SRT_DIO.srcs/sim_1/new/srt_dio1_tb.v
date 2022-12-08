`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/08 12:15:02
// Design Name: 
// Module Name: srt_dio1_tb
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

module srt_dio_tb2();
    reg [15:0]x;
    reg pre;
    reg nxt;
    reg exe;
    reg del;
    reg rstn;
    reg clk;
    wire [7:0] an;
    wire [6:0] cn;
    wire busy;
    wire [15:0] delay;
    srt_dio srt_dio1(
        .x(x),
        .del(del),
        .clk(clk),
        .rstn(rstn),
        .nxt(nxt),
        .pre(pre),
        .exe(exe),
        .busy(busy),
        .delay(delay),
        .an(an),
        .cn(cn)
    );
    initial begin
    clk = 0;x = 0;pre = 0;nxt = 0;del = 0;exe = 0;rstn = 0;
    end
    always #5 clk = ~clk;
    
    initial begin
    #6 rstn = 1;
    #50 x = 16'b0000000000000100;
    #50 x = 16'b0000000000001000;
    #50 nxt = 1;
    #50 x = 16'b0000000000010000;nxt = 0;
    #50 x = 16'b0000000100000000;  
    #50 nxt = 1;
    #50 x = 16'b0000000001000000;nxt = 0;
    #50 x = 16'b0000000010000000;
    #50 pre = 1;
    #50 x = 16'b0000000001000000;pre = 0;
    #50 del = 1;
    #50 x = 16'b0000000010000000;
    #50 del = 0;pre = 1;
    #50 pre = 0;
    #50 exe = 1; x = 16'b0000000000000000;
    #100 exe = 0;
    /*#900 x = 16'b0000000100000000;
    #100 nxt = 1;
    #100 nxt = 0;
    #100 rstn <= 0;
    #100 rstn <= 1;
    #100 exe = 1;
    #100 exe = 0;*/
    end
endmodule
