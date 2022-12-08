`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/28 22:28:40
// Design Name: 
// Module Name: CNT
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


module CNT#(parameter WIDTH = 32, RST_VLU = 0)(
    input clk, rstn, pe, ce,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);


always @(posedge clk or negedge rstn) 
    begin
        if (!rstn)  q <= RST_VLU;
        else if (pe)  q <= d; //置数指令
        else if (ce ) q <= q - 1;//计数指令
    end


endmodule




