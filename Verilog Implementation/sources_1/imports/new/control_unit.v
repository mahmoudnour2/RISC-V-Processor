`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 02:34:41 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit(
input [6:0] opcode, output reg branch, output reg memread, output reg memtoreg,
 output reg[2:0]aluop, output reg memwrite, output reg alusrc, output reg regwrite, output reg jalr, output reg jal
    );
    wire [4:0]inst_portion;
    assign inst_portion = opcode[6:2];
    
    always@(*) begin
    case(inst_portion)
    //RType
    5'b01100: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00;
    memwrite = 0;
    alusrc = 0;
    regwrite = 1;
    jalr=0;
    jal=0;
    end
    
    //loads
    5'b00000: begin
    branch = 0;
    memread = 1;
    memtoreg = 1;
    aluop = 2'b10;
    memwrite = 0;
    alusrc = 1;
    regwrite = 1;
    jalr=0;
    jal=0;
    end
    
    //stores
    5'b01000: begin
    branch = 0;
    memread = 0;
    aluop = 2'b10;
    memwrite = 1;
    alusrc = 1;
    regwrite = 0;
    jalr=0;
    jal=0;
    end
    
    //branches
    5'b11000: begin
    branch = 1;
    memread = 0;
    aluop = 2'b11;
    memwrite = 0;
    alusrc = 0;
    regwrite = 0;
    jalr=0;
    jal=0;
    end
    
    
    //lui
    5'b01101: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00; //dont care
    memwrite = 0;
    alusrc = 0; 
    regwrite = 1;
    jalr=0;
    jal=0;
    end
    
    //auipc still unsupported: need to add shift left logical 12 using shifter shamt = 01100
    //need to add the result to pc and and give the result to reg mux
    5'b00101: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00; //dont care
    memwrite = 0;
    alusrc = 0; //dont care
    regwrite = 1;
    jalr=0;
    jal=0;
    end
    
    
    //modify controls
    //jal
    //need to pass pc+4 to reg mux 
    //need to pass target address to pc mux
    //need to or output of and gate with a new control signal jal
    5'b11011: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00; //dont care
    memwrite = 0;
    alusrc = 0; //dont care
    regwrite = 1;
    jalr=0;
    jal=1;
    end
    
    //jalr
    //need to pass pc+4 to reg mux
    //need to pass rs + offset to pc mux 
    //need to or output of and gate with a new control signal jalr
    5'b11001: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b10; //add
    memwrite = 0;
    alusrc = 1; //alu input is immgetnout
    regwrite = 1;
    jalr=1;
    jal=0;
    end
    
    //Immediates
    5'b00100: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b01;
    memwrite = 0;
    alusrc = 1;
    regwrite = 1;
    jalr=0;
    jal=0;
    end
    
    //fence and ecall
    5'b00011: begin
    branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00; //dont care
    memwrite = 0;
    alusrc = 0; //dont care
    regwrite = 0;
    jalr=0;
    jal=0;
    end
    
    //ebreak
    5'b11100: begin
     branch = 0;
    memread = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    memtoreg = 0;
    aluop = 2'b00; //dont care
    memwrite = 0;
    alusrc = 0;
    regwrite = 0;
    jalr=0;
    jal=0;
    end
    
    
    endcase
    end
endmodule
