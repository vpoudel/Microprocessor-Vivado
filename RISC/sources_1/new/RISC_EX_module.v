`timescale 1ns / 1ps

module execute_module(
    //input
    input [7:0] PC_2,
    input CLK,
    input reset,
    input [31:0] A,
    input [31:0] B,
    input [4:0] FS, //from decoder to function unit
    input [4:0] SH, //from ir ir shifter
    input MW,   //selects alu or shifter
    input PS,   //not used
    input [1:0] BS, //not used
    input RW,   //passed in 
    input [4:0] DA, //passed in
    input [1:0] MD, //passed in
    //outputs
    output reg [3:0] PSR,   //status bits
    output reg NxorV,   //xor'ed
    output reg RW_1,    //passed out
    output reg [4:0] DA_1,  //passed out
    output reg [1:0] MD_1,  //passed out
    output reg [31:0] BrA,  //to MuxC
    output reg [31:0] RAA,  //to MuxC
    output Z,   //to MuxC
    output reg [31:0] FUNC_OUT_REG,
    output reg [31:0] DATA_OUT_REG,
    output [31:0] Bus_Dprime
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
wire [31:0] FUNC_OUT;
wire C,V,N;
//Function Unit
    function_unit RISC_function_unit(
        .A(A),
        .B(B),
        .FS(FS),
        .SH(SH),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .out(FUNC_OUT)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////   
    wire [31:0] DATA_OUT;     
    //Data Memory
    data_mem RISC_data_mem(
        .CLK(CLK),
        .reset(reset),
        .addr(A[5:0]),
        .MW(MW),
        .data_in(B),
        .out(DATA_OUT)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////      
    //Mux D'
    mux_Dprime RISC_mux_Dprime(
        .MD(MD),
        .FUNC_OUT(FUNC_OUT),
        .DATA_OUT(DATA_OUT),
        .NxorV(NxorV),
        .Bus_Dprime(Bus_Dprime)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////   
    always @(*)
        begin      
            BrA = PC_2 + B;
            RAA = A;
            if (reset) begin
                {RW_1,DA_1,MD_1,PSR,FUNC_OUT_REG,DATA_OUT_REG} <= 'b0;
            end
            else if (~CLK) begin
                NxorV <= N^V;
                {RW_1,DA_1,MD_1,PSR}<={RW,DA,MD,{Z,V,N,C}};
                {FUNC_OUT_REG,DATA_OUT_REG}<= {FUNC_OUT,DATA_OUT};
            end
        end
    
endmodule
