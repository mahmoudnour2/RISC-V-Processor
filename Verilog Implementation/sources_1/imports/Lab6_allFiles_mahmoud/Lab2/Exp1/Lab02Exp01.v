`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 03:20:25 PM
// Design Name: 
// Module Name: Lab02Exp01
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


module Lab02Exp01(input clk,input [7:0] A, input [7:0] B, output [6:0] sevenSeg, output [3:0] anode);
wire cin=0'b0;
wire [8:0] sum;
Eight_Bit_RCA rca(.A(A),.B(B),.cin(cin),.sum(sum));
wire [12:0] new_sum= {4'd0,sum};
Four_Digit_Seven_Segment_Driver bcd(.clk(clk), .num(new_sum), .Anode(anode), .LED_out(sevenSeg));

endmodule
