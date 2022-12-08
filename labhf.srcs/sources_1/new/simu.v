`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 17:09:59
// Design Name: 
// Module Name: simu
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


module simu(
    input clk, key_q, rstn,
    input [9:0] keynum,
    input a, key_b, c, d, e, f,
    input larr, rarr, uarr, darr,
    input enter,
    output [15:0] r0, r1, r2, r3, r4, r5, r6, r7,
    output reg [15:0] pc, mar, mdr, ir, sadd,
    output [15:0] code0, code1, code2, code3, code4, code5, code6, code7, code8, code9, code10, code11,
    output reg editing
    );
    reg signed [15:0] r [7:0];
    assign r0 = r[0]; assign r1 = r[1]; assign r2 = r[2]; assign r3 = r[3]; assign r4 = r[4]; assign r5 = r[5]; assign r6 = r[6]; assign r7 = r[7];
    reg [15:0] memo [63:0];
    reg [15:0] code [11:0];
    assign code0 = memo[sadd[5:0] + 0]; assign code1 = memo[sadd[5:0] + 1]; assign code2 = memo[sadd[5:0] + 2]; assign code3 = memo[sadd[5:0] + 3]; assign code4 = memo[sadd[5:0] + 4]; assign code5 = memo[sadd[5:0] + 5]; assign code6 = memo[sadd[5:0] + 6]; assign code7 = memo[sadd[5:0] + 7];
    assign code8 = memo[sadd[5:0] + 8]; assign code9 = memo[sadd[5:0] + 9]; assign code10 = memo[sadd[5:0] + 10]; assign code11 = memo[sadd[5:0] + 11];

    reg [5:0] cs, ns;
    parameter S0 = 6'd0, S1 = 6'd1, S2 = 6'd2, S3 = 6'd3, S4 = 6'd4, S5 = 6'd5, S6 = 6'd6, S_ENTER = 6'd7, S_END = 6'd8, S_ADD = 6'd9, S_AND = 6'd10, S_NOT = 6'd11,
              S_BR = 6'd12, S_JMP = 6'd13, S_JSR = 6'd14, S_LD = 6'd15, S_LDI_1 = 6'd16, S_LDI_2 = 6'd17, S_LDR = 6'd18, S_LEA = 6'd19, S_ST = 6'd20, S_STI_1 = 6'd21,
              S_STI_2 = 6'd22, S_STR = 6'd23, S_TRAP = 6'd24;
    parameter TRAP = 4'b1111, ADD = 4'b0001, AND = 4'b0101, BR  = 4'b0000, JMP = 4'b1100, JSR = 4'b0100, LD = 4'b0010, LDI = 4'b1010, LDR = 4'b0110, LEA = 4'b1110,
              NOT  = 4'b1001, RTI = 4'b1000, ST  = 4'b0011, STI = 4'b1011, STR = 4'b0111;

    reg n, z, p;
    reg entering;
    always @ (*) begin
        ns = cs;
        case (cs)
            S0: begin
                if (key_q) ns = S1;
                else if (larr) ns = S2;
                else if (rarr) ns = S3;
                else if (uarr) ns = S4;
                else if (enter & ~entering) ns = S_ENTER;
                else if (darr || entering) ns = S5;
                else ns = S0;
            end
            S1: begin
                if (key_q) ns = S0;
                else ns = S1;
            end
            S2: ns = S0;
            S3: ns = S0;
            S4: ns = S0;
            S5: ns = S6;
            S6: begin
                case(ir[15:12])
                    TRAP: ns = S_TRAP;
                    ADD:  ns = S_ADD;
                    AND:  ns = S_AND;
                    NOT:  ns = S_NOT;
                    BR:   ns = S_BR;
                    JMP:  ns = S_JMP;
                    JSR:  ns = S_JSR;
                    LD:   ns = S_LD;
                    LDI:  ns = S_LDI_1;
                    LDR:  ns = S_LDR;
                    LEA:  ns = S_LEA;
                    ST:   ns = S_ST;
                    STI:  ns = S_STI_1;
                    STR:  ns = S_STR;
                endcase
            end
            S_ENTER: ns = S0;
            S_TRAP:  ns = S0;
            S_ADD:   ns = S_END;
            S_AND:   ns = S_END;
            S_NOT:   ns = S_END;
            S_BR:    ns = S_END;
            S_JMP:   ns = S_END;
            S_JSR:   ns = S_END;
            S_LD:    ns = S_END;
            S_LDR:   ns = S_END;
            S_LEA:   ns = S_END;
            S_ST:    ns = S_END;
            S_STR:   ns = S_END;
            S_LDI_1: ns = S_LDI_2;
            S_LDI_2: ns = S_END;
            S_STI_1: ns = S_STI_2;
            S_STI_2: ns = S_END;
            S_END:   ns = S0;
            // to be implemented
        endcase
    end

    always @(negedge rstn, posedge clk) begin
        if (!rstn) begin
            cs <= S0;
        end
        else cs <= ns;
    end

    always @(negedge rstn, posedge clk) begin
        if (!rstn) begin
            editing <= 0;
            entering <= 0;
            sadd <= 16'h3000;
            r[0] <= 0; r[1] <= 0; r[2] <= 0; r[3] <= 0; r[4] <= 0; r[5] <= 0; r[6] <= 0; r[7] <= 0;
            sadd <= 16'h3000; pc <= 16'h3000; mar <= 0; mdr <= 0; ir <= 0; 
            n <= 0; z <= 1; p <= 0;
        end
        else begin
            case(ns)
                S0: begin
                    editing <= 0;
                end
                S1: begin
                    editing <= 1;
                    if (keynum[0]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd0};
                    else if (keynum[1]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd1};
                    else if (keynum[2]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd2};
                    else if (keynum[3]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd3};
                    else if (keynum[4]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd4};
                    else if (keynum[5]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd5};
                    else if (keynum[6]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd6};
                    else if (keynum[7]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd7};
                    else if (keynum[8]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd8};
                    else if (keynum[9]) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'd9};
                    else if (a) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'ha};
                    else if (key_b) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'hb};
                    else if (c) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'hc};
                    else if (d) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'hd};
                    else if (e) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'he};
                    else if (f) memo[sadd[5:0]] <= {memo[sadd[5:0]][11:0], 4'hf};
                end
                S2: begin
                    if (sadd - 1 < 16'h3000) sadd <= 16'h3000;
                    else sadd <= sadd - 1;
                end
                S3: begin
                    if (sadd + 1 + 11 > 16'h303f) sadd <= 16'h303f - 11;
                    else sadd <= sadd + 1;
                end
                S4: begin
                    r[0] <= 0; r[1] <= 0; r[2] <= 0; r[3] <= 0; r[4] <= 0; r[5] <= 0; r[6] <= 0; r[7] <= 0;
                    sadd <= 16'h3000; pc <= 16'h3000; mar <= 0; mdr <= 0; ir <= 0; 
                    n <= 0; z <= 1; p <= 0;
                end
                S5: begin
                    mar <= pc;
                    pc <= pc + 1;
                end
                S6: begin
                    mdr <= memo[mar[11:0]];
                    ir <= memo[mar[11:0]];
                end
                S_ENTER: entering <= 1;
                S_ADD: begin
                    if (!ir[5]) begin
                        r[ir[11:9]] <= r[ir[8:6]] + r[ir[2:0]];
                        if ((r[ir[8:6]] + r[ir[2:0]]) < 0) begin 
                            n <= 1; z <= 0; p <= 0;
                        end
                        else if ((r[ir[8:6]] + r[ir[2:0]]) == 0) begin
                            n <= 0; z <= 1; p <= 0;
                        end
                        else begin
                            n <= 0; z <= 0; p <= 1;
                        end
                    end
                    else begin
                        r[ir[11:9]] <= r[ir[8:6]] + {{11{ir[4]}}, ir[4:0]};
                        if ((r[ir[8:6]] + {{11{ir[4]}}, ir[4:0]}) < 0) begin 
                            n <= 1; z <= 0; p <= 0;
                        end
                        else if ((r[ir[8:6]] + {{11{ir[4]}}, ir[4:0]}) == 0) begin
                            n <= 0; z <= 1; p <= 0;
                        end
                        else begin
                            n <= 0; z <= 0; p <= 1;
                        end
                    end
                end
                S_AND: begin
                    if (!ir[5]) begin
                        r[ir[11:9]] <= r[ir[8:6]] & r[ir[2:0]];
                        if ((r[ir[8:6]] & r[ir[2:0]]) < 0) begin 
                            n <= 1; z <= 0; p <= 0;
                        end
                        else if ((r[ir[8:6]] & r[ir[2:0]]) == 0) begin
                            n <= 0; z <= 1; p <= 0;
                        end
                        else begin
                            n <= 0; z <= 0; p <= 1;
                        end
                    end
                    else begin
                        r[ir[11:9]] <= r[ir[8:6]] & {{11{ir[4]}}, ir[4:0]};
                        if ((r[ir[8:6]] & {{11{ir[4]}}, ir[4:0]}) < 0) begin 
                            n <= 1; z <= 0; p <= 0;
                        end
                        else if ((r[ir[8:6]] & {{11{ir[4]}}, ir[4:0]}) == 0) begin
                            n <= 0; z <= 1; p <= 0;
                        end
                        else begin
                            n <= 0; z <= 0; p <= 1;
                        end
                    end
                end
                S_NOT: begin
                    r[ir[11:9]] <= ~r[ir[8:6]];
                    if ((~r[ir[8:6]]) < 0) begin 
                        n <= 1; z <= 0; p <= 0;
                    end
                    else if ((~r[ir[8:6]]) == 0) begin
                        n <= 0; z <= 1; p <= 0;
                    end
                    else begin
                        n <= 0; z <= 0; p <= 1;
                    end
                end
                S_BR: begin
                    if ((n & ir[11]) || (z & ir[10]) || (p & ir[9]))
                        pc <= pc + {{7{ir[8]}}, ir[8:0]};
                end
                S_JMP: pc <= r[ir[8:6]];
                S_JSR: begin
                    r[7] <= pc;
                    if (ir[11]) pc <= pc + {{7{ir[10]}}, ir[10:0]};
                    else pc <= r[ir[8:6]];
                end
                S_LD: begin
                    mar <= pc + {{7{ir[8]}}, ir[8:0]};
                    mdr <= memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F];
                    r[ir[11:9]] <= memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F];
                    if ((memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F ]) < 0) begin 
                        n <= 1; z <= 0; p <= 0;
                    end
                    else if ((memo[(pc + {{7{ir[8]}}, ir[8:0]} & 6'h3F)]) == 0) begin
                        n <= 0; z <= 1; p <= 0;
                    end
                    else begin
                        n <= 0; z <= 0; p <= 1;
                    end
                end
                S_LDI_1: begin
                    mdr <= memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F];
                end
                S_LDI_2: begin
                    mar <= mdr;
                    mdr <= memo[mdr & 6'h3F];
                    r[ir[11:9]] <= memo[mdr & 6'h3F];
                    if ((memo[mdr & 6'h3F]) < 0) begin 
                        n <= 1; z <= 0; p <= 0;
                    end
                    else if ((memo[mdr & 6'h3F]) == 0) begin
                        n <= 0; z <= 1; p <= 0;
                    end
                    else begin
                        n <= 0; z <= 0; p <= 1;
                    end
                end
                S_LDR: begin
                    mar <= r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]};
                    mdr <= memo[(r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]}) & 6'h3F];
                    r[ir[11:9]] <= memo[(r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]}) & 6'h3F];
                    if ((memo[(r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]}) & 6'h3F]) < 0) begin 
                        n <= 1; z <= 0; p <= 0;
                    end
                    else if ((memo[(r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]}) & 6'h3F]) == 0) begin
                        n <= 0; z <= 1; p <= 0;
                    end
                    else begin
                        n <= 0; z <= 0; p <= 1;
                    end
                end
                S_LEA: begin
                    r[ir[11:9]] <= pc + {{7{ir[8]}}, ir[8:0]};
                end
                S_ST: begin
                    mar <= pc + {{7{ir[8]}}, ir[8:0]};
                    mdr <= r[ir[11:9]];
                    memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F] <= r[ir[11:9]];
                end
                S_STI_1: begin
                    mdr <= memo[(pc + {{7{ir[8]}}, ir[8:0]}) & 6'h3F];
                end
                S_STI_2: begin
                    mar <= mdr;
                    memo[mdr & 6'h3F] <= r[ir[11:9]];
                    mdr <= r[ir[11:9]];
                end
                S_STR: begin
                    mar <= r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]};
                    mdr <= r[ir[11:9]];
                    memo[(r[ir[8:6]] + {{10{ir[5]}}, ir[5:0]}) & 6'h3F] <= r[ir[11:9]];
                end
                S_TRAP: begin
                    if (entering) entering <= 0;
                    pc <= pc - 1;
                end
                S_END: begin
                    if (pc > 16'h303f || pc < 16'h3000) begin
                        if (entering) entering <= 0;
                        pc <= pc - 1;
                    end
                end

            endcase
        end
    end

    genvar geni;
    generate
        for (geni = 0; geni < 64; geni = geni + 1) begin
            initial begin
                memo[geni] <= 0;
            end
        end
    endgenerate
    
endmodule
