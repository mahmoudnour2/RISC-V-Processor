`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 02:14:56 PM
// Design Name: 
// Module Name: register_TB
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


module register_TB();
//input rst,input clk,input [N-1:0] D, input load, output [N-1:0] Q
localparam n=32;
localparam period=10;
reg rst;
reg clk;
reg [n-1:0] D;
reg load;
wire [n-1:0] Q;

register #(.N(n)) reg1(.rst(rst),.clk(clk),.D(D), .load(load), .Q(Q));

initial begin
clk = 1'b0;
forever begin
#(period/2) clk=~clk;
end
end

initial begin
rst=1;
load=0;
D=20;
#(period)
rst=0;
load=1;
#(period)
if(D==Q)
   $display ("correct");
else
    $display ("incorrect");
    
    $finish;
#10;
$finish;
end

endmodule
