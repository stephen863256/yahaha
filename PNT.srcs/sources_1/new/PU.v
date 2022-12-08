`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/18 09:09:27
// Design Name: 
// Module Name: PU
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


module PU (
    input draw,
    input up,
    input down,
    input left,
    input right,
    input [11:0] prgb,
    input rstn,
    input clk,
    output  reg [14:0] waddr,
    output  reg [11:0] wdata,
    output  we
);

  reg [7:0] count; 
  reg [23:0] count_1;
  parameter N=23'h3F4240;
  assign we = draw;


always@(posedge clk or negedge rstn) 
begin
        if(!rstn) begin
            waddr<=13'b0;
            count<=8'b0;
            count_1<=23'b0;
        end
        else begin
            wdata<=prgb;
            if((up||down||left||right)) begin
                if(waddr>200 && up && left && count > 0 && count_1 >= N)
                begin
                    waddr<=waddr -201;
                    count<=count-1;
                    count_1<=0;
                end
                else if(waddr>199 && up && waddr < 29999 && right && count <199 && count_1 >= N) 
                begin
                    waddr<=waddr-199;
                    count<=count+1;
                    count_1 <= 0; 
                end
                else if(waddr<=29799&& down && left && count > 0 && count_1 >= N) 
                begin
                    waddr<=waddr + 199;
                    count_1<= 0;
                    count<=count-1;
                end
                else if(waddr<=29798&& down && right && count <199 && count_1 >= N) 
                begin
                    waddr<=waddr + 201;
                    count_1<= 0;
                    count<=count+1;
                end
                else if(waddr>199 && up && count_1 >= N) 
                begin
                    waddr<=waddr-200;
                    count_1 <= 0; 
                end
                else if(waddr <= 29799 && down && count_1 >= N) 
                begin
                    waddr<=waddr + 200;
                    count_1<= 0;
                end
                else if(waddr < 29999 && right && count <199 && count_1 >= N)
                    begin 
                        waddr<=waddr+1;
                        count<=count+1;
                        count_1<=0;
                    end
                else if(waddr > 0 && left && count > 0 && count_1 >= N)
                    begin 
                        waddr<=waddr-1;
                        count<=count-1;
                        count_1 <=0;
                    end
                else begin
                    count_1 <= count_1+1;
                 end
            end
        end
end



endmodule
