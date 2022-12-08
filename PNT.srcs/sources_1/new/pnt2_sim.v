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
reg  rstn;		//ʱ��, ��λ (�͵�ƽ��Ч)
reg  up;		//�ƶ����� (dir)����
reg down;		//�ƶ����� (dir)����
reg left;		//�ƶ����� (dir)����
reg right;		//�ƶ����� (dir)����
//input [11:0] prgb,
reg [3:0] pred;  	//������ɫ (prgb)����
reg [3:0] pgreen; 	//������ɫ (prgb)����
reg [3:0] pblue; 	//������ɫ (prgb)����
reg draw;		//�滭���أ�1-�滭
 //output [11:0] rgb,
wire  [3:0] red;//������ɫ (rgb)����
wire [3:0] green; 	//������ɫ (rgb)����
wire  [3:0] blue; 	//������ɫ (rgb)����
wire hs;		//��ͬ��
wire vs;		//��ͬ��

painter2 PNT2(
    .clk(clk),
    .rstn(rstn),		//ʱ��, ��λ (�͵�ƽ��Ч)
    .up(up),		//�ƶ����� (dir)����
    .down(down),		//�ƶ����� (dir)����
    .left(left),		//�ƶ����� (dir)����
    .right(right),		//�ƶ����� (dir)����
    //input [11:0] prgb,
    .pred(pred),  	//������ɫ (prgb)����
    .pgreen(pgreen), 	//������ɫ (prgb)����
    .pblue(pblue), 	//������ɫ (prgb)����
    .draw(draw),		//�滭���أ�1-�滭
    //output [11:0] rgb,
    .red(red),	//������ɫ (rgb)����
    .green(green), 	//������ɫ (rgb)����
    .blue(blue), 	//������ɫ (rgb)����
    .hs(hs),		//��ͬ��
    .vs(vs)		//��ͬ��
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