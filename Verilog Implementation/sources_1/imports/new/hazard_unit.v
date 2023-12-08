`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2023 05:15:36 PM
// Design Name: 
// Module Name: hazard_unit
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


module hazard_unit(
input [4:0]IF_ID_Rs1, input
[4:0]IF_ID_Rs2, input [4:0]ID_EX_rd, input ID_EX_MemRead, output reg stall 

    );
    always @(*) begin
    if (( (IF_ID_Rs1==ID_EX_rd) | (IF_ID_Rs2==ID_EX_rd) ) & ID_EX_MemRead & (ID_EX_rd != 0)) 
    begin 
    stall = 1;
    end
    else stall = 0;
    end
endmodule
