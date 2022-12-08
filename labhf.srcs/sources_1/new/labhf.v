`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 22:55:18
// Design Name: 
// Module Name: labhf
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


module labhf(
    input clk, rstn, ps2k_clk, ps2k_data,
    output hs, vs,
    output [3:0] r, g, b,
    output lt0
    );
    wire [7:0] ps2_byte;
    ps2_keyboard_driver PSK(.clk(clk), .rst_n(rstn), .ps2k_clk(ps2k_clk), .ps2k_data(ps2k_data), .ps2_byte(ps2_byte), .ps2_state(ps2_state));
    wire [9:0] keynum;
    ecd ECD(.clk(clk), .rst_n(rstn), .ps2_byte(ps2_byte), .keynum(keynum),
            .a(a), .key_b(key_b), .c(c), .d(d), .e(e), .f(f), .key_q(key_q), .larr(larr), .rarr(rarr), .uarr(uarr), .darr(darr), .enter(enter));
    wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
    wire [15:0] pc, mar, mdr, ir, sadd;
    wire [15:0] code0, code1, code2, code3, code4, code5, code6, code7, code8, code9, code10, code11;
    simu SIMU(.clk(clk), .rstn(rstn), .keynum(keynum),
            .a(a), .key_b(key_b), .c(c), .d(d), .e(e), .f(f), .key_q(key_q), .larr(larr), .rarr(rarr), .uarr(uarr), .darr(darr), .enter(enter),
            .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .pc(pc), .mar(mar), .mdr(mdr), .ir(ir), .sadd(sadd),
            .code0(code0), .code1(code1), .code2(code2), .code3(code3), .code4(code4), .code5(code5), .code6(code6), .code7(code7),
            .code8(code8), .code9(code9), .code10(code10), .code11(code11), .editing(lt0));
    dis DIS(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .pc(pc), .mar(mar), .mdr(mdr), .ir(ir), .sadd(sadd),
            .code0(code0), .code1(code1), .code2(code2), .code3(code3), .code4(code4), .code5(code5), .code6(code6), .code7(code7),
            .code8(code8), .code9(code9), .code10(code10), .code11(code11),
            .clk(clk), .rstn(rstn), .hs(hs), .vs(vs), .r(r), .g(g), .b(b));
endmodule
