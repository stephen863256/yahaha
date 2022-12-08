`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/28 22:31:39
// Design Name: 
// Module Name: ds_cnt_dis
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


module ds_cnt_dis#(parameter MAX = 16'd50000)(
    input sel,
    input x,
    input rstn,
    input clk,
    output [7:0]an,
    output [6:0]cn
    );
    wire y;
    wire [31:0]data;
     reg yl;
     wire ce;
    DB db(.x(x),.clk(clk),.rstn(rstn),.y(y));
    PS ps(.clk(clk),.rstn(rstn),.data(yl),.pos_edge(ce));
    CNT cnt(.rstn(rstn),.clk(clk),.pe(0'd0),.d(0'd0),.ce(ce),.q(data));
    DIS #(.MAX(MAX))dis(.clk(clk),.rstn(rstn),.d(data),.an(an),.cn(cn));
    always @(x)
    begin
    if(sel == 1) yl = x;
    else yl = y;
    end
endmodule
