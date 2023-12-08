`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 03:17:33 PM
// Design Name: 
// Module Name: NBit_shift_left_1
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


module NBit_shift_left_1 #(parameter N=32)(input [N-1:0] in,output [N-1:0] out);
    assign out={in[N-2:0],1'b0};
endmodule
