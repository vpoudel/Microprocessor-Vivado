`timescale 1ns / 1ps

module decoder_fetch_module(
    input CLK,
    input reset,
    input [7:0] PC_1,
    input [31:0] IR,
    input HA,
    input HB,
    input [31:0] Bus_Dprime,
    input branch_predict,
    input[31:0] A_Data,B_Data,
    output reg [7:0] PC_2,
    output reg RW_reg,
    output reg [4:0] DA_reg,
    output reg [1:0] MD_reg,
    output reg [1:0] BS_reg,
    output reg PS_reg, MW_reg,
    output reg [4:0] FS_reg,
    output reg [4:0] SH_reg,
    output MA,MB,
    output [4:0] AA,BA,
    output reg [31:0] Bus_A_reg,
    output reg [31:0] Bus_B_reg
    );
    
    wire [4:0] DA,FS;
    wire [1:0] MD,BS;
    wire [31:0] Bus_A,Bus_B;
    wire CS,PS,MW;
    wire RW;
    reg [14:0] IM;
    initial begin
        {PC_2,RW_reg,DA_reg,MD_reg,BS_reg,PS_reg,
        MW_reg,FS_reg,SH_reg,Bus_A_reg,Bus_B_reg} <=0;
    end
    //Instruction Decoder
    decoder RISC_decoder(
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
        
    //MUX A and MUX B
    mux_AB RISC_mux_AB(
        .IM(IM),
        .CS(CS),
        .Bus_Dprime(Bus_Dprime),
        .PC_1(PC_1),
        .A_Data(A_Data),
        .B_Data(B_Data),
        .MA(MA),
        .MB(MB),
        .HA(HA),
        .HB(HB),
        .Bus_A(Bus_A),
        .Bus_B(Bus_B)
        );  
        

    
    always @(*)
        begin
            IM <= IR[14:0];
            if (reset) begin
                {PC_2,SH_reg,RW_reg,DA_reg,MD_reg,BS_reg,PS_reg,MW_reg,FS_reg,Bus_A_reg,Bus_B_reg} <= 0;
            end
            else if (~CLK) begin
                PC_2   <=  PC_1;
                SH_reg <=  IR[4:0];
                RW_reg <= RW & branch_predict;
                BS_reg <= (BS & {2{branch_predict}});
                MW_reg <= (MW & (branch_predict));
                {DA_reg,MD_reg,PS_reg,FS_reg} <= {DA,MD,PS,FS};
                {Bus_A_reg,Bus_B_reg} <= {Bus_A,Bus_B};
            end
        end
    
endmodule
