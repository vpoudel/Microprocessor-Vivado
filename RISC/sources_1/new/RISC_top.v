`timescale 1ns / 1ps

module top(
    input CLK,
    input reset
    );
    `include "header.vh"
    //Program counters
    wire [7:0] PC_toMuxC;
    wire [7:0] PC,PC_1,PC_2;
    wire [31:0] BrA,RAA,IR,D_Data,A_Data,B_Data;
    wire [31:0] Bus_Dprime,A,B,FUNC_OUT,DATA_OUT;
    wire [1:0] BS,MD,MD_1;
    wire PS,Z,branch_predict,MA,MB,HA,HB,RW,RW_1,MW;
    wire NxorV;
    wire [4:0] DA,DA_1,AA,BA,FS,SH;
    wire [3:0] PSR;
///////////////////////////////////////////////////////////////////////////////////////////////////
// Instruction Fetch Module
    instr_fetch_module RISC_IF(
        .CLK(CLK),
        .reset(reset),
        .PC(PC),
        .branch_predict(branch_predict),
        .PC_1(PC_1),
        .PC_toMuxC(PC_toMuxC),
        .IR(IR)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Data Forwarding Module
    data_forwarding RISC_data_forward(
    .MA(MA),
    .MB(MB),
    .AA(AA),
    .BA(BA),
    .RW_1(RW_1),
    .DA_1(DA_1),
    .HA(HA),
    .HB(HB)
    );
    
///////////////////////////////////////////////////////////////////////////////////////////////////
//Register File
    register_file RISC_register_file(
        .CLK(CLK),
        .reset(reset),
        .AA(AA),
        .BA(BA),
        .RW(RW_1),
        .DA(DA_1),
        .D_Data(D_Data),
        .A_Data(A_Data),
        .B_Data(B_Data)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Decode and Fetch Module
    decoder_fetch_module RISC_DOF(
        .CLK(CLK),
        .reset(reset),
        .PC_1(PC_1),
        .IR(IR),
        .HA(HA),
        .HB(HB),
        .Bus_Dprime(Bus_Dprime),
        .branch_predict(branch_predict),
        .A_Data(A_Data),
        .B_Data(B_Data),
        .PC_2(PC_2),
        .RW_reg(RW),
        .DA_reg(DA),
        .MD_reg(MD),
        .BS_reg(BS),
        .PS_reg(PS),
        .MW_reg(MW),
        .FS_reg(FS),
        .SH_reg(SH),
        .MA(MA),
        .MB(MB),
        .AA(AA),
        .BA(BA),
        .Bus_A_reg(A),
        .Bus_B_reg(B)
        );    
        
///////////////////////////////////////////////////////////////////////////////////////////////////
//wires and regs for execute module
//Execute Module
    execute_module RISC_EX(
        .PC_2(PC_2),
        .CLK(CLK),
        .reset(reset),
        .A(A),
        .B(B),
        .FS(FS),
        .SH(SH),
        .MW(MW),
        .PS(PS),
        .BS(BS),
        .RW(RW),
        .DA(DA),
        .MD(MD),
        .PSR(PSR),
        .NxorV(NxorV),
        .RW_1(RW_1),
        .DA_1(DA_1),
        .MD_1(MD_1),
        .BrA(BrA),
        .RAA(RAA),
        .Z(Z),
        .FUNC_OUT_REG(FUNC_OUT),
        .DATA_OUT_REG(DATA_OUT),
        .Bus_Dprime(Bus_Dprime)
        );   
        
///////////////////////////////////////////////////////////////////////////////////////////////////
//Write Back Module        
    write_back_module RISC_WB(
        .MD_1(MD_1),
        .NxorV(NxorV),
        .FUNC_OUT(FUNC_OUT),
        .DATA_OUT(DATA_OUT),
        .RW_1(RW_1),
        .DA_1(DA_1),
        .Bus_D(D_Data)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////
// MUX C
    mux_C_branch RISC_mux_C(
        .CLK(CLK),
        .reset(reset),
        .PC_toMuxC(PC_toMuxC),
        .BS(BS),
        .PS(PS),
        .Z(Z),
        .BrA(BrA),
        .RAA(RAA),
        .PC(PC),
        .branch_predict(branch_predict)
        );     
        
endmodule
