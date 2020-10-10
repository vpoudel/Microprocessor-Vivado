`timescale 1ns / 1ps

module mux_AB_tb();
    reg [14:0] IM;
    reg [31:0] Bus_Dprime,A_Data,B_Data;
    reg CS,MA,HA,MB,HB;
    reg [15:0] PC_1;
    wire [31:0] Bus_A,Bus_B;
    mux_AB RISC_mux_AB(
        .IM(IM),
        .CS(CS),
        .Bus_Dprime(Bus_Dprime),
        .PC_1(PC_1),
        .A_Data(A_Data),
        .MA(MA),
        .HA(HA),
        .B_Data(B_Data),
        .MB(MB),
        .HB(HB),
        .Bus_A(Bus_A),
        .Bus_B(Bus_B)
        );
    initial begin
        {IM,Bus_Dprime,A_Data,B_Data,
        CS,MA,HA,MB,HB,PC_1} <= 0;
        #30;
        IM <= 15'd15;
        A_Data <= 32'd32;
        B_Data <= 32'd33;
        PC_1 <= 16'd5;
        Bus_Dprime <= 32'd34;
        {HA,MA,HB,MB} <= 4'b0_0_0_0;    //run 1st cases
        #10;
        {HA,MA,HB,MB} <= 4'b0_1_0_1;    //run 2nd cases
        #10;
        {HA,MA,HB,MB} <= 4'b1_0_1_0;    //run 3rd cases
        #10;
        {HA,MA,HB,MB} <= 4'b1_1_1_1;    //run default case
        #10; 
    end
endmodule
