`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/31 21:02:18
// Design Name: 
// Module Name: TIMER
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


module TIMER#(parameter k = 10000,max = 2000)( 
    input [31:0]tc,//定时常数
    input st,//启动定时
    input clk,//时钟
    input rstn,//复位
    output [31:0]q,//输出的计时数字
    output reg td//定时结束标志
    );
    wire y1,z,y2;
    reg ce;
    reg pe;
    //DB db(.x(st),.clk(clk),.rstn(rstn),.y(z));//去抖动
    //FreD #(.k(k)) FD1(.clk(clk),.rstn(rstn),.y(y1));//分频器
   
    CNT cnt2(.rstn(rstn),.pe(pe),.ce(ce),.d(tc),.q(q),.clk(clk)); //计数器
    
    initial begin  td <= 1;end
    
    always @(posedge z or negedge rstn or posedge y1)
    begin
    if(!rstn) pe <= 0;//还原
    else if(z)  pe <= 1;//允许赋值
    else if(q == tc) pe <= 0;//赋值结束
    end

    always @(posedge z or negedge rstn or posedge clk)
    begin
    if(!rstn)  td <= 1;//还原
    else if(z)  td <= 0;//开始定时
    else if(q == 32'h0 && !pe) td <= 1;//定时结束
    end
    wire pedge;
    test test1(.clk(clk),.rstn(rstn),.data(y1),.pos_edge(pedge));//寻找上升沿
    always @(pedge or rstn or td) begin
    if(!rstn || td) ce <= 0;//还原
    else if(pedge) ce <= 1;//找到上升沿，允许计数
    else ce <= 0;//没找到，不允许计数
    end
endmodule

module test(input       clk,
	    input       rstn,
		input       data,
		output      pos_edge,    //上升沿
		//output      neg_edge,  //下降沿  
		//output      data_edge,  //数据沿
		output reg     [1:0]   data_r      );
	//设置两个寄存器，实现前后电平状态的寄存
	//相当于对dat_i 打两拍
	always @(posedge clk or negedge rstn)begin
	    if(rstn == 1'b0)begin
	        data_r <= 2'b00;
	    end
	    else begin
	        data_r <= {data_r[0], data};    //{前一状态，后一状态}  
	    end
	end
	//组合逻辑进行边沿检测
	//data_r[1]表示前一状态，data_r[0]表示后一状态
	assign  pos_edge = ~data_r[1] & data_r[0];
	//assign  neg_edge = data_r[1] & ~data_r[0];
	//assign  data_edge = pos_edge | neg_edge;
	
endmodule