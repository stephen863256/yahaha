`timescale 1ns / 1ps
`define clock_period  20

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/31 15:27:12
// Design Name: 
// Module Name: PS_sim
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


module PS_tb;
    reg clk;
	reg rst_n;
    reg data;
	
   wire pos_edge;
   //wire neg_edge;
   //wire data_edge;


  PS   u1(
   .clk(clk),
   .rst_n(rst_n),
	.data(data),
	.pos_edge(pos_edge)//,
	//.neg_edge(neg_edge),
	//.data_edge(data_edge)
 );
 
 //产生时钟激励
 initial  clk = 1; 
 always #(`clock_period/2)  clk = ~clk;
 //产生复位激励
 initial begin
 rst_n = 0;
 #20;
 rst_n = 1;
 end
 
 //输入激励
 initial  begin 
      data=0;
      #(`clock_period*5+1)
      data=1;
      #(`clock_period*10+1)
      data=0;
      #(`clock_period*5+1)
      data=1; 
      #(`clock_period*5+1)
      data=0;	
  #(`clock_period*50)
  $stop;
 
 end
 
 endmodule
