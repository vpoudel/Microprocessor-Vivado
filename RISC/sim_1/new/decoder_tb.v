`timescale 1ns / 1ps

module decoder_tb();
    reg [31:0] IR;
    wire [4:0] DA,FS,AA,BA;
    wire [1:0] MD,BS;
    wire RW,PS,MW,MA,MB,CS;
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
        
    initial begin
        IR <= 32'b0000000_00000_00000_00000_0000000000;
        #20;
        IR <= 32'b0000010_00001_00010_00011_0000000000;
        #20;
        IR <= 32'b0000101_00100_00001_00011_0000000000;
        #20;
        IR <= 32'b0000111_00001_00000_000000000000000;
        #20;
        
    end 
endmodule
