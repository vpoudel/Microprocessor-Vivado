`timescale 1ns / 1ps

module RISC_function_unit(
    input [31:0] A,
    input [31:0] B,
    input [4:0] FS,
    input [4:0] SH,
    output C,
    output V,
    output Z,
    output N,
    output [31:0] F_out
    );
    
    wire [31:0] alu_out,shift_out;
    //ALU
    RISC_alu alu(
        .Cin(FS[0]),
        .S(FS[4:1]),
        .A(A),
        .B(B),
        .Cout(C),
        .V(V),
        .alu_out(alu_out)
        );

    //Shifter
    RISC_shifter shifter(
        .shift_in(B),
        .SH(SH),
        .S(FS[4:1]),
        .shift_out(shift_out)
        );
        
    assign F_out = (FS[4]==1'b0)?(alu_out):
               (FS[4]==1'b1)?(shift_out):32'bx;
    assign Z = ~(|F_out);
    assign N = (F_out[31]==1)?1:0;
    
endmodule
