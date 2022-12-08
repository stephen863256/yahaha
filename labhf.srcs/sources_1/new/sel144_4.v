`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 18:54:39
// Design Name: 
// Module Name: sel144_4
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


module sel144_4(
    input [15:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, 
                 d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23,
                 d24, d25, d26, d27, d28, d29, d30, d31, d32, d33, d34, d35,
    input [11:0] dx, dy,
    output reg [3:0] dout
    );
    wire [48:0] data [11:0];
    assign data[0] = {d0, d1, d2};
    assign data[1] = {d3, d4, d5};
    assign data[2] = {d6, d7, d8};
    assign data[3] = {d9, d10, d11};
    assign data[4] = {d12, d13, d14};
    assign data[5] = {d15, d16, d17};
    assign data[6] = {d18, d19, d20};
    assign data[7] = {d21, d22, d23};
    assign data[8] = {d24, d25, d26};
    assign data[9] = {d27, d28, d29};
    assign data[10] = {d30, d31, d32};
    assign data[11] = {d33, d34, d35}; 
    wire [48:0] nowd;
    assign nowd = data[dy];
    always @ (*) begin
        case (dx)
            11'd0: dout = nowd[47:44];
            11'd1: dout = nowd[43:40];
            11'd2: dout = nowd[39:36];
            11'd3: dout = nowd[35:32];
            11'd4: dout = nowd[31:28];
            11'd5: dout = nowd[27:24];
            11'd6: dout = nowd[23:20];
            11'd7: dout = nowd[19:16];
            11'd8: dout = nowd[15:12];
            11'd9: dout = nowd[11:8];
            11'd10: dout = nowd[7:4];
            11'd11: dout = nowd[3:0];
        endcase
    end
endmodule
