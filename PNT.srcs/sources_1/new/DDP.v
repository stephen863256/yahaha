`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 09:12:46
// Design Name: 
// Module Name: DDP
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


module DDP(
   output [14:0] raddr,
   input  [11:0] rdata,
   //output  [5:0] raddr1,
   //input [1:0] rdata1,
   input rstn,
   input pclk,
   input hen,
   input ven,
   output reg [11:0] rgb,
   //output reg [1:0] rgb1,
   output [10:0]  pixel_xpos,  //���ص������
   output [10:0]  pixel_ypos   //���ص�������    
   //output  en
    );
        //reg [10:0]  pixel_xpos;  //���ص������
   //reg [10:0]  pixel_ypos;   //���ص�������    
 
   
   
    //rgb
   always @(posedge pclk or negedge rstn)
    begin
    if(!rstn) rgb <=12'b0;
    else 
        begin
        if(hen && ven) 
        begin
        rgb <= rdata;//����
        end
        else rgb <= 12'b0;
        end
    end
    assign raddr = (pixel_xpos>>2)  + (pixel_ypos>>2)*200;//��ַ

endmodule
