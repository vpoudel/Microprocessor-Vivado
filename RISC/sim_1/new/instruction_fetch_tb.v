`timescale 1ns / 1ps

module instruction_fetch_tb();

    reg CLK,reset,branch_predict;
    reg [15:0] PC;
    wire [15:0] PC_1,PC_toMuxC,IR;

    instr_fetch_module RISC_IF_module(
        .CLK(CLK),
        .reset(reset),
        .PC(PC),
        .branch_predict(branch_predict),
        .PC_1(PC_1),
        .PC_toMuxC(PC_toMuxC),
        .IR(IR)
    );
    
    initial begin
        {PC,CLK,reset} <= 0;
        branch_predict <= 1'b1;
        #20;
        PC <= 15'd1;
        #10;
        PC <= 15'd2;
        #10;
        branch_predict <=0;
        PC <= 15'b0;
        reset <= 1'b1;
    end
    always #5 CLK <= ~CLK;
    
endmodule

