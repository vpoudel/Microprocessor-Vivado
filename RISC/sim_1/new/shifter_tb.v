`timescale 1ns / 1ps

module shifter_tb();
//Inputs
reg [31:0] shift_in;
reg [4:0] SH;
reg [2:0] ftn;
//Output
wire [31:0] shift_out;

 shifter RISC_shifter(
    .shift_in(shift_in),
    .SH(SH),
    .ftn(ftn),
    .shift_out(shift_out)
    );

initial begin
    shift_in <= 32'b0;
    SH <= 5'b0;
    ftn <= 3'b0;
    #100; 
    
    shift_in <= 32'h35FFFF15;
    SH <= 8;
    #10 ftn <= 0;
    #10 ftn <= 1;
    #10 ftn <= 2;
    #10 ftn <= 3;
    #10 ftn <= 4;
    #10 ftn <= 5;
    #10 ftn <= 6;
end

endmodule
