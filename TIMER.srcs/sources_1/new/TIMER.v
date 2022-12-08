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
    input [31:0]tc,//��ʱ����
    input st,//������ʱ
    input clk,//ʱ��
    input rstn,//��λ
    output [31:0]q,//����ļ�ʱ����
    output reg td//��ʱ������־
    );
    wire y1,z,y2;
    reg ce;
    reg pe;
    //DB db(.x(st),.clk(clk),.rstn(rstn),.y(z));//ȥ����
    //FreD #(.k(k)) FD1(.clk(clk),.rstn(rstn),.y(y1));//��Ƶ��
   
    CNT cnt2(.rstn(rstn),.pe(pe),.ce(ce),.d(tc),.q(q),.clk(clk)); //������
    
    initial begin  td <= 1;end
    
    always @(posedge z or negedge rstn or posedge y1)
    begin
    if(!rstn) pe <= 0;//��ԭ
    else if(z)  pe <= 1;//����ֵ
    else if(q == tc) pe <= 0;//��ֵ����
    end

    always @(posedge z or negedge rstn or posedge clk)
    begin
    if(!rstn)  td <= 1;//��ԭ
    else if(z)  td <= 0;//��ʼ��ʱ
    else if(q == 32'h0 && !pe) td <= 1;//��ʱ����
    end
    wire pedge;
    test test1(.clk(clk),.rstn(rstn),.data(y1),.pos_edge(pedge));//Ѱ��������
    always @(pedge or rstn or td) begin
    if(!rstn || td) ce <= 0;//��ԭ
    else if(pedge) ce <= 1;//�ҵ������أ��������
    else ce <= 0;//û�ҵ������������
    end
endmodule

module test(input       clk,
	    input       rstn,
		input       data,
		output      pos_edge,    //������
		//output      neg_edge,  //�½���  
		//output      data_edge,  //������
		output reg     [1:0]   data_r      );
	//���������Ĵ�����ʵ��ǰ���ƽ״̬�ļĴ�
	//�൱�ڶ�dat_i ������
	always @(posedge clk or negedge rstn)begin
	    if(rstn == 1'b0)begin
	        data_r <= 2'b00;
	    end
	    else begin
	        data_r <= {data_r[0], data};    //{ǰһ״̬����һ״̬}  
	    end
	end
	//����߼����б��ؼ��
	//data_r[1]��ʾǰһ״̬��data_r[0]��ʾ��һ״̬
	assign  pos_edge = ~data_r[1] & data_r[0];
	//assign  neg_edge = data_r[1] & ~data_r[0];
	//assign  data_edge = pos_edge | neg_edge;
	
endmodule