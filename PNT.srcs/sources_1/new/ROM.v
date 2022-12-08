`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/22 17:51:18
// Design Name: 
// Module Name: ROM
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


module ROM(
    input [5:0] raddr,
    input en,
    input pclk,
    output [1:0] rdata
    );
 
 blk_mem_gen_2 rom(.addra(raddr),.douta(rdata),.ena(en),.clka(pclk));
endmodule
