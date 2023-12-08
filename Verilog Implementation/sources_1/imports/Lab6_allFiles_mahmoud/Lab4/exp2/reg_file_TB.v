`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 02:01:16 PM
// Design Name: 
// Module Name: reg_file_TB
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

//input clk, input rst,
//input RegWrite, input [4:0]readreg1,  input [4:0]readreg2, 
 //input [4:0]writereg,  input [n-1:0] writedata, 
 //output [n-1:0]read_data1, output [n-1:0]read_data2
module reg_file_TB();
localparam n=32;

localparam clk_period = 10;
    reg rst;
    reg clk;
    reg RegWrite;
    reg [4:0] readreg1;
    reg [4:0] readreg2;
    reg [4:0] writereg;
    reg [n-1:0] writedata;
    wire [n-1:0] read_data1;
    wire [n-1:0] read_data2;
    regfile r1(clk,rst,RegWrite,  readreg1, readreg2, writereg,writedata,read_data1, read_data2);
//    regfile #(.n(32)) Reg(.clk(clk),.rst(rst),
//.RegWrite(RegWrite), .readreg1(readreg1), .readreg2(readreg2), 
// .writereg(writereg), .writedata(writedata), 
// .read_data1(read_data1), read_data2(read_data2));
    initial begin
    clk = 0;
    forever begin
    #(clk_period/2) clk = ~clk;
    end
    end
    
    initial begin
    rst = 1;
    #(clk_period);
    rst = 0;
    RegWrite = 1;
    writereg = 5'd5;
    writedata = 32'd20;
    #(clk_period);
    rst = 0;
    RegWrite = 1;
    writereg = 5'd6;
    writedata = 32'd100;
    #(clk_period);
    RegWrite =0;
    readreg1 = 5'd5;
    readreg2 = 5'd6;
    #(clk_period);
    if(read_data1==32'd20)
        $display("Correct");
    else
        $display("Incorrect");
    #10
    $finish;
    end
    
endmodule
