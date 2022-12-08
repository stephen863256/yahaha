`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 09:13:14
// Design Name: 
// Module Name: DST
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


module DST(
    input rstn,
    input pclk,
    output hs,//��ͬ��
    output vs,//��ͬ��
    output hen,//��ʹ��
    output ven,//��ʹ��
    output  [10:0]  pixel_xpos,   //���ص������
    output  [10:0]  pixel_ypos    //���ص������� 
    );
    
//parameter define
parameter  H_SYNC   =  12'd120;    //��ͬ��
parameter  H_BACK   =  12'd64;    //����ʾ����
parameter  H_DISP   =  12'd800;   //����Ч����
parameter  H_FRONT  =  12'd56;    //����ʾǰ��
parameter  H_TOTAL  =  12'd1040;   //��ɨ������
 
parameter  V_SYNC   =  12'd6;     //��ͬ��
parameter  V_BACK   =  12'd23;    //����ʾ����
parameter  V_DISP   =  12'd600;   //����Ч����
parameter  V_FRONT  =  12'd37;    //����ʾǰ��
parameter  V_TOTAL  =  12'd666;   //��ɨ������
    
//reg define                                     
reg  [11:0] cnt_h;
reg  [11:0] cnt_v;
    
//VGA�г�ͬ���ź�
assign hs  = (cnt_h <= (H_SYNC - 1'b1)) ? 1'b1 : 1'b0;
assign vs  = (cnt_v <= (V_SYNC - 1'b1)) ? 1'b1 : 1'b0;

assign hen = ((cnt_h >= H_SYNC+H_BACK) && (cnt_h < H_SYNC + H_BACK + H_DISP))? 1'b1:1'b0;// �ж����ź�����Ч���ݶ���
assign ven = ((cnt_v >= V_SYNC+V_BACK) && (cnt_v < V_SYNC + V_BACK + V_DISP))? 1'b1:1'b0;// �жϳ��ź�����Ч���ݶ���


wire       data_req;
//�������ص���ɫ�������룬��ɫλ�õĿ���     
assign data_req = (((cnt_h >= H_SYNC+H_BACK) && (cnt_h < H_SYNC+H_BACK+H_DISP))
                  && ((cnt_v >= V_SYNC+V_BACK) && (cnt_v < V_SYNC+V_BACK+V_DISP)))
                  ?  1'b1 : 1'b0;
//���ص�����                
assign pixel_xpos = data_req ? (cnt_h - (H_SYNC + H_BACK - 1'b1)) : 10'd0;		// �������������������ض�Ӧ��λ��
assign pixel_ypos = data_req ? (cnt_v - (V_SYNC + V_BACK - 1'b1)) : 10'd0;		// �������������������ض�Ӧ��λ��

//�м�����������ʱ�Ӽ���
always @(posedge pclk or negedge rstn) begin         
    if (!rstn)
        cnt_h <= 12'd0;                                  
    else begin
        if(cnt_h < H_TOTAL - 1'b1)                                               
            cnt_h <= cnt_h + 1'b1;                               
        else 
            cnt_h <= 12'd0;  
    end
end

//�����������м���
always @(posedge pclk or negedge rstn) begin         
    if (!rstn)
        cnt_v <= 12'd0;                                  
    else if(cnt_h == H_TOTAL - 1'b1) begin
        if(cnt_v < V_TOTAL - 1'b1)                                               
            cnt_v <= cnt_v + 1'b1;                               
        else 
            cnt_v <= 12'd0;  
    end
end

endmodule
