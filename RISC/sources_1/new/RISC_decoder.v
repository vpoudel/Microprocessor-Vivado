`timescale 1ns / 1ps
module decoder(
    input [31:0] IR,
    output reg RW,
    output reg [4:0] DA,
    output reg [1:0] MD,
    output reg [1:0] BS,
    output reg PS, MW,
    output reg [4:0] FS,
    output reg MA, MB,CS,
    output reg [4:0] AA, BA
    );
    `include "header.vh"
    reg [6:0] OPCODE;
    initial begin
        {RW,DA,MD,BS,PS,MW,FS,MA,MB,CS,AA,BA}<=0;
    end
    always @(*) begin
        OPCODE <= IR[31:25];
        {DA, AA, BA} <= {IR[24:20], IR[19:15], IR[14:10]};
        case (OPCODE)
            NOP[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_0_00000_0_0_0;
            ADD[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_0_0_0;
            SUB[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_0_0_0;
            SLT[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_10_00_0_0_00101_0_0_0;
            AND[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_0_0_0;
            OR[31:25]:  {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_0_0_0;
            XOR[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_0_0_0;
            ST[31:25]:  {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_00_0_1_00000_0_0_0;
            LD[31:25]:  {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_01_00_0_0_00000_0_0_0;
            ADI[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_1;
            SBI[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_1;
            NOT[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01110_0_0_0;
            ANI[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01000_1_0_0;
            ORI[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01010_1_0_0;
            XRI[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_01100_1_0_0;
            AIU[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00010_1_0_0;
            SIU[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00101_1_0_0;
            MOV[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_00000_0_0_0;
            LSL[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10000_0_0_0;
            LSR[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10001_0_0_0;
            ASL[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10010_0_0_0;
            ASR[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10011_0_0_0;
            ROL[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10100_0_0_0;
            ROR[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_00_0_0_10101_0_0_0;
            JMR[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_10_0_0_00000_0_0_0;
            BZ[31:25]:  {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_0_0_00000_1_0_1;
            BNZ[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_01_1_0_00000_1_0_1;
            JMP[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b0_00_11_0_0_00000_1_0_1;
            JML[31:25]: {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'b1_00_11_0_0_00111_1_1_1;
            default: 
                {RW, MD, BS, PS, MW, FS, MB, MA, CS} = 15'bX_XX_XX_X_X_XXXXX_X_X_X;
        endcase
    end
    
endmodule
