`timescale 1ns / 1ps

module instr_fetch_module(
    input CLK,
    input reset,
    input [7:0] PC,
    input branch_predict,
    output reg [7:0] PC_1=8'b0,
    output [7:0] PC_toMuxC,
    output reg [31:0] IR=32'b0
    );
    
    `include "header.vh"
    reg [31:0] INST_FORMAT [35:0];
    integer i;
    wire [31:0] instruction;

    initial begin
        INST_FORMAT[0] = NOP;
        INST_FORMAT[1] = ADD;
        INST_FORMAT[2] = SUB;
        INST_FORMAT[3] = SLT;
        INST_FORMAT[4] = AND;
        INST_FORMAT[5] = OR;
        INST_FORMAT[6] = XOR;
        INST_FORMAT[7] = ST;
        INST_FORMAT[8] = LD;
        INST_FORMAT[9] = ADI;
        INST_FORMAT[10] = SBI;
        INST_FORMAT[11] = NOT;
        INST_FORMAT[12] = ANI;
        INST_FORMAT[13] = ORI;
        INST_FORMAT[14] = XRI;
        INST_FORMAT[15] = AIU;
        INST_FORMAT[16] = SIU;
        INST_FORMAT[17] = MOV;
        INST_FORMAT[18] = LSL;
        INST_FORMAT[19] = LSR;
        INST_FORMAT[20] = ASL;
        INST_FORMAT[21] = ASR;
        INST_FORMAT[22] = ROL;
        INST_FORMAT[23] = NOP;
        INST_FORMAT[24] = ROR;
        INST_FORMAT[25] = NOP;
        INST_FORMAT[26] = JMR;
        INST_FORMAT[27] = BZ;
        INST_FORMAT[28] = BNZ;
        INST_FORMAT[29] = JMP;
        INST_FORMAT[30] = JML;
        for (i = 31; i<=35; i = i + 1) INST_FORMAT[i] = 32'b0;        
    end
    assign PC_toMuxC = PC + 8'b1;
    assign instruction = {{32{branch_predict}} & INST_FORMAT[PC]};
    
    always @(negedge CLK or posedge reset)
    begin
        if (reset)
            {IR,PC_1} <= 0;
        else
            IR <= instruction;
            PC_1 <= PC_toMuxC;
    end
endmodule