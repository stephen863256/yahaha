`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/07 12:24:50
// Design Name: 
// Module Name: SORT
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


module initial_stack
#(
	parameter addr_width = 5,//地址宽度
	parameter data_width = 16//数据宽度
)
(
	input clk,
	input rst_n,
	input en,//使能标志
	input clr,
	output reg done,//完成标志
	
	input [addr_width - 1:0] parent,
	input [addr_width - 1:0] length,
	
	output reg wea,//写使能
	output reg [ addr_width - 1:0 ] addra,//堆输出地址
	output reg [ data_width - 1:0 ] data_we,//写入的数据
	input      [ data_width - 1:0 ] data_re	//读出的数据
);

reg [data_width - 1:0] temp;
reg [addr_width :0] parent_r;//attention: 扩展一个数据宽度
reg [addr_width :0] child_r;
reg [addr_width :0] length_r;

parameter IDLE    = 6'b000001;
parameter BEGIN   = 6'b000010;
parameter GET     = 6'b000100;
parameter COMPARE = 6'b001000;
parameter WRITE   = 6'b010000;
parameter COMPLETE= 6'b100000;


reg [5:0] state;
reg [5:0] next_state;
reg [7:0] cnt;
reg [data_width - 1:0] child_compare;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin state <= IDLE; end
	else       begin state <= next_state; end
end

always@(*)
begin
	case(state)
		IDLE: begin 
					if(en) begin next_state = BEGIN; end
					else   begin next_state = IDLE;  end
				end
		BEGIN:begin
					if(cnt == 8'd2)  begin next_state = GET; end
					else             begin next_state = BEGIN; end
				end
		GET:  begin
					if(child_r >= length_r) begin next_state = COMPLETE; end
					else if(cnt == 8'd4)    begin next_state = COMPARE; end
					else                    begin next_state = GET; end
				end
		COMPARE: begin
						if(temp >= child_compare) begin next_state = COMPLETE; end
						else                      begin next_state = WRITE;    end
				   end
		WRITE:   begin
						if(cnt == 8'd1) begin next_state = GET; end
						else            begin next_state = WRITE; end
					end
		COMPLETE:begin
						if(clr) begin next_state = IDLE; end
						else    begin next_state = COMPLETE; end
					end
	endcase
end

reg [data_width - 1:0] child_R;
reg [data_width - 1:0] child_L;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin done <= 1'b0; end
	else
		begin
			case(state)
				IDLE: begin
							parent_r <= {1'b0, parent};//扩展数据宽度
							length_r <= {1'b0, length};
							child_r  <= 2*parent + 1'b1;//获得对应的儿子
							cnt <= 8'd0; child_R <= 0; child_L <= 0;
							done <= 1'b0;
						end
				BEGIN:begin
							if(cnt == 8'd0)      begin addra <= parent_r; cnt <= cnt + 1'b1; end 
							else if(cnt == 8'd2) begin temp <= data_re; cnt <= 1'b0; end
							else                 begin cnt <= cnt + 1'b1; end
						end
				GET:  begin
							if(child_r >= length_r) begin addra <= addra; end
							else 
								begin
									if(cnt == 8'd0)      begin addra <= child_r; cnt <= cnt + 1'b1; end
									else if(cnt == 8'd1) begin addra <= child_r + 1'b1; cnt <= cnt + 1'b1; end
									else if(cnt == 8'd2) begin child_L <= data_re; cnt <= cnt + 1'b1; end
									else if(cnt == 8'd3) begin child_R <= data_re; cnt <= cnt + 1'b1; end
									else if(cnt == 8'd4)
										begin
											if( (child_r + 1'b1 < length_r) && (child_R > child_L) ) 
												begin 
													child_r <= child_r + 1'b1; 
													child_compare <= child_R;
												end
											else 
												begin 
													child_r <= child_r; 
													child_compare <= child_L;
												end
											cnt <= 8'd0;
										end
									else begin cnt <= cnt + 1'b1; end
							end
						end
				COMPARE: begin end
				WRITE: begin
							 if(cnt == 8'd0) begin 
														addra <= parent_r; wea <= 1'b1; 
														data_we <= child_compare; cnt <= cnt + 1'b1; 
												  end
							 else if(cnt == 8'd1) begin 
															 wea <= 1'b0; cnt <= 8'd0;
															 parent_r <= child_r;
															 child_r <= child_r*2 + 1'b1; 
														 end	
							 else                 begin cnt <= cnt; end
						 end	
				COMPLETE: begin		 
								 if(cnt == 8'd0) begin 
															wea <= 1'b1; addra <= parent_r; 
															data_we <= temp; cnt <= cnt + 1'b1;
														end
								 else if(cnt == 8'd1)
										begin 
											wea <= 1'b0;
											cnt <= cnt + 1'b1;
											done <= 1'b1;
										end
								 else if(cnt == 8'd2)
										begin
											done <= 1'b0;
											cnt <= 8'd2;
										end
							 end
				
			endcase
		end	
end

endmodule

module TOP
#(
	parameter addr_width = 5,   //stack address width
	parameter data_width = 16,   //stack data width
	parameter stack_deepth = 32 //stack deepth
)
(
	input clk,
	input rst_n,
	input exe,
	output reg [15:0] delay,
	output reg busy,
	output wea,
	output [addr_width - 1:0] addra,
	output [data_width - 1:0] data_we,
	input [data_width - 1:0] data_re,
	//input [data_width - 1:0] data_re2,
	output reg [addr_width - 1:0] addr,
	//output [addr_width - 1:0] addr2
	output [addr_width - 1:0] RAM_addr
);
                    
reg en;                           //initial module input: Enable initial process使能
reg clr;				          //initial module input: Reset initial process再次启动
wire done;                        //initial module output: One initial process have done完成
reg [addr_width - 1:0] parent;    //initial module input: Parent
reg [addr_width - 1:0] length;    //initial module input: Length of list

//wire wea;                         //RAM module input: write enable
wire [addr_width - 1:0] addra;	 //RAM module input: write/read address
//wire [data_width - 1:0] data_we;  //RAM module input: write data
//wire [data_width - 1:0] data_re;	 //RAM module output: read data
//wire [data_width - 1:0] data_re2;	 //RAM module output: read data

parameter IDLE    = 10'b0_0000_00001;
parameter BEGIN   = 10'b0_0000_00010;//stage 1: stack initial
parameter RANK    = 10'b0_0000_00100;
parameter FINISH  = 10'b0_0000_01000;
parameter DONE    = 10'b0_0000_10000;

parameter READ    = 10'b0_0001_00000;//stage 2: rank of stack
parameter WRITE   = 10'b0_0010_00000;
parameter RANK_2  = 10'b0_0100_00000;
parameter FINISH_2= 10'b0_1000_00000;
parameter DONE_2  = 10'b1_0000_00000;

reg [addr_width - 1:0] cnt;           //counter in FSM stage 1/2
reg [addr_width - 1:0] cnt2;          //counter in FSM stage 2
reg [9:0] state;                      //FSM state
reg [9:0] next_state;                 //FSM next state
reg [addr_width - 1:0] addr;          //stack inital process read RAM address
//reg [addr_width - 1:0] addr2;          //stack inital process read RAM address
reg initial_done;                     //stack initial done
reg [data_width - 1:0] list_i;        //RANK process reg
reg [data_width - 1:0] list_0;		  //RANK process reg
reg wea_FSM;                          //wea signal from FSM
reg [data_width - 1:0] data_we_FSM;   //write data form FSM

//FSM stage 1: state transform
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin state <= IDLE; end
	else       begin state <= next_state; end
end

//FSM stage 2: state change
always@(*)
begin
	case(state)
	    IDLE : begin if(exe) next_state = BEGIN; 
	           else next_state = IDLE; end
		BEGIN: begin next_state = RANK; end //stack initial process begin
		RANK:  begin
					 if(done) begin next_state = FINISH; end
					 else     begin next_state = RANK; end
				 end
		FINISH:begin 
					if(addr == stack_deepth - 1 & cnt != {addr_width{1'b1}} )      begin next_state = BEGIN; end
					else if(addr == stack_deepth - 1 & cnt == {addr_width{1'b1}} ) begin next_state = DONE; end
					else                                                           begin next_state = FINISH; end
				 end
		DONE:  begin next_state = READ; end //stack initial process have done
		
		
		READ: begin                         //stack rank process begin
					if(cnt == 3) begin next_state = WRITE; end
					else         begin next_state = READ; end
				end
		WRITE:begin
					if(cnt == 2) begin next_state = RANK_2; end
					else         begin next_state = WRITE; end
				end
		RANK_2:begin
					 if(done) begin next_state = FINISH_2; end
					 else     begin next_state = RANK_2; end
				 end
		FINISH_2:begin
						if(addr == stack_deepth - 1 & cnt2 != 0)      begin next_state = READ; end
						else if(addr == stack_deepth - 1 & cnt2 == 0) begin next_state = DONE_2; end
						else                                          begin next_state = FINISH_2; end
					end
		DONE_2:begin next_state = IDLE; end//stack rank process done
	endcase
end
reg [15:0] delay1;
//FSM stage 3: state output
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)  begin cnt <= stack_deepth/2; addr <= {addr_width{1'b1}}; initial_done <= 1'b0; wea_FSM <= 1'b0; busy <= 1'b0;delay <= 16'b0;end
	else 
		begin
		    if(state != IDLE) delay1 <= delay1 +1;
			case(state)
			    IDLE :begin busy <= 0; delay1 <= 0;
			                /*clr <= 1'b0;
							parent <= cnt;
							length  <= stack_deepth;*/end
				BEGIN: begin
				            busy <= 1;                           //stack initial begin
							en <= 1'b1;
							clr <= 1'b0;
							parent <= cnt;
							length  <= stack_deepth;
					   end
				RANK:  begin
							clr <= 1'b0;
						   if(done) begin 
						              cnt <= cnt - 1'b1; 
						              clr <= 1'b1; en <= 1'b0; 
						              addr <= 4'd0; 
						            end
					   end
				FINISH:begin clr <= 1'b0; addr <= addr + 1'b1; end
				DONE:  begin 
								initial_done <= 1'b1;     //stack initial have done
								cnt2 <= stack_deepth - 1;
								cnt  <= 0;
						 end 


			   READ: begin                           //stack rank process begin
							if(cnt == 0)      begin addr <= 0;         cnt <= cnt + 1'b1; end
							else if(cnt == 1) begin addr <= cnt2;      cnt <= cnt + 1'b1; end
							/*if(cnt == 0)      begin 
							                        addr <= 0;         
							                        cnt <= cnt + 1'b1; 
							                        addr2 <= cnt2;   
							                  end*/
							else if(cnt == 2) begin list_0 <= data_re; cnt <= cnt + 1'b1; end
							else if(cnt == 3) begin list_i <= data_re; cnt <= 0; end
							/*else if(cnt == 1) begin 
							                        list_0 <= data_re; 
							                        list_i <= data_re2; 
							                        cnt <= 0; 
							                  end*/
							else              begin cnt <= cnt; end						
						end
				WRITE:begin
							if(cnt == 0)     begin 
														wea_FSM <= 1'b1;
														addr <= 0; data_we_FSM <= list_i;
														cnt <= cnt + 1'b1;
												    end
							else if(cnt == 1) begin
													    wea_FSM <= 1'b1;
														addr <= cnt2; data_we_FSM <= list_0;
														cnt <= cnt + 1'b1;
													end
							else if(cnt == 2) begin wea_FSM <= 1'b0; cnt <= 0; parent <= 0; length <= cnt2; en <= 1'b1; end
							else              begin cnt <= cnt; end
						end
				RANK_2:begin
							 if(done) begin cnt2 <= cnt2 - 1'b1; clr <= 1'b1; en <= 1'b0; addr <= 0; end
						 end
				FINISH_2:begin
								clr <= 1'b0; addr <= addr + 1'b1;
							end
			     DONE_2 : begin  busy <= 0; delay <= delay1;end
			endcase
		end
end

wire wea_initial;
wire [data_width - 1:0] data_we_initial;
//stack initial process
initial_stack U1
(
	.clk(clk),
	.rst_n(rst_n),
	.en(en),
	.clr(clr),
	.done(done),
	
	.parent(parent),
	.length(length),
	
	.wea(wea_initial),
	.addra(addra),
	.data_we(data_we_initial),
	.data_re(data_re)	
);

//wire [addr_width - 1:0] RAM_addr;

assign wea = (state == WRITE) ? wea_FSM:wea_initial;
assign RAM_addr = (state == FINISH || state == READ || state == WRITE || state == FINISH_2) ? addr:addra;
assign data_we = (state == WRITE) ? data_we_FSM:data_we_initial;
//RAM module 
/*Stack_RAM_2 RAM1
(
  .clka(clk),
  .wea(wea),
  .addra(RAM_addr),
  .dina(data_we),
  .douta(data_re)
);*/

endmodule
