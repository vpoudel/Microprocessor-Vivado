`timescale 1ns / 1ps

module RISC_execute(
    input [7:0] PC_2,   //PC2 to EX module
    input CLK,
    input reset,
    input [31:0] A,    //A value
    input [31:0] B,    //B value
    input [4:0] FS, //from decoder to function unit
    input [4:0] SH, //from ir ir shifter
    input MW,   //selects alu or shifter
    input PS,   //not used
    input [1:0] BS, //not used
    input RW,   //passed in and out
    input [4:0] DA, //passed in and out
    input [1:0] MD, //passed in and out
    output [3:0] PSR,   //status bits
    output reg RW_1=1'b0,    //passed in and out
    output reg [4:0] DA_1=5'b0,  //passed in and out
    output reg [1:0] MD_1=2'b0,  //passed in and out
    output [31:0] BrA,  //to MuxC
    output [31:0] RAA,  //to MuxC
    output Z,   //to MuxC
    output reg [31:0] F_out_reg=32'b0,    //function out
    output reg [31:0] data_out_reg=32'b0, //data mem out
    output reg NxorV_reg=1'b0,   //xor'ed
    output [31:0] Bus_D_prime
    );
    wire C,V,N;
    wire [31:0] F_out,data_out;
    wire NxorV;
///////////////////////////////////////////////////////////////////////////////////////////////////
    assign BrA = PC_2 + B;
    assign RAA = A;
    assign PSR = {V,C,N,Z};
    assign NxorV = N^V;
///////////////////////////////////////////////////////////////////////////////////////////////////
    //Function Unit
    RISC_function_unit function_unit(
        .A(A),
        .B(B),
        .FS(FS),
        .SH(SH),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .F_out(F_out)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////   
    //Data Memory
    RISC_data_memory data_memory(
        .CLK(CLK),
        .reset(reset),
        .addr(A[5:0]),
        .MW(MW),
        .data_in(B),
        .data_out(data_out)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////   
    //Mux D Prime
    RISC_muxD mux_D(
        .MD(MD),
        .NxorV(NxorV),
        .F_out(F_out),
        .data_out(data_out),
        .Bus_D(Bus_D_prime)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////       
always @(negedge CLK)
    begin
        if (reset) begin
            {RW_1,DA_1,MD_1} <= 0;
            {F_out_reg,data_out_reg,NxorV_reg} <= 0;
        end
        else begin
            {RW_1,DA_1,MD_1} <= {RW,DA,MD};
            {F_out_reg,data_out_reg,NxorV_reg} <= {F_out,data_out,NxorV};
        end
    end
endmodule
