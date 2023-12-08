`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 11:08:12 PM
// Design Name: 
// Module Name: four_by1mux
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


module four_by_1mux(input a,b,c,d,input [1:0] sel, output reg mux_output);
always@* begin
case(sel)
2'b00: mux_output=d;
2'b01: mux_output=c;
2'b10: mux_output=b;
2'b11: mux_output=a;
endcase
end
endmodule