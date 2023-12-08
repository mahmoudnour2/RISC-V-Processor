`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 05:38:59 PM
// Design Name: 
// Module Name: alucontrolunittb
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


module alucontrolunittb(

    );
    
    reg [1:0]aluop;
    reg [31:0]inst;
    wire [3:0]alusel;
    
    alucontrolunit acu(.aluop(aluop),.inst(inst),.alusel(alusel));
    
    initial begin
    
    inst = 32'd0;
    aluop = 2'd0;
    #10
    inst = 32'd0;
    aluop = 2'd1;
    #10
    inst = 32'd0;
    aluop = 2'd2;
    #10
    inst = 32'b01000000000000000000000000000000;
    aluop = 2'd2;
    #10
    inst = 32'b00000000000000000111000000000000;
    aluop = 2'd2;
    #10
    inst = 32'b00000000000000000110000000000000;
    aluop = 2'd2;
    #10
    
    $finish;
    end
    
endmodule
