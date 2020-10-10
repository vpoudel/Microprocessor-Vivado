`timescale 1ns / 1ps

module DOF_tb();
    reg CLK,reset,branch_predict,HA,HB;
    reg [15:0] PC_1;
    reg [31:0] IR,Bus_Dprime,Bus_D;
    wire [31:0] A_Data,B_Data;
    wire [15:0] PC_2;
    wire RW_reg,PS_reg,MW_reg;
    wire [4:0] DA_reg,FS_reg,SH_reg,AA,BA;
    wire [1:0] MD_reg,BS_reg;
    wire [31:0] Bus_A_reg,Bus_B_reg;
    decoder_fetch_module RISC_DOF_module(
        .CLK(CLK),  
        .reset(reset),
        .PC_1(PC_1),    //program counter 1
        .IR(IR),    //instruction 32 bit
        .HA(HA),    //Hazard A
        .HB(HB),    //Hazard B
        .Bus_Dprime(Bus_Dprime),    //Bus D' to MuxAB
        .branch_predict(branch_predict),    //output to MuxC on top
        .A_Data(A_Data),    //input from register file
        .B_Data(B_Data),    //input from register file
        .PC_2(PC_2),    //output to Execute
        .RW_reg(RW_reg),    //output to Execute
        .DA_reg(DA_reg),    //output to Execute
        .MD_reg(MD_reg),    //output to Execute
        .BS_reg(BS_reg),    
        .PS_reg(PS_reg),
        .MW_reg(MW_reg),
        .FS_reg(FS_reg),
        .SH_reg(SH_reg),
        .MA(MA),
        .MB(MB),
        .AA(AA),    //output to reg file
        .BA(BA),    //output to reg file
        .Bus_A_reg(Bus_A_reg),
        .Bus_B_reg(Bus_B_reg)
        );
    register_file RISC_register_file(
        .CLK(CLK),
        .reset(reset),
        .RW(RW_reg),
        .DA(DA_reg),
        .AA(AA),
        .BA(BA),
        .D_Data(Bus_D),
        .A_Data(A_Data),
        .B_Data(B_Data)
        );
        
    initial begin
        {CLK,reset,PC_1,IR,Bus_Dprime,branch_predict,HA,HB,Bus_D} <=0;
        #30;
        //  32-bit ADD Instruction
        branch_predict <= 1'b1;
        IR <= 32'b0000010_00001_00010_00011_0000000000;
        PC_1 <= 15'b1;
        #20;
        // 32 bit ADI
        PC_1 <= 15'b10;
        IR <= 32'b0100010_00001_00010_000000000000001;
        #20;
        reset <= 1;
    end
    
    always #5 CLK <= ~CLK;
    
endmodule
