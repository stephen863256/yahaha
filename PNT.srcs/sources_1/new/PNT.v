`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 09:08:08
// Design Name: 
// Module Name: PNT
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

module  painter1 (
    input clk, rstn,		//ʱ��, ��λ (�͵�ƽ��Ч)
    input up,		//�ƶ����� (dir)����
    input down,		//�ƶ����� (dir)����
    input left,		//�ƶ����� (dir)����
    input right,		//�ƶ����� (dir)����
    //input [11:0] prgb,
    input [3:0] pred,  	//������ɫ (prgb)����
    input [3:0] pgreen, 	//������ɫ (prgb)����
    input [3:0] pblue, 	//������ɫ (prgb)����
    input draw,		//�滭���أ�1-�滭
    //output [11:0] rgb,
    output  [3:0] red,	//������ɫ (rgb)����
    output  [3:0] green, 	//������ɫ (rgb)����
    output  [3:0] blue, 	//������ɫ (rgb)����
    output hs,		//��ͬ��
    output vs		//��ͬ��
);
pclk pclk1(.clk(clk),.pclk(pclk));
wire hen,ven;
wire [9:0]  pixel_xpos;
wire [9:0]  pixel_ypos;

DST DST1(
        .rstn(rstn),
        .pclk(pclk),
        .hs(hs),
        .vs(vs),
        .hen(hen),
        .ven(ven),
        .pixel_xpos(pixel_xpos), 
        .pixel_ypos(pixel_ypos) 
    );
assign blue = (hen && ven)? 4'b1111:4'b0000;
assign red =  (hen && ven)? 4'b1111:4'b0000;
assign green =(hen && ven)? 4'b1111:4'b0000;
endmodule

module  painter2 (
    input clk, rstn,		//ʱ��, ��λ (�͵�ƽ��Ч)
    input up,		//�ƶ����� (dir)����
    input down,		//�ƶ����� (dir)����
    input left,		//�ƶ����� (dir)����
    input right,		//�ƶ����� (dir)����
    //input [11:0] prgb,
    input [3:0] pred,  	//������ɫ (prgb)����
    input [3:0] pgreen, 	//������ɫ (prgb)����
    input [3:0] pblue, 	//������ɫ (prgb)����
    input draw,		//�滭���أ�1-�滭
    //output [11:0] rgb,
    output  reg [3:0] red,	//������ɫ (rgb)����
    output  reg [3:0] green, 	//������ɫ (rgb)����
    output  reg [3:0] blue, 	//������ɫ (rgb)����
    output hs,		//��ͬ��
    output vs		//��ͬ��
);
    pclk pclk1(.clk(clk),.pclk(pclk));
    wire en;
    wire [5:0] raddr1;
    wire [1:0] rdata1; 
    ROM rom(.raddr(raddr1),.rdata(rdata1),.pclk(pclk),.en(en));
    DU du(.raddr1(raddr1),.rdata1(rdata1),.pclk(pclk),.rstn(rstn),.hs(hs),.vs(vs),.rgb1(rgb1),.en(en));
    wire [1:0] rgb1;
    always @ (*)
    begin
        red <= 4'b0000;green <= 4'b0000;blue <= 4'b0000;
        case(rgb1)
         2'b00 :  red <= 4'b1111;
         2'b01 :  green <= 4'b1111;
         2'b10 :  blue  <= 4'b1111;
         2'b11 : begin red <= 4'b1111;green <= 4'b1111; blue  <= 4'b1111; end
        endcase
    end
endmodule

module  painter3 (
    input clk, rstn,		//ʱ��, ��λ (�͵�ƽ��Ч)
    input up,		//�ƶ����� (dir)����
    input down,		//�ƶ����� (dir)����
    input left,		//�ƶ����� (dir)����
    input right,		//�ƶ����� (dir)����
    //input [11:0] prgb,
    input [3:0] pred,  	//������ɫ (prgb)����
    input [3:0] pgreen, 	//������ɫ (prgb)����
    input [3:0] pblue, 	//������ɫ (prgb)����
    input draw,		//�滭���أ�1-�滭
    //output [11:0] rgb,
    output   [3:0] red,	//������ɫ (rgb)����
    output   [3:0] green, 	//������ɫ (rgb)����
    output   [3:0] blue, 	//������ɫ (rgb)����
    output hs,		//��ͬ��
    output vs		//��ͬ��
);
    wire [14:0] waddr;
    wire [11:0] wdata;
    wire we;
    wire [14:0] raddr;
    wire [11:0] rdata;
    wire[3:0] y1,y2;
    db4 db4(.x({right,left,down,up}),.y(y1),.clk(clk),.rstn(rstn));
    //PS4 ps4(.data(y1),.pos_edge(y2),.clk(clk),.rstn(rstn));
    PU pu(.draw(draw),
          .right(y1[3]),.left(y1[2]),.down(y1[1]),.up(y1[0]),
          .prgb({pblue,pgreen,pred}),
          .clk(clk),
          .rstn(rstn),
          .waddr(waddr),
          .wdata(wdata),
          .we(we)
          );
     pclk pclk2(.clk(clk),.pclk(pclk));     
     VRAM vram(
        .waddr(waddr),
        .wdata(wdata),
        .we(we),
        .clk(clk),
        .pclk(pclk),
        .raddr(raddr),
        .rdata(rdata)
     );
     
     DU du(
        .raddr(raddr),
        .rdata(rdata),
        .pclk(pclk),
        .hs(hs),
        .vs(vs),
        .rgb({blue,green,red}),
        .rstn(rstn)
     );
endmodule