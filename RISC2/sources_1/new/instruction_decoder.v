`timescale 1ns / 1ps

module RISC_decoder(
    input [31:0] IR,
    output RW,
    output [4:0] DA,
    output [1:0] MD,
    output [1:0] BS,
    output PS, MW,
    output [4:0] FS,
    output MA, MB,CS,
    output [4:0] AA, BA
    );
    `include "header.vh"
    wire [6:0] OPCODE;
    assign OPCODE = IR[31:25];
    assign {DA, AA, BA} = {IR[24:20], IR[19:15], IR[14:10]};
    
    assign {RW,MD,BS,PS,MW,FS,MB,MA,CS} = (OPCODE==NOP) ? 15'b0_00_00_0_0_00000_0_0_0: //1
                                          (OPCODE==ADD) ? 15'b1_00_00_0_0_00010_0_0_0: //2
                                         (OPCODE==ADDC) ? 15'b1_00_00_0_0_00011_0_0_0:
                                          (OPCODE==SUB) ? 15'b1_00_00_0_0_00101_0_0_0: //3
                                          (OPCODE==SLT) ? 15'b1_10_00_0_0_00101_0_0_0: //4
                                          (OPCODE==AND) ? 15'b1_00_00_0_0_01000_0_0_0: //5
                                          (OPCODE==OR)  ? 15'b1_00_00_0_0_01010_0_0_0: //6
                                          (OPCODE==XOR) ? 15'b1_00_00_0_0_01100_0_0_0: //7
                                          (OPCODE==ST)  ? 15'b0_00_00_0_1_00000_0_0_0: //8
                                          (OPCODE==LD)  ? 15'b1_01_00_0_0_00000_0_0_0: //9
                                          (OPCODE==ADI) ? 15'b1_00_00_0_0_00010_1_0_1: //10
                                          (OPCODE==SBI) ? 15'b1_00_00_0_0_00101_1_0_1: //11
                                          (OPCODE==NOT) ? 15'b1_00_00_0_0_01110_0_0_0: //12
                                          (OPCODE==ANI) ? 15'b1_00_00_0_0_01000_1_0_0: //13
                                          (OPCODE==ORI) ? 15'b1_00_00_0_0_01010_1_0_0: //14
                                          (OPCODE==XRI) ? 15'b1_00_00_0_0_01100_1_0_0: //15
                                          (OPCODE==AIU) ? 15'b1_00_00_0_0_00010_1_0_0: //16
                                          (OPCODE==SIU) ? 15'b1_00_00_0_0_00101_1_0_0: //17
                                          (OPCODE==MOV) ? 15'b1_00_00_0_0_00000_0_0_0: //18
                                          (OPCODE==LSL) ? 15'b1_00_00_0_0_10000_0_0_0: //19
                                          (OPCODE==LSR) ? 15'b1_00_00_0_0_10001_0_0_0: //20
                                          (OPCODE==ASL) ? 15'b1_00_00_0_0_10010_0_0_0: //21
                                          (OPCODE==ASR) ? 15'b1_00_00_0_0_10011_0_0_0: //22
                                          (OPCODE==ROL) ? 15'b1_00_00_0_0_10100_0_0_0: //23
                                          (OPCODE==ROR) ? 15'b1_00_00_0_0_10101_0_0_0: //24
                                          (OPCODE==JMR) ? 15'b0_00_10_0_0_00000_0_0_0: //25
                                          (OPCODE==BZ)  ? 15'b0_00_01_0_0_00000_1_0_1: //26  
                                          (OPCODE==BNZ) ? 15'b0_00_01_1_0_00000_1_0_1: //27
                                          (OPCODE==JMP) ? 15'b0_00_11_0_0_00000_1_0_1: //28
                                          (OPCODE==JML) ? 15'b1_00_11_0_0_00111_1_1_1: //29
                                          15'bx;    
endmodule
