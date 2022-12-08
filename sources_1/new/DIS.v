`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/28 22:29:06
// Design Name: 
// Module Name: DIS
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


module DIS#(parameter MAX = 16'd50000)(
    input clk,
    input rstn,

    input [31:0] d,

    output reg [7:0] an, //六位独热码表示六个数码管
    output reg [6:0] cn
);

//时钟降频
reg [15:0] cnt1;
always@(posedge clk or negedge rstn ) begin
    if(!rstn)
        cnt1 <= 16'd0;
    else if (cnt1 <= MAX)
        cnt1 <= cnt1 +1'b1;
    else
        cnt1 <= 16'd0;
end

reg clk_low1;
always@(posedge clk or negedge rstn )
 begin
    if(!rstn)
        clk_low1 <= 1'b0;
    else if (cnt1 <= MAX/2)
        clk_low1 <= 1'b0;
    else
        clk_low1 <= 1'b1;
end


//字典
reg [3:0] data;
always@(posedge clk or negedge rstn ) begin
    if(!rstn)
        cn <= 7'd0;
    else begin
        case (data)
                4'h0:cn <= 7'b1000000;
                4'h1:cn <= 7'b1111001;
                4'h2:cn <= 7'b0100100;
                4'h3:cn <= 7'b0110000;
                4'h4:cn <= 7'b0011001;
                4'h5:cn <= 7'b0010010;
                4'h6:cn <= 7'b0000010;
                4'h7:cn <= 7'b1111000;
                4'h8:cn <= 7'b0000000;
                4'h9:cn <= 7'b0010000;
                4'ha:cn <= 7'b0001000;
                4'hb:cn <= 7'b0000011;
                4'hc:cn <= 7'b1000110;
                4'hd:cn <= 7'b0100001;
                4'he:cn <= 7'b0000110;
                4'hf:cn <= 7'b0001110;
        endcase
    end
end

//轮流切换数码管
reg [3:0]cnt2;
always@(posedge clk_low1 or negedge rstn ) begin
    if(!rstn)
        cnt2 <= 4'd0;
    else if (cnt2 < 4'd8)
        cnt2 <= cnt2 +1'b1;
    else
        cnt2 <= 4'd0;
end

always@(posedge clk or negedge rstn ) begin
    if(!rstn)
        an <= 8'b11111111;
    else 
    begin
        case (cnt2)
        4'd1:an <= 8'b1111_1110;
        4'd2:an <= 8'b1111_1101;
        4'd3:an <= 8'b1111_1011;
        4'd4:an <= 8'b1111_0111;
        4'd5:an <= 8'b1110_1111;
        4'd6:an <= 8'b1101_1111;
        4'd7:an <= 8'b1011_1111;
        4'd8:an <= 8'b0111_1111;
        endcase
    end
end

//在切换数码管的同时，赋予位选数据
always@(posedge clk or negedge rstn ) begin
    if(!rstn)
        data <= 4'd0;
    else 
    begin
        case (an)
        8'b11111110:data <= d[3:0];
        8'b11111101:data <= d[7:4];
        8'b11111011:data <= d[11:8];
        8'b11110111:data <= d[15:12];
        8'b11101111:data <= d[19:16];
        8'b11011111:data <= d[23:20];
        8'b10111111:data <= d[27:24];
        8'b01111111:data <= d[31:28];
        endcase
    end
end
endmodule
