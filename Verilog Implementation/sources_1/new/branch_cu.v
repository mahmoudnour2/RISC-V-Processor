`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 10:42:35 PM
// Design Name: 
// Module Name: branch_cu
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


module branch_cu(input cf,zf,vf,sf,branch, input [2:0] func3, output reg output_of_branch_cu);
always@(*)begin
case(func3)
3'b000:output_of_branch_cu=zf &branch;
3'b001:output_of_branch_cu=~zf & branch;
3'b100:output_of_branch_cu=(sf!=vf)&branch;
3'b101:output_of_branch_cu=(sf==vf)&branch;
3'b110:output_of_branch_cu=~cf &branch;
3'b111:output_of_branch_cu=cf&branch;
endcase
end
endmodule
