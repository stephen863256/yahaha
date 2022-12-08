`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/23 12:56:44
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

module PS(clk,rstn,data,pos_edge,data_r);

      input       clk;
	  input       rstn;
	  input       data;
	  output      pos_edge;    //������

	  output reg     [1:0]   data_r;      
	
	//���������Ĵ�����ʵ��ǰ���ƽ״̬�ļĴ�
	//�൱�ڶ�dat_i ������
	always @(posedge clk or negedge rstn)begin
	    if(rstn == 1'b0)begin
	        data_r <= 2'b11;
	    end
	    else begin
	        data_r <= {data_r[0], data};    //{ǰһ״̬����һ״̬}
	    end
	end
	//����߼����б��ؼ��
	//data_r[1]��ʾǰһ״̬��data_r[0]��ʾ��һ״̬
	assign  pos_edge = ~data_r[1] & data_r[0];  
	
	
endmodule

module PS4 (      
      input     clk,
	  input      rstn,
	  input   [3:0] data,
	  output  [3:0] pos_edge    //������
);

PS PS0(.clk(clk),.rstn(rstn),.data(data[0]),.pos_edge(pos_edge[0]));
PS PS1(.clk(clk),.rstn(rstn),.data(data[1]),.pos_edge(pos_edge[1]));
PS PS2(.clk(clk),.rstn(rstn),.data(data[2]),.pos_edge(pos_edge[2]));
PS PS3(.clk(clk),.rstn(rstn),.data(data[3]),.pos_edge(pos_edge[3]));
/*PS PS4(.clk(clk),.rstn(rstn),.data(data[4]),.pos_edge(pos_edge[4]));
PS PS5(.clk(clk),.rstn(rstn),.data(data[5]),.pos_edge(pos_edge[5]));
PS PS6(.clk(clk),.rstn(rstn),.data(data[6]),.pos_edge(pos_edge[6]));
PS PS7(.clk(clk),.rstn(rstn),.data(data[7]),.pos_edge(pos_edge[7]));
PS PS8(.clk(clk),.rstn(rstn),.data(data[8]),.pos_edge(pos_edge[8]));
PS PS9(.clk(clk),.rstn(rstn),.data(data[9]),.pos_edge(pos_edge[9]));
PS PS10(.clk(clk),.rstn(rstn),.data(data[10]),.pos_edge(pos_edge[10]));
PS PS11(.clk(clk),.rstn(rstn),.data(data[11]),.pos_edge(pos_edge[11]));
PS PS12(.clk(clk),.rstn(rstn),.data(data[12]),.pos_edge(pos_edge[12]));
PS PS13(.clk(clk),.rstn(rstn),.data(data[13]),.pos_edge(pos_edge[13]));
PS PS14(.clk(clk),.rstn(rstn),.data(data[14]),.pos_edge(pos_edge[14]));
PS PS15(.clk(clk),.rstn(rstn),.data(data[15]),.pos_edge(pos_edge[15]));
PS PS16(.clk(clk),.rstn(rstn),.data(data[16]),.pos_edge(pos_edge[16]));
PS PS17(.clk(clk),.rstn(rstn),.data(data[17]),.pos_edge(pos_edge[17]));
PS PS18(.clk(clk),.rstn(rstn),.data(data[18]),.pos_edge(pos_edge[18]));
PS PS19(.clk(clk),.rstn(rstn),.data(data[19]),.pos_edge(pos_edge[19]));*/

endmodule
