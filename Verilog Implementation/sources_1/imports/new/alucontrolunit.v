`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 12:33:51 PM
// Design Name: 
// Module Name: alucontrolunit
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

//increasing aluop to 3 bits (maybe 4)
module alucontrolunit(
input [1:0]aluop, input [3:0] inst_por, output reg [3:0]alusel
    );
    //inst_por[2:0] is equal inst[14:12] & inst_por[3] is equal inst[30]
    
    always@(*)
    begin
    case(aluop)
        2'b00: //add
        begin
        case(inst_por)
        4'b0000: alusel = 4'b0000; //add
        4'b1000: alusel = 4'b0001; //sub
        4'b0001: alusel = 4'b1001; //sll
        4'b0010: alusel = 4'b1101; //slt
        4'b0011: alusel = 4'b1111; //sltu
        4'b0100: alusel = 4'b0111; //xor
        4'b0101: alusel = 4'b1000; //srl
        4'b1101: alusel = 4'b1010; //sra
        4'b0110: alusel = 4'b0100; //or
        4'b0111: alusel = 4'b0101; //and
        endcase
        end
        //Itype
        2'b01:
        begin
            case(inst_por[2:0])
                3'b000: alusel = 4'b0000; //addi
                3'b010: alusel = 4'b1101; //slti
                3'b011: alusel = 4'b1111; //sltiu
                3'b100: alusel = 4'b0111; //xori
                3'b110: alusel = 4'b0100; //ori
                3'b111: alusel = 4'b0101; //andi
                3'b001: alusel = 4'b1001; //slli
                3'b101:
                begin
                    case(inst_por[3])
                        1'b0: alusel = 4'b1000; //srli 
                        1'b1: alusel = 4'b1010; //srai
                    endcase
                end
            endcase
        end
        
        //store/load/jalr
        2'b10: alusel = 4'b0000; //add
        //branch
        2'b11: alusel= 4'b0001; //sub
    endcase 
    end
endmodule