`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 05:00:42 PM
// Design Name: 
// Module Name: controlunitTB
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


module controlunitTB(

    );
    reg [31:0]inst;
    wire branch;
    wire memread;
    wire memtoreg;
    wire [1:0]aluop;
    wire memwrite;
    wire alusre;
    wire regwrite;
    control_unit cu(.inst(inst),.branch(branch),.memread(memread),.memtoreg(memtoreg)
    ,.aluop(aluop),.memwrite(memwrite),.alusre(alusre),.regwrite(regwrite));
    
    initial begin
    inst = 32'd48;
    #10
    inst = 32'd0;
    #10
    inst = 32'd32;
    #10
    inst = 32'd96;
    #10
    $finish;
    
    end
    
    
endmodule
