`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 03:30:14 PM
// Design Name: 
// Module Name: alu
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


module alu #(parameter n = 32)(
input [n-1:0]A, input [n-1:0]B, input [3:0]sel, output reg zeroflag, output reg [n-1:0]ALUout
);
wire [n-1:0] anding;
wire [n-1:0] oring;
wire [n-1:0] notb;
assign anding = A & B;
assign oring = A | B;
assign notb  = ~B+1;

reg [n-1:0]addorsub;
always@(*) begin
case(sel[2])
    1'b0: addorsub = B;
    1'b1: addorsub = notb;
endcase
end

wire [n-1:0] sum;
wire carryout;

Eight_Bit_RCA #(n)rca(.A(A),.B(addorsub), .cin(sel[2]), .sum(sum));

always@(*) begin
case(sel)
    4'b0010: ALUout = sum;
    4'b0110: ALUout = sum;
    4'b0000: ALUout = anding;
    4'b0001: ALUout = oring;
    default: ALUout = 32'd0; 
    
endcase
end
always@(*) begin
if(ALUout == 32'd0) begin
zeroflag = 1'b1;
end
else begin
zeroflag = 1'b0;
end
end


endmodule
