`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 23:32:54
// Design Name: 
// Module Name: mux3_1
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


module mux4_1#(WIDTH = 5)(
    input [WIDTH-1:0] x,
    input [WIDTH-1:0] y,
    input [WIDTH-1:0] z,
    input [WIDTH-1:0] w,
    input [2:0]en,
    output reg [WIDTH-1:0] data
    );
    
always @(en)
begin
    case(en)
        3'b000 : data <= x;
        3'b001 : data <= y;
        3'b010 : data <= z; 
        3'b011 : data <= w;
        default : data <= data;
    endcase
end
endmodule
