`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/06 18:17:35
// Design Name: 
// Module Name: ecd
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


module ecd(
    input clk,
    input rst_n,
    input [7:0] ps2_byte,
    output reg [9:0] keynum,
    output reg a,output reg key_b,output reg c,output reg d,output reg e,output reg f,output reg key_q,
    output reg larr, output reg rarr,output reg uarr,output reg darr,
    output reg enter
    );
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
    begin
        keynum[0]<= 1'b0;  // 0
		keynum[1]<= 1'b0;  // 1
		keynum[2]<= 1'b0; // 2
        keynum[3]<= 1'b0;  // 3
        keynum[4]<= 1'b0;  // 4
        keynum[5]<= 1'b0;  // 5
        keynum[6]<= 1'b0; // 6
        keynum[7]<= 1'b0;  // 7
        keynum[8]<= 1'b0;  // 8
        keynum[9]<= 1'b0;  // 9
        enter <= 1'b0 ;  // ENTER
        a <= 1'b0;	//A
     	key_b <= 1'b0;	//B
       	c <= 1'b0;	//C
        d <= 1'b0;	//D
        e <= 1'b0;	//E    
        f <= 1'b0;	//F
        uarr <= 1'b0;	//I
        larr <= 1'b0;	//J
		darr <= 1'b0;	//K
		rarr <= 1'b0;	//L
		key_q <= 1'b0;       // q
    end
    else case(ps2_byte)
        8'h30:  keynum[0]<= 1'b1;  // 0
		8'h31:  keynum[1]<= 1'b1;  // 1
		8'h32:  keynum[2]<= 1'b1; // 2
        8'h33:  keynum[3]<= 1'b1;  // 3
        8'h34:  keynum[4]<= 1'b1;  // 4
        8'h35:  keynum[5]<= 1'b1;  // 5
        8'h36:  keynum[6]<= 1'b1; // 6
        8'h37:  keynum[7]<= 1'b1;  // 7
        8'h38:  keynum[8]<= 1'b1;  // 8
        8'h39:  keynum[9]<= 1'b1;  // 9
        8'h0d:  enter <= 1'b1 ;  // ENTER
        8'h41:  a <= 1'b1;	//A
     	8'h42:  key_b <= 1'b1;	//B
       	8'h43:  c <= 1'b1;	//C
        8'h44:  d <= 1'b1;	//D
        8'h45:  e <= 1'b1;	//E    
        8'h46:  f <= 1'b1;	//F
        8'h49:  uarr <= 1'b1;	//uar
        8'h4a:  larr <= 1'b1;	//larr
		8'h4b:  darr <= 1'b1;	//darr
		8'h4c:  rarr <= 1'b1;	//rarr
		8'h51:  key_q <= 1'b1; //q
		default:
		begin
		keynum[0]<= 1'b0;  // 0
		keynum[1]<= 1'b0;  // 1
		keynum[2]<= 1'b0; // 2
        keynum[3]<= 1'b0;  // 3
        keynum[4]<= 1'b0;  // 4
        keynum[5]<= 1'b0;  // 5
        keynum[6]<= 1'b0; // 6
        keynum[7]<= 1'b0;  // 7
        keynum[8]<= 1'b0;  // 8
        keynum[9]<= 1'b0;  // 9
        enter <= 1'b0 ;  // ENTER
        a <= 1'b0;	//A
     	key_b <= 1'b0;	//B
       	c <= 1'b0;	//C
        d <= 1'b0;	//D
        e <= 1'b0;	//E    
        f <= 1'b0;	//F
        uarr <= 1'b0;	//I
        larr <= 1'b0;	//J
		darr <= 1'b0;	//K
		rarr <= 1'b0;	//L
		key_q <= 1'b0;      //q
		end
    endcase
end
endmodule
