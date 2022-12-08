`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/03 19:16:19
// Design Name: 
// Module Name: ps
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


module ps( 
            input [7:0] r,
            output [7:0] r_edge,
            input clk,
            input rst_n
    );
    reg [7:0]r0;
    reg [7:0] r1;
    reg [7:0] r2;
    always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
			r0 <= 8'b0;
			r1 <= 8'b0;
			r2 <= 8'b0;
		end
	else begin								//锁存状态，进行滤波
			r0 <= r;
			r1 <= r0;
			r2 <= r1;
		end
end
//wire [7:0] neg_edge;
//wire [7:0] pos_edge;
assign r_edge = ~r1 & r2;	

endmodule
