`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/05 20:27:41
// Design Name: 
// Module Name: srt_dio
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


module srt_dio#(
	parameter addr_width = 5,   //stack address width
	parameter data_width = 16   //stack data width
)(
    input [15:0]x,
    input pre,
    input nxt,
    input exe,
    input del,
    input rstn,
    input clk,
    output [7:0] an,
    output [6:0] cn,
    output busy,
    output [15:0] delay
    );
    wire [19:0] y;wire [19:0] y_edge; wire [4:0] hd,hd1;
    db20 db(.x({exe,nxt,pre,del,x}),.clk(clk),.rstn(rstn),.y(y));
    PS20 PS(.clk(clk),.rstn(rstn),.data(y),.pos_edge(y_edge));
    ECD ecd(.e(1'b1),.a(y_edge),.y(hd));
    wire [2:0] s1;
    wire [2:0] s2;
    wire enar;
    wire endr;
    wire we;
    wire exe1;
    reg vld_in;wire vld_out;
    reg done;
    CU cu(.clk(clk),
        .rstn(rstn),
        .s1(s1),
        .s2(s2),
        .we(we),
        .exe(exe1),
        .cu(hd),
        .enar(enar),
        .endr(endr),
        .hd(hd1),
        .busy(busy),
        .delay(delay),
        .vld_in(vld_in),
        .vld_out(vld_out),
        .done(done)
        );
    //×´Ì¬»ú

    reg [addr_width - 1:0] addr;
    wire [addr_width - 1:0] AR;
    wire [addr_width - 1:0] ar;
    wire [data_width - 1:0] data_re;
    wire [data_width - 1:0] data_re1;
    reg  [data_width - 1:0] data_we;
    mux4_1 mux1(.x(5'b00000),
                .y(AR+5'b00001),
                .z(AR-5'b00001),
                .w(addr),
                .en(s1),
                .data(ar)
                );//ËÄÑ¡Ò»Ñ¡ÔñÆ÷
    RG #(.WIDTH(addr_width))AR1(
                      .clk(clk),
                      .rstn(rstn),
                      .en(enar),
                      .q(AR),
                      .d(ar)
                      );//µØÖ·¼Ä´æÆ÷

    wire [data_width - 1:0] DR;
    wire [data_width - 1:0] dr;
    mux4_1 #(.WIDTH(data_width))mux2(
                             .x(DR>>4),
                             .y((DR<<4)+hd1),
                             .z(data_re),
                             .w(data_we),
                             .en(s2),
                             .data(dr)
                             );//Ñ¡ÔñÆ÷
    RG #(.WIDTH(data_width))DR1(
                        .clk(clk),
                        .rstn(rstn),
                        .en(endr),
                        .q(DR),
                        .d(dr)
                        );//Êý¾Ý¼Ä´æÆ÷

    
    register_file RF(
                     .clk(clk),
                     .wa(AR),
                     .wd(DR),
                     .we(we),
                     .ra0(AR),
                     .rd0(data_re),
                     .ra1(AR+1),
                     .rd1(data_re1)
                    );//¼Ä´æÆ÷¶Ñ
    reg [31:0] i;reg [31:0] j;
    reg [data_width-1:0] din [31:0];
    wire[data_width-1:0]dout [31:0];
    initial begin end

    always@(posedge clk or negedge rstn) 
        begin
        if(!rstn)  addr <= 0;
        else if(exe1)
        begin
            done <= 0;
            if(i >= 2 && i <= 32)begin
            din[i-2] <= data_re;
            din[i-1] <= data_re1;end

            if(i == 34) 
            begin
                addr <= 5'b11111;
                vld_in <= 1;
            end
            else 
                begin
                vld_in <= 0;
                i <= i + 2;
                addr <= addr + 2; 
                end
         end
         else if(we && s1 == 3'b11)
            begin 
                 data_we <= dout[j]; 
                 addr <= addr + 1; 
                 if(j == 31)begin  done <= 1; end
                 else begin 
                        j <= j + 1;
                      end
            end
        else if(!busy) begin addr <= 0;vld_in <= 0;i <= 0;j <= 0; end
        end

    sort_32_u8 sort_32_u81(
        .clk(clk),
        .rst_n(rstn),
        .vld_in(vld_in),
        .din_0(din[0]) ,.din_1(din[1]) ,.din_2(din[2]) ,.din_3(din[3]) ,.din_4(din[4]),
        .din_5(din[5]), .din_6(din[6]) ,.din_7(din[7]) ,.din_8(din[8]) ,.din_9(din[9]),
        .din_10(din[10]),.din_11(din[11]),.din_12(din[12]),.din_13(din[13]),.din_14(din[14]),
        .din_15(din[15]),.din_16(din[16]),.din_17(din[17]),.din_18(din[18]),.din_19(din[19]),
        .din_20(din[20]),.din_21(din[21]),.din_22(din[22]),.din_23(din[23]),.din_24(din[24]),
        .din_25(din[25]),.din_26(din[26]),.din_27(din[27]),.din_28(din[28]),.din_29(din[29]),
        .din_30(din[30]),.din_31(din[31]),
        .vld_out(vld_out),
        .dout_0(dout[0]) ,.dout_1(dout[1]) ,.dout_2(dout[2]) ,.dout_3(dout[3]) ,.dout_4(dout[4]),
        .dout_5(dout[5]) ,.dout_6(dout[6]) ,.dout_7(dout[7]) ,.dout_8(dout[8]) ,.dout_9(dout[9]),
        .dout_10(dout[10]),.dout_11(dout[11]),.dout_12(dout[12]),.dout_13(dout[13]),.dout_14(dout[14]),
        .dout_15(dout[15]),.dout_16(dout[16]),.dout_17(dout[17]),.dout_18(dout[18]),.dout_19(dout[19]) ,
        .dout_20(dout[20]),.dout_21(dout[21]),.dout_22(dout[22]),.dout_23(dout[23]),.dout_24(dout[24]),
        .dout_25(dout[25]),.dout_26(dout[26]),.dout_27(dout[27]),.dout_28(dout[28]),.dout_29(dout[29]) ,
        .dout_30(dout[30]),.dout_31(dout[31])
    );



    DIS dis(.clk(clk),.rstn(rstn),.d({3'b000,AR,8'b00000000,DR}),.an(an),.cn(cn));
endmodule
