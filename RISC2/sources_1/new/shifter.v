`timescale 1ns / 1ps

module RISC_shifter(
    input [31:0] shift_in,
    input [4:0] SH,
    input [3:0] S,
    output [31:0]  shift_out
    );
    
    wire [63:0] rot;
    wire [63:0] logical;
    wire [63:0] arith;
    
    assign rot = {shift_in,shift_in};
    assign logical={32'b0,shift_in};
    assign arith={{32{shift_in[31]}},shift_in};
    
    assign shift_out = (S==4'b1001) ? logical << SH:
                       (S==4'b1010) ? logical << SH:
                       (S==4'b1011) ? logical << SH:
                       (S==4'b1100) ? logical << SH:
                       (S==4'b1101) ? logical << SH:
                       (S==4'b1110) ? logical << SH:
                       (S==4'b1111) ? shift_in: 32'bx;
endmodule
