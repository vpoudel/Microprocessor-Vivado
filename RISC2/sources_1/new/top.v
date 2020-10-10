`timescale 1ns / 1ps

module top(
    input CLK,
    input reset
    );
    wire [7:0] PC1_pre_fetch,PC,PC_1,PC_2;
    wire [31:0] BrA,RAA,IR,A_Data,B_Data;
    wire [31:0] Bus_A,Bus_B;
    wire [1:0] BS,MD,MD_1;
    wire [4:0] DA,DA_1,AA,BA,FS,SH;
    wire PS,Z,RW,RW_1,MW,NxorV;
    wire [3:0] PSR;
    wire [31:0] F_out,data_out,Bus_D,Bus_D_prime;
    wire branch_predict,MA,MB,HA,HB;
/////////////////////////////////////////////////////////////////////////////////////////////////// 
//Pre-fetch   
RISC_Mux_C u1(
    .CLK(CLK),
    .reset(reset),
    .PC_1(PC1_pre_fetch),
    .BS(BS),
    .PS(PS),
    .Z(Z),
    .BrA(BrA),
    .RAA(RAA),
    .PC(PC),
    .branch_predict(branch_predict)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Instruction fetch
RISC_IF u2(
    .CLK(CLK),
    .reset(reset),
    .PC(PC),
    .branch_predict(branch_predict),
    .PC1_pre_fetch(PC1_pre_fetch),
    .PC_1(PC_1),
    .IR(IR)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Decode and Fetch
RISC_DOF u3(
    .CLK(CLK),
    .reset(reset),
    .PC_1(PC_1),
    .IR(IR),
    .branch_predict(branch_predict),
    .A_Data(A_Data),
    .B_Data(B_Data),
    .HA(HA),
    .HB(HB),
    .PC_2(PC_2),
    .RW_reg(RW),
    .DA_reg(DA),
    .MD_reg(MD),
    .BS_reg(BS),
    .PS_reg(PS),
    .MW_reg(MW),
    .FS_reg(FS),
    .SH_reg(SH),
    .Bus_A_reg(Bus_A),
    .Bus_B_reg(Bus_B),
    .AA(AA),
    .BA(BA),
    .MA(MA),
    .MB(MB)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Data Forwarding Module
    RISC_data_forward u4(
    .MA(MA),
    .MB(MB),
    .AA(AA),
    .BA(BA),
    .RW(RW),
    .DA(DA),
    .HA(HA),
    .HB(HB)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Execute
RISC_execute u5(
    .PC_2(PC_2),
    .CLK(CLK),
    .reset(reset),
    .A(Bus_A),
    .B(Bus_B),
    .FS(FS),
    .SH(SH),
    .MW(MW),
    .PS(PS),
    .BS(BS),
    .RW(RW),
    .DA(DA),
    .MD(MD),
    .PSR(PSR),
    .RW_1(RW_1),
    .DA_1(DA_1),
    .MD_1(MD_1),
    .BrA(BrA),
    .RAA(RAA),
    .Z(Z),
    .F_out_reg(F_out),
    .data_out_reg(data_out),
    .NxorV_reg(NxorV),
    .Bus_D_prime(Bus_D_prime)
    );   
///////////////////////////////////////////////////////////////////////////////////////////////////  
//Mux D
RISC_muxD u6(
    .MD(MD_1),
    .NxorV(NxorV),
    .F_out(F_out),
    .data_out(data_out),
    .Bus_D(Bus_D)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
//Register File
RISC_reg_file u7(
    .CLK(CLK),
    .reset(reset),
    .AA(AA),
    .BA(BA),
    .RW(RW_1),
    .DA(DA_1),
    .D_Data(Bus_D),
    .A_Data(A_Data),
    .B_Data(B_Data)
    );
///////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
