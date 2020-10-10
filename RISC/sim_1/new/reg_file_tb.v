`timescale 1ns / 1ps

module reg_file_tb();
    reg CLK;
    reg reset;
    reg RW;
    reg [4:0] AA,BA,DA; 
    reg [31:0] D_Data;
    wire [31:0] A_Data, B_Data;
    register_file RISC_reg_file(
        .CLK(CLK),
        .reset(reset),
        .RW(RW),
        .AA(AA),
        .BA(BA),
        .DA(DA),
        .D_Data(D_Data),
        .A_Data(A_Data),
        .B_Data(B_Data)
        );
    initial begin
        {CLK,reset,RW,AA,BA,DA,D_Data}<=0;
        #30;
        AA <= 5'd4; //probably nothing or 4
        DA <= 5'd31;
        BA <= 5'd5; //probably nothing or 4
        D_Data <= 32'd100; 
        #20 RW <= 1'b1; 
        D_Data <= 32'd111;  //give value for regfile[4]
        DA <= 5'd30;
        #10; D_Data <= 32'd123;  //give value for regfile[5]
        DA <= 5'd31;
        #10 RW <= 1'b0; 
        AA <= 5'd30;
        BA <= 5'd31;
        D_Data <= 32'd0;
        #10;
        reset <= 1;   
    end
    always #5 CLK <= ~CLK;
endmodule
