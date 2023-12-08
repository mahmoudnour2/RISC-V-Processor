`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 02:16:02 PM
// Design Name: 
// Module Name: Eight_Bit_RCA
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


module Eight_Bit_RCA #(parameter n=8)(
input [n-1:0] A,input [n-1:0] B,output [n:0] sum,input cin
    );
    wire [n:0] cout_wire;
    assign cout_wire[0]=0'd0;
    genvar i;
    generate
        for(i=0;i<n;i=i+1) begin
            fullAdder FA1(.a(A[i]), .b(B[i]),.cin(cout_wire[i]),.result(sum[i]),.cout(cout_wire[i+1]));
        end
    endgenerate
    assign sum[n]=cout_wire[n];
endmodule
