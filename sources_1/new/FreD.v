`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/30 20:35:46
// Design Name: 
// Module Name: FreD
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


module FreD#(parameter k = 4)(
    input clk,
    input rstn,
    output y
    );
    if(k % 2 == 0) FreD_even #(.M(k))fred1(.clk(clk),.rstn(rstn),.clk_out(y));
    else FreD_odd #(.M(k))fre2(.clk(clk),.rstn(rstn),.clk_out(y));
endmodule

module FreD_even 
#(parameter M = 4)(
input       clk,
input	    rstn,
output reg  clk_out
);
reg	[30:0]	count;
parameter	N = M/2;
always@(posedge clk or negedge rstn)
begin
	if(!rstn)
	   begin
		clk_out	<= 0;
		count	<= 3'b00;
	   end
	else if(count == N-1)
	   begin
		clk_out <= ~clk_out;
		count	<= count + 1;
	   end
	else if(count == M-1)
	   begin
		clk_out <= ~clk_out;
		count	<= 3'b000;
	   end
	else 
	   begin 
		clk_out <= clk_out;
		count	<= count + 1;
	   end
end
endmodule

module FreD_odd 
#(parameter M = 5)(
input       clk,
input       rstn,
input       clk_out
);
reg     [30:0]   count;
reg             clk_1;
reg             clk_2;
parameter       N = (M-1)/2;
always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        count   <= 0;
    else if(count == (M-1))
        count   <= 0;
    else 
        count   <= count +1;
end
always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        clk_1   <= 0;
    else if(count == N-1)
        clk_1   <= ~clk_1;
    else if(count == M-1)
        clk_1   <= ~clk_1;
end
always@(negedge clk or negedge rstn)
begin
    if(!rstn)
        clk_2   <= 0;
    else if(count == N-1)
        clk_2   <= ~clk_2;
    else if(count == M-1)
        clk_2   <= ~clk_2;
end
assign  clk_out = clk_1 & clk_2;
endmodule 