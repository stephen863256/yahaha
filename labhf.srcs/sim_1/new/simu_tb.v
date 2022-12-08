`timescale 0.1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/06 15:44:40
// Design Name: 
// Module Name: simu_tb
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


module simu_tb();
    reg clk, q, rstn;
    reg [9:0] keynum;
    reg a, b, c, d, e, f;
    reg larr, rarr, uarr, darr;
    reg enter;
    wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
    wire [15:0] pc, mar, mdr, ir;
    wire [15:0] code0, code1, code2, code3, code4, code5, code6, code7, code8, code9, code10, code11;
    wire editing;

    simu SIMU(.clk(clk), .q(q), .rstn(rstn), .keynum(keynum), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .larr(larr), .rarr(rarr), .uarr(uarr), .darr(darr), .enter(enter),
              .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .pc(pc), .mar(mar), .mdr(mdr), .ir(ir), .code0(code0), .code1(code1), .code2(code2),
              .code3(code3), .code4(code4), .code5(code5), .code6(code6), .code7(code7), .code8(code8), .code9(code9), .code10(code10), .code11(code11), .editing(editing));
    
    
    initial begin
        #1;
        forever begin
            clk = 0; #1; clk = 1; #1;
        end
    end
    
    initial begin
        q = 0; keynum = 0; a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; larr = 0; rarr = 0; uarr = 0; darr = 0; enter = 0;
        rstn = 0; #1; rstn = 1;
        #3;
        q = 1; #2; q = 0;
            keynum[2] = 1; #2; keynum[2] = 0; keynum[2] = 1; #2; keynum[2] = 0; keynum[0] = 1; #2; keynum[0] = 0; e = 1; #2; e = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;
        

        q = 1; #2; q = 0;
            keynum[2] = 1; #2; keynum[2] = 0; keynum[4] = 1; #2; keynum[4] = 0; keynum[0] = 1; #2; keynum[0] = 0; e = 1; #2; e = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[0] = 1; #2; keynum[0] = 0; c = 1; #2; c = 0; keynum[0] = 1; #2; keynum[0] = 0; b = 1; #2; b = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[9] = 1; #2; keynum[9] = 0; keynum[4] = 1; #2; keynum[4] = 0; b = 1; #2; b = 0; f = 1; #2; f = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; keynum[4] = 1; #2; keynum[4] = 0; a = 1; #2; a = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; b = 1; #2; b = 0; a = 1; #2; a = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[5] = 1; #2; keynum[5] = 0; keynum[9] = 1; #2; keynum[9] = 0; keynum[4] = 1; #2; keynum[4] = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[0] = 1; #2; keynum[0] = 0; keynum[4] = 1; #2; keynum[4] = 0; keynum[0] = 1; #2; keynum[0] = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; d = 1; #2; d = 0; a = 1; #2; a = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; b = 1; #2; b = 0; keynum[4] = 1; #2; keynum[4] = 0; keynum[5] = 1; #2; keynum[5] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; keynum[6] = 1; #2; keynum[6] = 0; e = 1; #2; e = 0; keynum[1] = 1; #2; keynum[1] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; keynum[8] = 1; #2; keynum[8] = 0; c = 1; #2; c = 0; keynum[2] = 1; #2; keynum[2] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[0] = 1; #2; keynum[0] = 0; keynum[9] = 1; #2; keynum[9] = 0; f = 1; #2; f = 0; keynum[9] = 1; #2; keynum[9] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[3] = 1; #2; keynum[3] = 0; c = 1; #2; c = 0; keynum[0] = 1; #2; keynum[0] = 0; keynum[3] = 1; #2; keynum[3] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            f = 1; #2; f = 0; keynum[0] = 1; #2; keynum[0] = 0; keynum[2] = 1; #2; keynum[2] = 0; keynum[5] = 1; #2; keynum[5] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[1] = 1; #2; keynum[1] = 0; keynum[1] = 1; #2; keynum[1] = 0; keynum[4] = 1; #2; keynum[4] = 0; keynum[5] = 1; #2; keynum[5] = 0;
        q = 1; #2; q = 0; rarr = 1; #2; rarr = 0; #2;

        q = 1; #2; q = 0;
            keynum[0] = 1; #2; keynum[0] = 0; keynum[0] = 1; #2; keynum[0] = 0; keynum[0] = 1; #2; keynum[0] = 0; e = 1; #2; e = 0;
        q = 1; #2; q = 0;

        larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2;
        larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2;
        larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2;
        larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2; larr = 1; #2; larr = 0; #2;
        #2;
        enter = 1; #2; enter = 0;
        #2000;
        rarr = 1; #2; rarr = 0; #2; rarr = 1; #2; rarr = 0; #2; rarr = 1; #2; rarr = 0; #2;
        rarr = 1; #2; rarr = 0; #2; rarr = 1; #2; rarr = 0; #2; rarr = 1; #2; rarr = 0; #2;
    end
endmodule