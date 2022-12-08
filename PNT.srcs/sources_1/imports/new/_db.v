`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 20:53:17
// Design Name: 
// Module Name: _db
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


//key_debounce

module key_debounce(
    input clk,
input rstn,
input key,
output reg key_flag,
output reg key_value

);

reg [19:0] delay_cnt;
reg key_reg;

always@(posedge clk or negedge rstn)

begin
    if(!rstn)
        begin
            delay_cnt<=20'd0;
            key_reg<=1'b1;
        end
    else
        begin
            key_reg<=key;
            if(key_reg !=key)
            delay_cnt<=20'd1000000;
            else if(key_reg==key)
            if(delay_cnt>20'd0)
                delay_cnt<=delay_cnt-1'b1;
            else
                delay_cnt<=delay_cnt;
        end
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        begin
            key_flag<=1'b0;
            key_value<=1'b0;
        end
    else
        begin
            if(delay_cnt==20'd1)
                begin
                    key_value<=key;
                    key_flag<=1'b1;
                end
            else        
                begin
                    key_flag<=1'b0;
                    key_value<=key_value;
                end
        end
end

endmodule
