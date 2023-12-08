`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 02:41:10 PM
// Design Name: 
// Module Name: Nbit_mux
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


module Nbit_mux #(parameter N=32)(input [N-1:0] A,input [N-1:0] B, input sel, output [N-1:0] mux_output);
genvar i;
generate 
    for(i=0;i<N;i=i+1)begin
         two_by_1mux mux(.a(A[i]),.b(B[i]), .sel(sel),.mux_output(mux_output[i]));
    end
endgenerate

endmodule
