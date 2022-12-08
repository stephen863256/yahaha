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
    output hs,//行同步
    output vs,//场同步
    output hen,//行使能
    output ven,//场使能
    output  [10:0]  pixel_xpos,   //像素点横坐标
    output  [10:0]  pixel_ypos    //像素点纵坐标 
    );
    
//parameter define
parameter  H_SYNC   =  12'd120;    //行同步
parameter  H_BACK   =  12'd64;    //行显示后沿
parameter  H_DISP   =  12'd800;   //行有效数据
parameter  H_FRONT  =  12'd56;    //行显示前沿
parameter  H_TOTAL  =  12'd1040;   //行扫描周期
 
parameter  V_SYNC   =  12'd6;     //场同步
parameter  V_BACK   =  12'd23;    //场显示后沿
parameter  V_DISP   =  12'd600;   //场有效数据
parameter  V_FRONT  =  12'd37;    //场显示前沿
parameter  V_TOTAL  =  12'd666;   //场扫描周期
    
//reg define                                     
reg  [11:0] cnt_h;
reg  [11:0] cnt_v;
    
//VGA行场同步信号
assign hs  = (cnt_h <= (H_SYNC - 1'b1)) ? 1'b1 : 1'b0;
assign vs  = (cnt_v <= (V_SYNC - 1'b1)) ? 1'b1 : 1'b0;

assign hen = ((cnt_h >= H_SYNC+H_BACK) && (cnt_h < H_SYNC + H_BACK + H_DISP))? 1'b1:1'b0;// 判断行信号在有效数据段内
assign ven = ((cnt_v >= V_SYNC+V_BACK) && (cnt_v < V_SYNC + V_BACK + V_DISP))? 1'b1:1'b0;// 判断场信号在有效数据段内


wire       data_req;
//请求像素点颜色数据输入，颜色位置的开关     
assign data_req = (((cnt_h >= H_SYNC+H_BACK) && (cnt_h < H_SYNC+H_BACK+H_DISP))
                  && ((cnt_v >= V_SYNC+V_BACK) && (cnt_v < V_SYNC+V_BACK+V_DISP)))
                  ?  1'b1 : 1'b0;
//像素点坐标                
assign pixel_xpos = data_req ? (cnt_h - (H_SYNC + H_BACK - 1'b1)) : 10'd0;		// 如果满足条件则输出像素对应的位置
assign pixel_ypos = data_req ? (cnt_v - (V_SYNC + V_BACK - 1'b1)) : 10'd0;		// 如果满足条件则输出像素对应的位置

//行计数器对像素时钟计数
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

//场计数器对行计数
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
