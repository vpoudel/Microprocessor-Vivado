`timescale 1ns / 1ps

module writeback_tb();
    //Inputs
    reg CLK,reset,NxorV,RW_1;
    reg [1:0] MD_1;
    reg [4:0] DA_1;
    reg [31:0] FUNC_OUT,DATA_OUT;
    reg [4:0] AA,BA;
    reg [31:0] D_Data;
    //Outputs
    wire [31:0] A_Data,B_Data,Bus_D;
    
    write_back_module RISC_WB(
        .MD_1(MD_1),
        .NxorV(NxorV),
        .FUNC_OUT(FUNC_OUT),
        .DATA_OUT(DATA_OUT),
        .RW_1(RW_1),
        .DA_1(DA_1),
        .Bus_D(Bus_D)
        );
        
    register_file RISC_register_file(
        .CLK(CLK),
        .reset(reset),
        .RW(RW_1),
        .AA(AA),
        .BA(BA),
        .DA(DA_1),
        .D_Data(Bus_D),
        .A_Data(A_Data),
        .B_Data(B_Data)
        );
    
    initial begin    //Initial Values
        {CLK,reset,NxorV,RW_1,MD_1,DA_1,FUNC_OUT,DATA_OUT,AA,BA,D_Data} <=0;
        #20;
        //Check MuxD out and do not write back
        FUNC_OUT <= 32'h45A0F123;
        DATA_OUT <= 32'hAA999AFE;
        NxorV   <= 1'b1;
        MD_1 <=2'd0;
        AA <= 5'h16;
        BA <= 5'h17;
        RW_1 <= 1'b0;
        DA_1 <= 5'd0;
        #20;   
        //Check data out and write back
        FUNC_OUT <= 32'h09A0FFF3;
        DATA_OUT <= 32'hFECDA097;
        NxorV   <= 1'b1;
        MD_1 <=2'd1;
        AA <= 5'h16;
        BA <= 5'h17;
        RW_1 <= 1'b1;
        DA_1 <= 5'd5;
        #20; 
        reset <=1;
    end 
 
   always #5 CLK <= ~CLK;   //CLOCK cycle
    
    
endmodule
