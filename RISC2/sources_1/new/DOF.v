`timescale 1ns / 1ps

module RISC_DOF(
    input CLK,
    input reset,
    input [7:0] PC_1,
    input [31:0] IR,
    input branch_predict,
    input[31:0] A_Data,B_Data,
    input HA,HB,
    input [31:0] Bus_D_prime,
    output reg [7:0] PC_2=8'b0,
    output reg RW_reg=1'b0,
    output reg [4:0] DA_reg=5'b0,
    output reg [1:0] MD_reg=2'b0,
    output reg [1:0] BS_reg=2'b0,
    output reg PS_reg=1'b0, MW_reg=1'b0,
    output reg [4:0] FS_reg=5'b0,
    output reg [4:0] SH_reg=5'b0,
    output reg [31:0] Bus_A_reg=32'b0,
    output reg [31:0] Bus_B_reg=32'b0,
    output [4:0] AA,
    output [4:0] BA,
    output MA,MB
    );
    wire [14:0] IM;
    wire [31:0] Bus_A,Bus_B;
    wire [4:0] DA,FS,SH;
    wire [1:0] MD,BS;
    wire CS,PS,MW,RW;
///////////////////////////////////////////////////////////////////////////////////////////////////
    //Instruction Decoder
    RISC_decoder instruction_decoder(
        .IR(IR),
        .RW(RW),
        .DA(DA),
        .MD(MD), 
        .BS(BS),
        .PS(PS),
        .MW(MW),
        .FS(FS),
        .MA(MA),
        .MB(MB),
        .CS(CS),
        .AA(AA),
        .BA(BA)
        );
///////////////////////////////////////////////////////////////////////////////////////////////////
    assign SH = IR[4:0];
    assign IM = IR[14:0];
    assign Const_Unit = (CS == 1) ? {{17{IM[14]}},IM}:
                        (CS == 0) ? {17'b0,IM}: 32'bx;
                        
    assign Bus_A = (HA==1'b1) ? Bus_D_prime:
                   (MA==1'b0) ? (A_Data):
                   (MA==1'b1) ? ({24'b0,PC_1}): 32'bx;
                   
    assign Bus_B = (HB==1'b1) ? Bus_D_prime:
                   (MB==1'b0) ? (B_Data):
                   (MB==1'b1) ? Const_Unit: 32'bx;
///////////////////////////////////////////////////////////////////////////////////////////////////
    always @(negedge CLK)
    begin
        if (reset) begin
            {PC_2,RW_reg,DA_reg,MD_reg,BS_reg,PS_reg,MW_reg,
            FS_reg,SH_reg,Bus_A_reg,Bus_B_reg} <= 0;
        end
        else begin
            PC_2   <=  PC_1;
            {RW_reg,DA_reg,MD_reg} <= {RW & branch_predict,DA,MD};
            {BS_reg,PS_reg,MW_reg} <= {(BS & {2{branch_predict}}),PS,(MW & (branch_predict))};
            FS_reg <= FS;
            SH_reg <=  IR[4:0];
            {Bus_A_reg,Bus_B_reg} <= {Bus_A,Bus_B};
        end
    end
endmodule