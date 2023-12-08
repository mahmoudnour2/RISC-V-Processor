`timescale 1ns / 1ps


module shifter(
    input   wire [31:0] a,
	input   wire [4:0]  shamt, 
	output  reg  [31:0] r,
	input   wire [3:0]  type
);
    
    always @(*) begin
        case (type) 
            4'b1000: r = a >> shamt ; // shift right logical 
            4'b1001: r =  a << shamt; // shift left logical 
            4'b1010: r = ($signed(a) >>> shamt); // shift right arith 
            default: r = a;
        endcase
    end

endmodule
