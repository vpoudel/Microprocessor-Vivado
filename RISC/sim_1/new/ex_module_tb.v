`timescale 1ns / 1ps

module ex_module_tb();
    //Inputs
    reg [15:0] PC_2;
    reg CLK,reset,MW,PS,RW;
    reg [31:0] A,B;
    reg [4:0] FS,SH,DA;
    reg [1:0] BS,MD;
    //Outputs
    wire [3:0] PSR;
    wire NxorV,RW_1,Z;
    wire [4:0] DA_1;
    wire [1:0] MD_1;
    wire [31:0] BrA,RAA,FUNC_OUT_REG,DATA_OUT_REG,BUS_Dprime;
    
    execute_module RISC_EX_module(
        .PC_2(PC_2),    //program counter
        .CLK(CLK),
        .reset(reset),
        .A(A),
        .B(B),
        .FS(FS),    //from decoder to Function
        .SH(SH),    //from IR to shifter
        .MW(MW),    //selects alu or shifter
        .PS(PS),    //not used
        .BS(BS),    //not used
        .RW(RW),    //pass in
        .DA(DA),    //pass in
        .MD(MD),    //pass in
        .PSR(PSR),  //status bits
        .NxorV(NxorV),  //xor'ed N and V
        .RW_1(RW_1),    //passed out
        .DA_1(DA_1),    //passed out
        .MD_1(MD_1),    //passed out
        .BrA(BrA),  //to MuxC
        .RAA(RAA),  //to MuxC
        .Z(Z),  //zero status bit to MuxC
        .FUNC_OUT_REG(FUNC_OUT_REG),
        .DATA_OUT_REG(DATA_OUT_REG),
        .Bus_Dprime(Bus_Dprime)
        );
        
    initial begin
        {PC_2,CLK,reset,A,B,FS,MW,PS,BS,RW,DA,MD,SH} <=0;
        #30;
        PC_2 <=1;
        //bits for adding A and B
        {RW, MD, BS, PS, MW, FS, SH, DA} <= 22'b1_00_00_0_0_00010_00000_01001;   
        A <= 32'd5;
        B <= 32'd19;
        #10;
        //bits for AND gate
        {RW, MD, BS, PS, MW, FS, SH, DA} <= 22'b1_00_00_0_0_01000_00000_01001;
        A<=32'b1001;
        B<=32'b0110;
        #10;
        //bits for shifter- logical right 4 bits
        {RW, MD, BS, PS, MW, FS, SH, DA} <= 22'b1_00_00_0_0_10010_00100_01001;
        A<=32'b1001;
        B<=32'hFFFA;
        #10;
        //bits for memory
        {RW, MD, BS, PS, MW, FS, SH, DA} <= 22'b1_00_00_0_1_00000_00000_01001;
        A<=32'b1001;
        B<=32'hFFFA;
        #10;
        
    end
    
    always #5 CLK <= ~CLK;
        
endmodule
