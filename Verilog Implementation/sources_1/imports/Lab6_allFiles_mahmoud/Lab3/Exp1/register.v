`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 01:58:45 PM
// Design Name: 
// Module Name: register
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


module register #(parameter N=32)(input rst,input clk,input [N-1:0] D, input load, output [N-1:0] Q);
genvar i;
wire [N-1:0] w;
generate 
    for(i=0;i<N;i=i+1)begin
        two_by_1mux mux(.a(D[i]),.b(Q[i]),.sel(load), .mux_output(w[i]));
        DFlipFlop flip_flop(.clk(clk),.rst(rst),.D(w[i]),.Q(Q[i]));
        end
endgenerate

endmodule
