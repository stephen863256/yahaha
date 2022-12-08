`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/31 16:36:31
// Design Name: 
// Module Name: ds_cnt_dis_tb
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


module ds_cnt_dis_tb( );
 reg sel;
 reg x;
 reg rstn;
 reg clk;
 wire [7:0]an;
 wire [6:0]cn;
 ds_cnt_dis  #(.MAX(16))tb1(.x(x),.rstn(rstn),.clk(clk),.an(an),.cn(cn));
 initial begin
 sel = 0;x = 0;rstn = 0;clk = 0;
 end
 
 always #5 clk = ~clk;
 
 always begin
 #3 rstn = 1;
 #8 x = 1;
 #100 x = 0;
 #100 x = 1;
 #100 x = 0;
      sel = 1;
 #100 x = 1;
 #100 x = 0;
 #100 x = 1;
 #100 x = 0;
 #100 x = 1;
 #100 x = 0;
 #100 x = 1; 
 
 end
endmodule
