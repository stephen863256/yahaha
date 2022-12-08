`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 19:28:48
// Design Name: 
// Module Name: dis_tb
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


module dis_tb();
    reg pclk, rstn;
    reg [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
    reg [15:0] pc, mar, mdr, ir, sadd;
    reg [15:0] code0, code1, code2, code3, code4, code5, code6, code7, code8, code9, code10, code11;
    wire hs, vs;
    wire [3:0] r, g, b;

    display_scan_timing #(.HSW(1), .HBP(2), .HEN(4), .HFP(3),
                   .VSW(1), .VBP(1), .VEN(2), .VFP(1),
                   .xbsz(1), .ybsz(1), .xsz(4), .ysz(2)
                ) DST(.pclk(pclk), .rstn(rstn), .hen(hen), .ven(ven), .hs(hs_t), .vs(vs_t));
    wire [11:0] dx, dy, di, dj;
    wire [23:0] raddr;
    display_data_processing DDP(.hen(hen), .ven(ven), .pclk(pclk), .rstn(rstn), .background(background), .ascii(ascii), .raddr(raddr), .dx(dx), .dy(dy), .di(di), .dj(dj), .r(r), .g(g), .b(b));
    background_mem BMEM(.clka(pclk), .ena(1'b1), .addra(raddr), .douta(background));
    wire [34:0] ascii_35;
    wire [3:0] ascii_addr;
    sel144_4 SEL_IN(.d0(r0), .d1(sadd + 0), .d2(code0),
                    .d3(r1), .d4(sadd + 1), .d5(code1),
                    .d6(r2), .d7(sadd + 2), .d8(code2),
                    .d9(r3), .d10(sadd + 3), .d11(code3),
                    .d12(r4), .d13(sadd + 4), .d14(code4),
                    .d15(r5), .d16(sadd + 5), .d17(code5),
                    .d18(r6), .d19(sadd + 6), .d20(code6),
                    .d21(r7), .d22(sadd + 7), .d23(code7),
                    .d24(pc), .d25(sadd + 8), .d26(code8),
                    .d27(mar), .d28(sadd + 9), .d29(code9),
                    .d30(mdr), .d31(sadd + 10), .d32(code10),
                    .d33(ir), .d34(sadd + 11), .d35(code11),
                    .dx(dx), .dy(dy), .dout(ascii_addr));
    ascii_mem AMEM(.clka(pclk), .ena(1'b1), .addra(ascii_addr), .douta(ascii_35));
    sel35_1 ASCII_SEL(.din(ascii_35), .di(di), .dj(dj), .dout(ascii));
    register #(.WIDTH(2)) RG_hv0(.clk(pclk), .rstn(rstn), .en(1'd1), .d({hs_t, vs_t}), .q({hs_t1, vs_t1}));
    register #(.WIDTH(2)) RG_hv1(.clk(pclk), .rstn(rstn), .en(1'd1), .d({hs_t1, vs_t1}), .q({hs, vs}));

    initial begin
        rstn = 0; #1; rstn = 1;
    end
    initial begin
        {r0, r1, r2, r3, r4, r5, r6, r7, pc, mar, mdr, ir, sadd, code0, code1, code2, code3, code4, code5, code6, code7, code8, code9, code10, code11} =
            400'hae79_ead3_41bf_778d_5115_a796_94ee_68d5_f2bd_b623_b305_09cd_e6e4_a30f_5982_b3bd_9191_451d_f3f9_7c23_d0de_53ad_09ed_ea14_afac;
        forever begin
            pclk = 0; #1; pclk = 1; #1;
        end
    end
endmodule
