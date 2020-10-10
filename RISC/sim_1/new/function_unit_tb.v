`timescale 1ns / 1ps

module function_unit_tb();
    //Inputs
    reg [31:0] A, B;
    reg [4:0] FS, SH;
    //Outputs
    wire C,V,N,Z;
    wire [31:0] out;
    function_unit RISC_function_unit(
        .A(A),
        .B(B),
        .FS(FS),
        .SH(SH),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .out(out)
        );
    initial begin
        A <= 32'b0;
        B <= 32'b0;
        FS <= 5'b0;
        SH <= 5'b0;
        #20;
        //test alu F = A+B+1
        A <= 32'h00000A85;
        B <= 32'h00009492;
        FS <= 5'b00011;
        #10;
        //test shifter F= sr B
        B <= 32'h94925643;
        SH <= 5'd4;
        FS <= 5'b10100;
    end
    
endmodule
