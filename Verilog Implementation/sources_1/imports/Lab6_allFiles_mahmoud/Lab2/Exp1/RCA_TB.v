`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 02:40:36 PM
// Design Name: 
// Module Name: RCA_TB
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


module RCA_TB();
reg [7:0] A;
reg [7:0] B;
wire [8:0] sum;
reg cin;

Eight_Bit_RCA rca(.A(A),.B(B),.cin(cin),.sum(sum));
initial begin 
    A=8'd0;
    B=8'd0;
    cin=0;
    #1;
    if(A+B==sum)
        $display("correct");
    else
       $display("at time %t fail sum=%d", $time,sum); 
    A=8'd255;
    B=8'd255;
    cin=0;
    if(A+B==sum)
        $display("correct");
    else
        $display("at time %t fail sum=%d", $time,sum);
    #1;
    $finish;
end
endmodule
