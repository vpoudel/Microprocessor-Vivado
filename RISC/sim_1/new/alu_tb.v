`timescale 1ns / 1ps

module alu_tb();
    reg [3:0] G_sel; 
    reg [31:0] A;
    reg [31:0] B;
    
    wire C,V,Z,N;
    wire [31:0] alu_out;
    
    alu RISC_alu(
        .G_sel(G_sel),
        .A(A),
        .B(B),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z),
        .alu_out(alu_out)
        );
        
    initial begin
        A <= 32'd5;B <= 32'd7;
        G_sel <= 4'b0000;
        #10;
        A <= 32'd25;B <= 32'd5;
        G_sel <= 4'b0011;
        #10;
        A<=32'd11;B<=32'd101;
        G_sel <= 4'b1100;
    end  
endmodule
