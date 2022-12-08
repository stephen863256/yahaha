`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/28 22:27:30
// Design Name: 
// Module Name: DB
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


module DB(
    input x,
    input clk,
    input rstn,
    output y
    );
    wire out1,out2,out;
    db db1(.out1(out1),.out2(out2),.out3(out),.but_in(x),.clk(clk),.rstn(rstn));
    _RSFF _RSFF(.Q(y),.R(out2),.S(out1),.CP(out));
endmodule

module db(
    input clk,
    input rstn,
    input but_in,
    output out1,
    output out2,
    output  out3
);
reg   delay0;
reg   delay1;
reg   delay2;

always @(posedge clk or negedge rstn)
    begin
        if(!rstn)
            begin
                delay0 <= 0;
                delay1 <= 0;
                delay2 <= 0;
            end
        else
            begin
                delay0 <= but_in;
                delay1 <= delay0;
                delay2 <= delay1;
            end
    end
 assign out1 = delay0&&delay1&delay2;
 assign out2 = ~(delay0&delay1&delay2);
 assign out3 = clk;
endmodule

module _RSFF#(parameter WIDTH = 1)(
    input R,
    input S,
    input CP,
    output reg [WIDTH-1:0] Q
);
always @(posedge CP)
    begin
        case ({R,S})
        2'b00 : Q <= Q;
        2'b01 : Q <= 1'b1;
        2'b10 : Q <= 1'b0;
        default ;
        endcase

    end

endmodule

module db20(
    input [19:0] x,
    input clk,
    input rstn,
    output [19:0] y
);

DB db0(.x(x[0]),.clk(clk),.rstn(rstn),.y(y[0]));
DB db1(.x(x[1]),.clk(clk),.rstn(rstn),.y(y[1]));
DB db2(.x(x[2]),.clk(clk),.rstn(rstn),.y(y[2]));
DB db3(.x(x[3]),.clk(clk),.rstn(rstn),.y(y[3]));
DB db4(.x(x[4]),.clk(clk),.rstn(rstn),.y(y[4]));
DB db5(.x(x[5]),.clk(clk),.rstn(rstn),.y(y[5]));
DB db6(.x(x[6]),.clk(clk),.rstn(rstn),.y(y[6]));
DB db7(.x(x[7]),.clk(clk),.rstn(rstn),.y(y[7]));
DB db8(.x(x[8]),.clk(clk),.rstn(rstn),.y(y[8]));
DB db9(.x(x[9]),.clk(clk),.rstn(rstn),.y(y[9]));
DB db10(.x(x[10]),.clk(clk),.rstn(rstn),.y(y[10]));
DB db11(.x(x[11]),.clk(clk),.rstn(rstn),.y(y[11]));
DB db12(.x(x[12]),.clk(clk),.rstn(rstn),.y(y[12]));
DB db13(.x(x[13]),.clk(clk),.rstn(rstn),.y(y[13]));
DB db14(.x(x[14]),.clk(clk),.rstn(rstn),.y(y[14]));
DB db15(.x(x[15]),.clk(clk),.rstn(rstn),.y(y[15]));
DB db16(.x(x[16]),.clk(clk),.rstn(rstn),.y(y[16]));
DB db17(.x(x[17]),.clk(clk),.rstn(rstn),.y(y[17]));
DB db18(.x(x[18]),.clk(clk),.rstn(rstn),.y(y[18]));
DB db19(.x(x[19]),.clk(clk),.rstn(rstn),.y(y[19]));

endmodule