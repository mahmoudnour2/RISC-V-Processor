`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2023 02:35:37 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(input [4:0] id_ex_rs1, input [4:0] id_ex_rs2, 
input [4:0] mem_wb_rd, input mem_wb_regwrite, output reg  forwardA, output reg  forwardB);
always@(*)begin



if (( mem_wb_regwrite & (mem_wb_rd !=0) & (mem_wb_rd == id_ex_rs1) ))

forwardA = 1'b1; 

else forwardA=1'b0;
end
always@(*)begin


if (( mem_wb_regwrite & (mem_wb_rd !=0) & (mem_wb_rd == id_ex_rs2) ))

forwardB = 1'b1; 

else forwardB=1'b0;


//case (forwardA)
//2'b10:forwardA=forwardA;
//2'b01:forwardA=forwardA;
//default:forwardA=2'b00;
//endcase
//case (forwardB)
//2'b10:forwardB=forwardB;
//2'b01:forwardB=forward;
//default:forwardB=2'b00;
//endcase
end
endmodule
