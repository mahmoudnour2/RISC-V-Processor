`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 03:44:57 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen (output [31:0] gen_out, input [31:0] inst);
reg [11:0] w;
always@(*)begin
    if(inst[6]==1)begin
          w={inst[31],inst[7],inst[30:25],inst[11:8]};
        //w[3:0]=inst[11:8];
        //w[9:4]=inst[30:25];
        //w[10]=inst[7];
        //w[11]=inst[31];//beq
    end
    else begin
        if(inst[5]==0)
            w=inst[31:20];//LW
        else begin
            w={inst[31:25],inst[11:7]};
            //w[4:0]=inst[7:11];//SW
            //w[11:5]=inst[31:25];
            end
    end
    
end
assign gen_out={{20{w[11]}},w[11:0]};
endmodule
