`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 02:09:07 PM
// Design Name: 
// Module Name: processor_tb
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


module processor_tb();
reg clk;
reg reset;
reg [1:0] ledSel;
reg [3:0] ssdSel;
wire [15:0]leds;
wire [12:0]ssd;

processor process(.clk(clk),.reset(reset));
    
initial begin 
clk = 0;
    forever begin
    #10 clk = ~clk;
    end
end

initial begin
reset=1;
#20;
reset=0;
end
endmodule
