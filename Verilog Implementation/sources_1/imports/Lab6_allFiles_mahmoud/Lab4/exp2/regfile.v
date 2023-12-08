`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 01:28:23 PM
// Design Name: 
// Module Name: regfile
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


module regfile #(parameter n = 32)(
input clk, input rst,
input RegWrite, input [4:0]readreg1,  input [4:0]readreg2, 
 input [4:0]writereg,  input [n-1:0] writedata, 
 output [n-1:0]read_data1, output [n-1:0]read_data2
    );
    reg [n-1:0]reg_file[31:0];
    assign read_data1=reg_file[readreg1];
    assign read_data2=reg_file[readreg2];
    integer i;
    always@(negedge clk)begin
    if(rst==1'b1)begin
        for(i=0;i<32;i=i+1)
            reg_file[i]<=0;
        
    end
    else begin
        if(RegWrite==1'b1 & writereg > 0)
            reg_file[writereg]<=writedata;
    end    
    end
    
    
endmodule
