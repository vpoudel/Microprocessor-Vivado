`timescale 1ns / 1ps

module RISC_alu(
    input Cin,     //FS[0]
    input [3:0] S, //FS[4:1]
    input [31:0] A,
    input [31:0] B,
    output Cout,
    output V,
    output [31:0] alu_out
);
wire [4:0] op_sel;
wire [32:0] temp_out;

assign op_sel = {S,Cin};

assign {Cout,alu_out} =   (op_sel==5'b00000)?A:
                          (op_sel==5'b00001)?A+1:
                          (op_sel==5'b00010)?A+B:
                          (op_sel==5'b00011)?A+B+1:
                          (op_sel==5'b00100)?A+~B:
                          (op_sel==5'b00101)?A+~B+1:   
                          (op_sel==5'b00110)?A-1:
                          (op_sel==5'b00111)?A:
                          (op_sel==5'b01000)?A&B: //and
                          (op_sel==5'b01010)?A|B: //or
                          (op_sel==5'b01100)?A^B: //xor
                          (op_sel==5'b01110)?~A: //not
                          (op_sel==5'b10000)?B:33'bx;

assign V = (((A[31]==1 && B[31]==1) && (S[1]==0)) && (alu_out[31]==0))? 1:    //add two negatives, get a positive
           (((A[31]==0 && B[31]==0) && (S[1]==0)) && (alu_out[31]==1))? 1:    //add two positives, get a negative
           (((A[31]==0 && B[31]==0) && (S[1]==1)) && (alu_out[31]==1))? 1:    //sub two positives, get a negative
           (((A[31]==1 && B[31]==1) && (S[1]==1)) && (alu_out[31]==0))? 1:0;  //sub two negatives, get a positive
endmodule
