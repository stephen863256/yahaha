`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/07 17:45:01
// Design Name: 
// Module Name: display_data_processing
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

module display_data_processing(
    input hen, ven, pclk, rstn,
    input background,
    input ascii,
    output reg [23:0] raddr,
    output reg [11:0] dx, dy, di, dj,
    output reg [3:0] r, g, b
    );
    parameter xbsz = 4, ybsz = 4, isz = 100, jsz = 12, xsz = 2, ysz = 13;
    reg [11:0] xi = 0, i = 0, yi = 0, j = 0, x = 0, y = 0;
    reg [11:0] cxi = 0, cyi = 0, ci = 0, cx = 0, cj = 0, cy = 0;
    reg ropened = 0;
    reg sel = 0;
    always @(posedge pclk, negedge rstn) begin
        if (!rstn) begin
            {r, g, b} <= 0;
            raddr <= 0;
            {xi, i, yi, j} <= 0;
            ropened <= 0;
            sel <= 0;
            {ci, cx, cj, cy} <= 0;
            {cxi, cyi} <= 0;
            {di, dx, dj, dy} <= 0;
        end
        else begin
            if (hen & ven) begin
                ropened <= 1;
                raddr <= (j + y * 12) * 200 + i + x * 100;
                if (xi == xbsz - 1) begin
                    xi <= 0;
                    if (i == isz - 1) begin
                        i <= 0;
                        if (x == xsz - 1) begin
                            x <= 0;
                            if (yi == ybsz - 1) begin
                                yi <= 0;
                                if ((j == jsz - 1) || (j == 5 && y == 12)) begin
                                    j <= 0;
                                    if (y == ysz - 1) begin
                                        y <= 0;
                                    end
                                    else y <= y + 1;
                                end
                                else j <= j + 1;
                            end
                            else yi <= yi + 1;
                        end
                        else x <= x + 1;
                    end
                    else i <= i + 1;
                end
                else xi <= xi + 1;
                if (((!x && (40 <= i && i <= 67)) ||  (x && ((i <= 27)||(40 <= i && i <= 67)))) && y != 12) begin
                    dx <= cx; dy <= cy; di <= ci - 2; dj <= cj - 2;
                    if (cxi == 3) begin
                        cxi = 0;
                        if (ci == 6) begin
                            ci <= 0;
                            if (cx == 11) begin
                                cx <= 0;
                                if (cyi == 3) begin
                                    cyi <= 0;
                                    if (cj == 11) begin
                                        cj <= 0;
                                        if (cy == 11) begin
                                            cy <= 0;
                                        end
                                        else cy <= cy + 1;
                                    end
                                    else cj <= cj + 1;
                                end
                                else cyi <= cyi + 1;
                            end
                            else cx <= cx + 1;
                        end
                        else ci <= ci + 1;
                    end
                    else cxi <= cxi + 1;
                    if ((2 <= ci && 2 <= cj && cj <= 8)) begin
                        sel <= 1;
                    end
                    else sel <= 0;
                end else sel <= 0;
            end
            else begin
                ropened <= 0;
                sel <= 0;
            end
            if (ropened) begin
                if (!sel)
                    {r, g, b} <= {12{~background}};
                else
                    {r, g, b} <= {12{~ascii}};
            end
            else {r, g, b} <= 12'h000;
        end
    end
endmodule

// module display_data_processing(
//     input hen, ven, pclk, rstn,
//     input [11:0] rdata,
//     output reg [23:0] raddr,
//     output reg [3:0] r, g, b
//     );
//     parameter xbsz = 2, ybsz = 2, xsz = 200, ysz = 150;
//     reg [11:0] xi = 0, x = 0, yi = 0, y = 0;
//     reg ropened = 0;
//     always @(posedge pclk, negedge rstn) begin
//         if (!rstn) begin
//             {r, g, b} <= 0;
//             raddr <= 0;
//             {xi, x, yi, y} <= 0;
//             ropened <= 0;
//         end
//         else begin
//             if (hen & ven) begin
//                 ropened <= 1;
//                 raddr <= x + y * xsz;
//                 if (xi == xbsz - 1) begin
//                     xi <= 0;
//                     if (x == xsz - 1) begin
//                         x <= 0;
//                         if (yi == ybsz - 1) begin
//                             yi <= 0;
//                             if (y == ysz - 1) begin
//                                 y <= 0;
//                             end
//                             else y <= y + 1;
//                         end
//                         else yi <= yi + 1;
//                     end
//                     else x <= x + 1;
//                 end
//                 else xi <= xi + 1;
//             end
//             else ropened <= 0;
//             if (ropened) {r, g, b} <= rdata;
//             else {r, g, b} <= 12'h000;
//         end
//     end
// endmodule
