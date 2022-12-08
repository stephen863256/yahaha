`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 20:15:36
// Design Name: 
// Module Name: ECD
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


module ECD(
    input e,	//使能，高有效
    input [19:0] a,    //待编码信号
    output  reg [4:0] y   //4位BCD码
 );
 
 always @(*)
    begin
        y <= 5'b11111;
        if(e)
         begin
            if(a[0]) y <= 5'b0000;
            else if(a[1]) y <= 5'b00001;
            else if(a[2]) y <= 5'b00010;
            else if(a[3]) y <= 5'b00011;
            else if(a[4]) y <= 5'b00100;
            else if(a[5]) y <= 5'b00101;
            else if(a[6]) y <= 5'b00110;
            else if(a[7]) y <= 5'b00111;
            else if(a[8]) y <= 5'b01000;
            else if(a[9]) y <= 5'b01001;
            else if(a[10])y <= 5'b01010;
            else if(a[11])y <= 5'b01011;
            else if(a[12])y <= 5'b01100;
            else if(a[13])y <= 5'b01101;
            else if(a[14])y <= 5'b01110;
            else if(a[15])y <= 5'b01111;//x
            else if(a[16])y <= 5'b10000;//del
            else if(a[17])y <= 5'b10001;//pre
            else if(a[18])y <= 5'b10010;//nxt
            else if(a[19])y <= 5'b10011;//exe
         end
    end
endmodule


