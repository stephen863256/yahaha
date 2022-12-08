`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/31 16:46:23
// Design Name: 
// Module Name: DB_tb
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


module DB_tb();
   reg x;
   reg clk;
   reg rstn;
   wire y;
   
 DB db1(.x(x),.y(y),.clk(clk),.rstn(rstn));
initial 
begin
    x = 0;clk = 0;rstn = 0;
end

always #5 clk = ~clk;

initial
begin
    #2 rstn = 1;
    #2 x = 1;
    #100 x = 0;
    #100 x = 1;
    #100 x = 0;
    #100 x = 1;
    #100 x = 0;
    #100 x = 1;
    #100 x = 0;
    #100 x = 1;
    #100 x = 0;
    #100 x = 1;
    #100 x = 0;
    #100 x = 1;
end
endmodule
