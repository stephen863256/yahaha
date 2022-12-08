`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 16:25:33
// Design Name: 
// Module Name: display_scan_timing
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


module display_scan_timing #(
    parameter HSW = 120, HBP = 64, HEN = 800, HFP = 56,
	          VSW =   6, VBP = 23, VEN = 600, VFP = 37
)(
    input  rstn, pclk,
    output hen, ven, hs, vs
    );
    reg hs_t1, vs_t1, hen_t1, ven_t1;
    integer HTT = HSW + HBP + HEN + HFP;
    integer VTT = VSW + VBP + VEN + VFP;
    reg [11:0] nowh, nowv;
    register #(.WIDTH(4)) reg_out(.rstn(rstn), .clk(pclk), .en(1'b1), .d({hs_t1, vs_t1, hen_t1, ven_t1}), .q({hs, vs, hen, ven}));
    always @(posedge pclk, negedge rstn) begin
        if (!rstn) begin
            nowh <= 0; nowv <= 0;
            hs_t1 <= 0; vs_t1 <= 0;
            hen_t1 <= 0; ven_t1 <= 0;
        end else begin
            if (0 <= nowh && nowh <= HSW - 1)
                hs_t1 <= 1;
            else hs_t1 <= 0;
            if (0 <= nowv && nowv <= VSW - 1)
                vs_t1 <= 1;
            else vs_t1 <= 0;
            if (HSW + HBP <= nowh && nowh < HSW + HBP + HEN)
                hen_t1 <= 1;
            else hen_t1 <= 0;
            if (VSW + VBP <= nowv && nowv < VSW + VBP + VEN)
                ven_t1 <= 1;
            else ven_t1 <= 0;
            if (nowh == HTT - 1) begin
                nowh <= 0;
                if (nowv == VTT - 1)  nowv <= 0;
                else nowv <= nowv + 1;
            end
            else nowh <= nowh + 1;
            
        end
    end
endmodule