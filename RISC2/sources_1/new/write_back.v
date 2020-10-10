`timescale 1ns / 1ps

module RISC_write_back(
    input [1:0] MD_1,
    input NxorV,
    input [31:0] FUNC_OUT,
    input [31:0] DATA_OUT,
    input RW_1,
    input [4:0] DA_1,
    output reg [31:0] Bus_D
    );
    
    initial begin
        Bus_D <=0;
    end
    
    always @(*)
        begin
            case(MD_1)
                2'd0:    Bus_D <= FUNC_OUT;
                2'd1:    Bus_D <= DATA_OUT;
                2'd2:    Bus_D <= {{31'b0},NxorV};
                default: Bus_D <= 32'bx;
            endcase
        end
        
endmodule
