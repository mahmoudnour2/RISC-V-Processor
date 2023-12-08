`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 11:05:41 PM
// Design Name: 
// Module Name: NBit_4x1mux
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


module NBit_4x1mux #(parameter N=32)(input [N-1:0] A,input [N-1:0] B, input [N-1:0] C,input [N-1:0] D, input [1:0] sel, output [N-1:0] mux_output);
genvar i;
generate 
    for(i=0;i<N;i=i+1)begin
         four_by_1mux mux(.a(A[i]),.b(B[i]),.c(C[i]),.d(D[i]), .sel(sel),.mux_output(mux_output[i]));
         end
endgenerate
endmodule