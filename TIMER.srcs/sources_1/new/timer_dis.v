`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/01 15:25:18
// Design Name: 
// Module Name: timer_dis
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


module timer_dis#(parameter k = 100000000,max = 50000)(
    input [15:0]tc,//定时常数
    input st,//启动定时
    input clk,//时钟
    input rstn,//复位
    output reg [15:0] led,
    output td,//定时结束标志
    output [7:0] an,
    output [6:0] cn 
    );
    wire [31:0] d;
TIMER #(.k(k),.max(max)) timer1(.tc({16'b0,tc}),.st(st),.clk(clk),.rstn(rstn),.td(td),.q(d));
DIS #(.MAX(max))dis(.clk(clk),.rstn(rstn),.d(d),.an(an),.cn(cn));
always @(tc) begin
if(tc[0]) led[0] <= 1;else led[0] <= 0;
if(tc[1]) led[1] <= 1;else led[1] <= 0;
if(tc[2]) led[2] <= 1;else led[2] <= 0;
if(tc[3]) led[3] <= 1;else led[3] <= 0;
if(tc[4]) led[4] <= 1;else led[4] <= 0;
if(tc[5]) led[5] <= 1;else led[5] <= 0;
if(tc[6]) led[6] <= 1;else led[6] <= 0;
if(tc[7]) led[7] <= 1;else led[7] <= 0;
if(tc[8]) led[8] <= 1;else led[8] <= 0;
if(tc[9]) led[9] <= 1;else led[9] <= 0;
if(tc[10]) led[10] <= 1;else led[10] <= 0;
if(tc[11]) led[11] <= 1;else led[11] <= 0;
if(tc[12]) led[12] <= 1;else led[12] <= 0;
if(tc[13]) led[13] <= 1;else led[13] <= 0;
if(tc[14]) led[14] <= 1;else led[14] <= 0;
if(tc[15]) led[15] <= 1;else led[15] <= 0;
end
endmodule
