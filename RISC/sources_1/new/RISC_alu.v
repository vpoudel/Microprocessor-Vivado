`timescale 1ns / 1ps

module alu(
    input [3:0] G_sel, //FS[3:0]
    input [31:0] A,
    input [31:0] B,
    output reg C,
    output reg V,
    output reg Z,
    output reg N,
    output reg [31:0] alu_out
);


initial begin
    {C,V,Z,N,alu_out} <=0;
end
always @(*) begin
    case (G_sel)
        4'b0000:{C,alu_out}= A;
        4'b0001:{C,alu_out}= A+1;
        4'b0010:{C,alu_out}= A+B;
        4'b0011:{C,alu_out}= A+B+1;
        4'b0100:{C,alu_out}= A+~B;
        4'b0101:{C,alu_out}= A+~B+1;
        4'b0110:{C,alu_out}= A-~1;
        4'b0111:{C,alu_out}= A;
        4'b1000:{C,alu_out}= A&B;
        4'b1010:{C,alu_out}= A|B;
        4'b1100:{C,alu_out}= A^B;
        4'b1110:{C,alu_out}= ~A;
        default:{C,alu_out}= 33'bx;
    endcase
    Z = ~(|alu_out);
    N = alu_out[31];
    V = (A[31]==B[31]) ?  1'b0 : ((~(A[31]^B[31]))^(alu_out[31])) ?  1'b1 : 1'bx;
end

endmodule
