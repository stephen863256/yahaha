`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 09:15:06
// Design Name: 
// Module Name: DU
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


module DU(
    output [14:0] raddr,
    input  [11:0] rdata,
    //output [6:0] raddr1,
    //input [1:0] rdata1,
    input pclk,
    input rstn,
    output hs,//行同步
    output vs,//场同步
    output [11:0] rgb//,
    //output [1:0] rgb1,
    //output en
    );
    wire hen,ven;
    wire [10:0]  pixel_xpos;
    wire [10:0]  pixel_ypos;
    
    DDP DDP2(
            .raddr(raddr),
            //.raddr1(raddr1),
            //.rdata1(rdata1),
            .rdata(rdata),
            .hen(hen),
            .ven(ven),
            .pclk(pclk),
            .rstn(rstn),
            .pixel_xpos(pixel_xpos),
            .pixel_ypos(pixel_ypos),
            .rgb(rgb)//,
          //.rgb1(rgb1),
            //.en(en)
            );
    DST DST2(
        .rstn(rstn),
        .pclk(pclk),
        .hs(hs),
        .vs(vs),
        .hen(hen),
        .ven(ven),
        .pixel_xpos(pixel_xpos), 
        .pixel_ypos(pixel_ypos) 
    );
endmodule
