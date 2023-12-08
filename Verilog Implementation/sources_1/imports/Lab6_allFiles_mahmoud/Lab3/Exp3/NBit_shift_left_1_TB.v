`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2023 03:27:46 PM
// Design Name: 
// Module Name: NBit_shift_left_1_TB
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


module NBit_shift_left_1_TB();
localparam n=32;
reg [n-1:0] in;
wire [n-1:0] out;
NBit_shift_left_1 #(.N(n))shifter(.in(in),.out(out));
initial begin
    in=32'd5;
    #10;
    if(out==32'd10)
        $display("correct");
    else
        $display("incorrect");
    #10;
    in=32'd10;
    #10;
    if(out==32'd20)
        $display("correct");
    else
        $display("incorrect");
    $finish;
end

endmodule
