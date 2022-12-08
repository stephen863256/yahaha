`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 22:06:00
// Design Name: 
// Module Name: CU
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


module CU(
    input [4:0] cu,
    output reg [2:0] s1,
    output reg [2:0] s2,
    input clk,
    input rstn,
    output reg [15:0] delay,
    output reg busy,
    output reg we,
    output reg exe,
    output reg enar,
    output reg endr,
    output reg [4:0] hd,
    input vld_in,
    input vld_out,
    input done
    );
    parameter S0 = 10'b0000000001;//初始状态
    parameter S1 = 10'b0000000010;//赋值状态
    parameter S2 = 10'b0000000100;//等待输入
    parameter S3 = 10'b0000001000;//输入修改数据
    parameter S4 = 10'b0000010000;//删除数据
    parameter S5 = 10'b0000100000;//寄存器堆中存入数据
    parameter S6 = 10'b0001000000;//寄存器堆中存入数据
    parameter S7 = 10'b0010000000;//地址加1
    parameter S8 = 10'b0100000000;//地址减1
    parameter S9 = 10'b1000000000;//开始排序，寄存器堆中取数
    parameter S10 = 11'b010000000000;//数据排序
    parameter S11 = 12'b100000000000;//输入寄存器堆
    reg [12:0] current_state;
    reg [12:0] next_state;
    reg [15:0] delay1;
always@(posedge clk or negedge rstn)
begin
    if(!rstn)
		current_state <= S0;
    else
		current_state <= next_state;
end

always@(*)
begin
    if(!rstn) next_state <= S0;
    else case(current_state)
       S0 :next_state <= S1;
       S1 :next_state <= S2;
       S2 :
           begin
           if(cu == 5'b10011)next_state <= S9;
           else if(cu == 5'b10010 )next_state <= S5;
           else if(cu == 5'b10001 )next_state <= S6;
           else if(cu == 5'b10000) next_state <= S4;
           else if(cu == 5'b11111) next_state <= S2;
           else next_state <= S3;
           end
       S3 :next_state <= S2;
       S4 :next_state <= S2;
       S5: next_state <= S7;
       S6: next_state <= S8;
       S7 :next_state <= S1;
       S8 :next_state <= S1;
       S9 :begin
                if(vld_in) next_state <= S10;
                else next_state <= S9;
           end
       S10 :begin
                if(vld_out) next_state <= S11;
                else next_state <= S10;
           end
       S11 :begin
                if(done) next_state <= S0;
                else next_state <= S11;
             end    
       default :next_state <= S0;
    endcase
end

always @(posedge clk)
begin
    we <= 0;enar <= 0;endr <= 0;//busy <= 0;//s1 <= 3'b111;s2 <= 3'b111;
    if(current_state == S0) begin 
                                    exe <= 0;
                                    s1 <= 3'b00; 
                                    enar <= 1;
                                    busy <= 0;
                                    delay1 <= 0; 
                                    delay <= delay1;
                               end
    else if(current_state == S1) begin s2 <= 3'b10;endr <= 1;end
    else if(current_state == S2) begin if(cu < 5'b10000) hd <= cu;end
    else if(current_state == S3) begin s2 <= 3'b01;endr <= 1;end
    else if(current_state == S4) begin s2 <= 3'b00;endr <= 1;end
    else if(current_state == S5) we <= 1;
    else if(current_state == S6) we <= 1;
    else if(current_state == S7) begin s1 <= 3'b01; enar <= 1;end
    else if(current_state == S8) begin s1 <= 3'b10; enar <= 1;end
    else if(current_state == S9) begin 
                                       exe <= 1;
                                       busy <= 1;
                                       delay1 <= delay1 +1;
                                       s1 <= 3'b11; 
                                       enar <= 1;
                                  end
    else if(current_state == S10) begin exe <= 0;delay1 <= delay1 + 1;s1 <= 3'b100;
                                    busy <= 1;end
    else if(current_state == S11) begin 
                                      
                                        delay1 <= delay1 + 1;
                                        s2 <= 3'b11;
                                        we <= 1;
                                        s1 <= 3'b11;
                                        endr <= 1;
                                        enar <= 1;
                                   end
end 
endmodule


