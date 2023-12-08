`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 12:03:19 PM
// Design Name: 
// Module Name: InstMemTB
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


module InstMemTB(

    );
    reg [5:0] addr; 
    wire [31:0] data_out;
    
    InstMem IM(.addr(addr),.data_out(data_out));
    
 
    
    initial begin
    addr = 0;
    #10
    if(data_out == 32'b000000000000_00000_010_00001_0000011) $display("correct 0");
    else $display("fail 0");
    addr = 1;
    #10
    if(data_out == 32'b000000000100_00000_010_00010_0000011) $display("correct 1");
    else $display("fail 1");
    addr = 2;
    #10
    if(data_out == 32'b000000001000_00000_010_00011_0000011) $display("correct 2");
    else $display("fail 2");
    addr = 3;
    #10
    if(data_out ==32'b0000000_00010_00001_110_00100_0110011) $display("correct 3");
    else $display("fail 3");
    addr = 4;
    #10
    if(data_out == 32'b0_000000_00011_00100_000_0100_0_1100011) $display("correct 4");
    else $display("fail 4");
    $finish;
    end
    
    
endmodule
