`timescale 1ns / 1ps

module RISC_muxD(
    input [1:0] MD,
    input NxorV,
    input [31:0] F_out,
    input [31:0] data_out,
    output [31:0] Bus_D
    );

    assign Bus_D = (MD==2'd0) ? F_out:
                   (MD==2'd1) ? data_out:
                   (MD==2'd2) ? {{31'b0},NxorV} : 32'bx;
endmodule
