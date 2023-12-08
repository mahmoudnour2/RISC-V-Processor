`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 12:33:51 PM
// Design Name: 
// Module Name: DataMem
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


module DataMem
 (input clk, input MemRead, input MemWrite,
 input [7:0] addr, input [31:0] data_in, output reg[31:0] data_out, input [2:0]func3,input reset);
 reg [7:0] mem [255:0]; //was 4*1024 - 1
 
////store and lab6 test memory
 initial begin
 {mem[3],mem[2],mem[1],mem[0]} = 32'd17;
 {mem[7],mem[6],mem[5],mem[4]}  = 32'd9;
 {mem[11],mem[10],mem[9],mem[8]}  = 32'd25;
 {mem[15],mem[14],mem[13],mem[12]}  = 32'h80000000;
 end

//store
 always @(posedge clk) begin
 if(MemWrite ==1) begin
    case(func3)
    3'b000: mem[addr] = data_in[7:0];//SB
    3'b001: begin mem[addr] = data_in[7:0];
    mem[addr+1]= data_in[15:8];//SH
    end
    3'b010: begin mem[addr] = data_in[7:0];
    mem[addr+1]=data_in[15:8]; 
    mem[addr+2]=data_in[23:16];
    mem[addr+3]=data_in[31:24];
    end //SW
    endcase
 end
 end
 integer i;
 always@(posedge clk) begin
 if(reset==1'b1)begin
    for(i=0;i<1024;i=i+1)
        mem[i]<=0;
end
 
 
 end
 
 always @(*) begin
 if(MemRead == 1)begin
    case(func3)
    //3'b000: data_out  <=  {{24{mem[addr][7]}},mem[addr]};//LB
    3'b000: data_out  <=  {(mem[addr][7]==1'b1)?16'hffff:16'h0000,mem[addr]};//LB
    //3'b001: data_out  <=  {{16{mem[addr][15]}},mem[addr+1],mem[addr]};//LH
    3'b001: data_out  <=  {(mem[addr+1][7]==1'b1)?16'hffff:16'h0000,mem[addr+1],mem[addr]};//LH
    3'b010: begin
        data_out  <=  {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};//LW
    end
    3'b100: data_out  <=  {24'd0,mem[addr]};//LBU
    3'b101: data_out  <=  {16'd0,mem[addr+1],mem[addr]};//LHU
    endcase
 end
 end

endmodule

