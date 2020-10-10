`timescale 1ns / 1ps

module RISC_IF(
    input CLK,
    input reset,
    input [7:0] PC,
    input branch_predict,
    output [7:0] PC1_pre_fetch,
    output reg [7:0] PC_1=8'b0,
    output reg [31:0] IR=32'b0
    );
    
    `include "header.vh"
    reg [31:0] Instructions [99:0];
    integer i;
    
    parameter [4:0]  R0  = 5'd0;
    parameter [4:0]  R1  = 5'd1; 
    parameter [4:0]  R2  = 5'd2; 
    parameter [4:0]  R3  = 5'd3;
    parameter [4:0]  R4  = 5'd4;
    parameter [4:0]  R5  = 5'd5;
    parameter [4:0]  R6  = 5'd6;
    parameter [4:0]  R7  = 5'd7;
    parameter [4:0]  R8  = 5'd8;
    parameter [4:0]  R9  = 5'd9;
    parameter [4:0]  R10 = 5'd10;
    parameter [4:0]  R11 = 5'd11;
    parameter [4:0]  R12 = 5'd12;
    parameter [4:0]  R13 = 5'd13;
    parameter [4:0]  R14 = 5'd14;
    parameter [4:0]  R15 = 5'd15;
    parameter [4:0]  R16 = 5'd16;
    parameter [4:0]  R17 = 5'd17;
    parameter [4:0]  R18 = 5'd18;
    parameter [4:0]  R19 = 5'd19;
    parameter [4:0]  R20 = 5'd20;
    parameter [4:0]  R21 = 5'd21;
    parameter [4:0] R22 = 5'd22;
    parameter [4:0] R23 = 5'd23;
    parameter [4:0] R24 = 5'd24;
    parameter [4:0] R25 = 5'd25;
    parameter [4:0] R26 = 5'd26;
    parameter [4:0] R27 = 5'd27;
    parameter [4:0] R28 = 5'd28;
    parameter [4:0] R29 = 5'd29;
    parameter [4:0] R30 = 5'd30;
    parameter [4:0] R31 = 5'd31;
    
    initial begin
        for (i=0; i<100; i=i+1) begin
            Instructions[i] = {NOP,5'd0,5'd0,5'd0,10'd0};
        end
      

        Instructions[5] = {LSL, R6, R1, 10'd0, 5'd31};
// A
        Instructions[6] = {AND, R7, R6, R3, 10'd0};
        Instructions[7] = {BZ, R0, R7, 15'd2}; 
        Instructions[8] = {SUB, R9, R0, R3, 10'd0}; 
        Instructions[9] = {JMP, R0, R0, 15'd1}; 
        Instructions[10] = {MOV, R9, R3, 15'd0};
// B
        Instructions[11] = {AND, R8, R6, R4, 10'd0}; 
        Instructions[12] = {BZ, R0, R8, 15'd2};
        Instructions[13] = {SUB, R10, R0, R4, 10'd0}; 
        Instructions[14] = {JMP, R10, R0, 15'd1}; 
        Instructions[15] = {MOV, R10, R4, 15'd0};
        ////// sign of RESULT
        Instructions[16] = {XOR, R11, R7, R8, 10'd0};
////////////////////////////////////////////////////////////////////////////////////////////////
// multiply preparation
        Instructions[17] = {MOV, R18, R0, 15'd0};
        Instructions[18] = {ADI, R18, R0, 15'd33};
        Instructions[19] = {MOV, R3, R1, 15'd0}; 
        Instructions[20] = {MOV, R2, R9, 15'd0};
        Instructions[21] = {MOV, R14, R10, 15'd0};
        Instructions[22] = {AIU, R16, R0, 15'd23};
// multiply
        //starts here
        Instructions[23] = {AND, R4, R9, R3, 10'd0}; 
        Instructions[24] = {BZ, R0, R4, 15'd3};
        //addition stage
        Instructions[25] = {ADD, R12, R12, R10, 10'd0};
        Instructions[26] = {ADDC, R13, R13, R19, 10'd0};
        //preparing next multiplication
	    //preparing shift
        Instructions[30] = {MOV, R17, R15, 15'd0};
		Instructions[31] = {MOV, R10, R14, 15'd0};
        Instructions[32] = {MOV, R19, R0, 15'd0};
        //left shift
        Instructions[33] = {LSL, R19, R19, 15'd1};
        Instructions[34] = {LSL, R10, R10, 15'd1};
        Instructions[35] = {ADDC, R19, R19, R0, 10'd0};
        //repeats shift
        Instructions[36] = {SUB, R17, R17, R1, 10'd0};
        Instructions[37] = {BZ, R0, R17, 15'd1};
        Instructions[38] = {JMR, R0, R18, 15'd0};

        Instructions[39] = {LSL, R3, R3, 15'd1};
        Instructions[40] = {ADI, R15, R15, 15'd1};

        //multiplier shifted to the right;
        Instructions[42] = {LSR, R2, R2, 15'd1};
        Instructions[43] = {BZ, R0, R2, 15'd1};

        Instructions[44] = {JMR, R0, R16, 15'd0};//back to the begining of multiply
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//correcting sign of result
        //test if it is signed or unsigned result
        Instructions[50] = {BZ, R0, R11, 15'd4};
        Instructions[51] = {NOT, R12, R12, 15'd0};
        Instructions[52] = {NOT, R13, R13, 15'd0};

        Instructions[53] = {ADD, R12, R12, R1, 10'd0};
        Instructions[54] = {ADDC, R13, R13, R0, 10'd0};

        Instructions[55] = {MOV, R13, R13, 15'd0};
        Instructions[56] = {MOV, R12, R12, 15'd0};
    end
    
    assign PC1_pre_fetch = PC + 8'b1;
    
    always @(negedge CLK)
    begin
        if (reset) begin
            {PC_1,IR} <= 0;
        end
        else begin
            PC_1 <= PC1_pre_fetch;
            IR   <= {{32{branch_predict}} & Instructions[PC]};
        end
    end
    
endmodule
