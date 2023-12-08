`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 02:47:49 PM
// Design Name: 
// Module Name: Nbit_mux_TB
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

//parameter N=32)(input [N-1:0] A,input [N-1:0] B, input sel, output [N-1:0] mux_output);
module Nbit_mux_TB();
reg [n-1:0] A;
reg [n-1:0] B;
reg sel;
wire [n-1:0] mux_output;
localparam n=32;

Nbit_mux #(.N(n)) mux(.A(A),.B(B), .sel(sel),.mux_output(mux_output));

initial begin
A=5;
B=32'd10;
sel=1'b1;
#10;
if(mux_output==32'd5)
    $display("example 1 correct");
else
    $display("example 1 incorrect");
#10;
sel=1'b0;
#10;
if(mux_output==32'd10)
    $display("example 2 correct");
else
    $display("example 2 incorrect");
#10;
$finish;
end
endmodule
