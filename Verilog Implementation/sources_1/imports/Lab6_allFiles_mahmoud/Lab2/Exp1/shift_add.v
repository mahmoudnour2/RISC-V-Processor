

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 04:15:43 PM
// Design Name: 
// Module Name: shift_add
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


module shift_add (
input [12:0] num,
output reg [3:0] Thousandth,
output reg [3:0] Hundreds,
output reg [3:0] Tens,
output reg [3:0] Ones
);
integer i;
always @(num)
begin
//initialization
Thousandth=4'd0;
Hundreds = 4'd0;
Tens = 4'd0;
Ones = 4'd0;
for (i = 12; i >= 0 ; i = i-1 )
begin
if (Thousandth >= 5)
Thousandth = Thousandth +3;
if(Hundreds >= 5 )
Hundreds = Hundreds + 3;
if (Tens >= 5 )
Tens = Tens + 3;
if (Ones >= 5)
Ones = Ones +3;
//shift left one
Thousandth= Thousandth <<1;
Thousandth [0]=Hundreds[3];
Hundreds = Hundreds << 1;
Hundreds [0] = Tens [3];
Tens = Tens << 1;
Tens [0] = Ones[3];
Ones = Ones << 1;
Ones[0] = num[i];
end
end
endmodule