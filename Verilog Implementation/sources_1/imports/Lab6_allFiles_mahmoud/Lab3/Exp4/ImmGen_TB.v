`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 03:56:42 PM
// Design Name: 
// Module Name: ImmGen_TB
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


module ImmGen_TB();
wire [31:0] gen_out;
reg [31:0] inst;
ImmGen test_case(.gen_out(gen_out),.inst(inst));

initial begin
inst=32'b00000000110000011010000010000011;
#10;
if(gen_out==12)
    $display("correct");
else
    $display("incorrect");
#10;

inst=32'b00000000000100011010011000100011;
#10;
if(gen_out==12)
    $display("correct");
else
    $display("incorrect");
#10;

inst=32'b00000000001100001000011001100011;
#10;
if(gen_out==6)
    $display("correct");
else
    $display("incorrect");
#20;
$finish;
end
endmodule
