`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/01 15:40:51
// Design Name: 
// Module Name: tim_dis_tb
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


module tim_dis_tb();
    reg [31:0]tc;//定时常数
    reg st;//启动定时
    reg clk;//时钟
    reg rstn;//复位
    wire [15:0] led;
    wire td;//定时结束标志
    wire [7:0] an;
    wire [6:0] cn; 
    parameter k = 10;
    parameter max = 2;
    timer_dis #(.k(k),.max(k)) td1(.tc(tc),.st(st),.clk(clk),.rstn(rstn),.td(td),.an(an),.cn(cn),.led(led));
    
    initial begin
    tc = 16'h00FF; st = 0;clk = 0;rstn = 0; 
    end
    always #10 clk = ~clk;
    initial begin
    #5 rstn = 1;
    #131 st = 1;
    #100 st = 0;
    #340 rstn = 0;
    #5 rstn = 1;
    #125 st = 1;
    #100 st = 0;
    end 
endmodule
