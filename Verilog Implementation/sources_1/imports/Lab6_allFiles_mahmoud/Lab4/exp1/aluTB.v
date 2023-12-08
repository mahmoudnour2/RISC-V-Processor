`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 12:48:16 PM
// Design Name: 
// Module Name: aluTB
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


module aluTB(
    );
  
    localparam n = 32;
    reg [n-1:0]A;
    reg [n-1:0]B;
    reg [3:0]sel;
    wire [n-1:0]ALUout;
    wire zeroflag;
    
    top_module t(.A(A),.B(B),.sel(sel), .ALUout(ALUout), .zeroflag(zeroflag));
    
    initial begin
    A = 32'd15;
    B = 32'd10;
    sel = 4'b0010;
    
    #10 
    
    A = 32'd15;
    B = 32'd10;
    sel = 4'b0110;
    
    #10 
    
    A = 32'd15;
    B = 32'd10;
    sel = 4'b0000;
    
    #10 
    
    A = 32'd15;
    B = 32'd10;
    sel = 4'b0001;
    
    #10 
    
    A = 32'd15;
    B = 32'd15;
    sel = 4'b0110;
    #10
    
    $finish;
    end
    
    
endmodule
