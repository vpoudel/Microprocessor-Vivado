`timescale 1ns / 1ps

module mux_C_tb();
    reg CLK,reset,PS,Z;
    reg [15:0] PC_toMuxC;
    reg [1:0] BS;
    reg [31:0] BrA,RAA;
    wire [15:0] PC;
    wire branch_predict;
    
    mux_C_branch RISC_muxC(
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
    
    initial begin
        {CLK,reset,PS,Z,PC_toMuxC,BS,BrA,RAA} <=0;
        #20;
        //for PC_toMuxC test
        PC_toMuxC <= 16'b1; 
        BrA <= 32'b0;
        RAA <= 32'b0;
            {BS,PS,Z} <= 4'b00_0_0;
        #10 {BS,PS,Z} <= 4'b00_0_1;
        #10 {BS,PS,Z} <= 4'b00_1_0;
        #10 {BS,PS,Z} <= 4'b00_1_1;
        #10 {BS,PS,Z} <= 4'b01_0_0;
        #10 {BS,PS,Z} <= 4'b01_1_1;
        #20;
        // For RAA test
        PC_toMuxC <= 16'b0;
        BrA <= 32'b0;
        RAA <= 32'b1;
            {BS,PS,Z} <= 4'b10_0_0;
        #10 {BS,PS,Z} <= 4'b10_0_1;
        #10 {BS,PS,Z} <= 4'b10_1_0;
        #10 {BS,PS,Z} <= 4'b10_1_1;
        #20;
        //for BrA test
        PC_toMuxC <= 16'b0;
        BrA <= 32'b1;
        RAA <= 32'b0;
            {BS,PS,Z} <= 4'b01_0_1;
        #10 {BS,PS,Z} <= 4'b01_1_0;
        #10 {BS,PS,Z} <= 4'b11_0_0;
        #10 {BS,PS,Z} <= 4'b11_0_1;
        #10 {BS,PS,Z} <= 4'b11_1_0;
        #10 {BS,PS,Z} <= 4'b11_1_1;
        #20;
        reset <= 1;
        
    
    end
    
    always #5 CLK <= ~CLK;
    
endmodule
