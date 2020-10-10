`timescale 1ns / 1ps

module mux_Dprime(
    input [1:0] MD,
    input [31:0] FUNC_OUT,
    input [31:0] DATA_OUT,
    input NxorV,
    output reg [31:0] Bus_Dprime
    );
    initial begin
        Bus_Dprime <= 0;
    end
    always @(*)
       begin
           case(MD)
               2'd0:    Bus_Dprime <= FUNC_OUT;
               2'd1:    Bus_Dprime <= DATA_OUT;
               2'd2:    Bus_Dprime <= {{31'b0},NxorV};
               default: Bus_Dprime <= 32'bx;
           endcase
       end    
endmodule
