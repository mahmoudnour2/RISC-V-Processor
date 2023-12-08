`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 12:41:48 PM
// Design Name: 
// Module Name: DataMemTB
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


module DataMemTB(

    );
    reg clk;
    reg MemRead;
    reg MemWrite; 
    reg [5:0] addr;
    reg [31:0] data_in;
    wire [31:0] data_out;
    
    DataMem dm(.clk(clk),.MemRead(MemRead),.MemWrite(MemWrite)
    ,.addr(addr),.data_in(data_in),.data_out(data_out));
    
    localparam clk_period = 10;
    
    initial begin
    clk = 0;
    forever begin
    clk = ~clk;
    #(clk_period/2);
    end
    end
    
    initial begin 
    MemRead = 0;
    MemWrite = 1;
    addr = 1;
    data_in=32'd5;
    #clk_period;
    
    MemRead = 0;
    MemWrite  = 1;
    data_in = 32'd10;
    addr = 2;
    #clk_period;
    
    MemRead=1;
    MemWrite=0;
    addr=1;
    #clk_period;
    if(data_out == 32'd5) $display("read success for ex1");
    else $display("read fail for ex2");
    
    MemRead = 1;
    MemWrite=0;
    addr=2;
  
    #clk_period;
  if(data_out == 32'd10) $display("read success for ex2");
    else $display("read fail for ex2");
    $finish;
    
    end
    
    
endmodule
