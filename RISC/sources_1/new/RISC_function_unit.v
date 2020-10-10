`timescale 1ns / 1ps

module function_unit(
    input [31:0] A,
    input [31:0] B,
    input [4:0] FS,
    input [4:0] SH,
    output C,
    output V,
    output Z,
    output N,
    output reg [31:0] out
    );
    reg MF;
    reg [3:0] G_sel;
    wire [31:0] alu_out;
    wire [31:0] shift_out; 
    //ALU
    alu RISC_alu(
        .G_sel(G_sel),
        .A(A),
        .B(B),
        .C(C),
        .V(V),
        .Z(Z),
        .N(N),
        .alu_out(alu_out)
        );
    //Shifter
    shifter RISC_shifter(
        .shift_in(B),
        .SH(SH),
        .ftn(FS[3:1]),
        .shift_out(shift_out)
        );
    always @(*)
    begin
        MF = FS[4];
        G_sel = FS[3:0];
        case(MF)
            1'b0: out = alu_out;
            1'b1: out = shift_out;
            default:    out = 32'bx;
        endcase
    end
endmodule
