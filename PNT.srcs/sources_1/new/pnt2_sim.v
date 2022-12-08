`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/23 10:13:50
// Design Name: 
// Module Name: pnt2_sim
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



module pnt2_sim();
reg clk;
reg  rstn;		//时钟, 复位 (低电平有效)
reg  up;		//移动方向 (dir)：上
reg down;		//移动方向 (dir)：下
reg left;		//移动方向 (dir)：左
reg right;		//移动方向 (dir)：右
//input [11:0] prgb,
reg [3:0] pred;  	//画笔颜色 (prgb)：红
reg [3:0] pgreen; 	//画笔颜色 (prgb)：绿
reg [3:0] pblue; 	//画笔颜色 (prgb)：蓝
reg draw;		//绘画开关：1-绘画
 //output [11:0] rgb,
wire  [3:0] red;//像素颜色 (rgb)：红
wire [3:0] green; 	//像素颜色 (rgb)：绿
wire  [3:0] blue; 	//像素颜色 (rgb)：蓝
wire hs;		//行同步
wire vs;		//场同步

painter2 PNT2(
    .clk(clk),
    .rstn(rstn),		//时钟, 复位 (低电平有效)
    .up(up),		//移动方向 (dir)：上
    .down(down),		//移动方向 (dir)：下
    .left(left),		//移动方向 (dir)：左
    .right(right),		//移动方向 (dir)：右
    //input [11:0] prgb,
    .pred(pred),  	//画笔颜色 (prgb)：红
    .pgreen(pgreen), 	//画笔颜色 (prgb)：绿
    .pblue(pblue), 	//画笔颜色 (prgb)：蓝
    .draw(draw),		//绘画开关：1-绘画
    //output [11:0] rgb,
    .red(red),	//像素颜色 (rgb)：红
    .green(green), 	//像素颜色 (rgb)：绿
    .blue(blue), 	//像素颜色 (rgb)：蓝
    .hs(hs),		//行同步
    .vs(vs)		//场同步
    );
    
initial begin
clk = 0;rstn = 0;pred = 0;pgreen = 0;pblue = 0;
up = 0;down = 0;left = 0;right = 0;draw= 0;
end
always #5 clk = ~clk;
initial 
begin
#5 rstn = 1;
end

endmodule