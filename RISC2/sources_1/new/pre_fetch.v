`timescale 1ns / 1ps

module RISC_Mux_C(
    input CLK,
    input reset,
    input [7:0] PC_1,
    input [1:0] BS,
    input PS,
    input Z,
    input [31:0] BrA,
    input [31:0] RAA,
    output reg [7:0] PC=8'b0,
    output branch_predict
    );
    wire [1:0] sel_logic;
    
    assign sel_logic = { BS[1],(((PS^Z)|BS[1])&BS[0]) };
    assign branch_predict =  ~(|sel_logic);
   
    always @(negedge CLK) 
    begin
        if (reset)begin
             PC <= 0;
         end
        else begin
            case (sel_logic)
                2'd0:    PC <= PC_1;
                2'd1:    PC <= BrA[7:0];
                2'd2:    PC <= RAA[7:0];
                2'd3:    PC <= BrA[7:0];
                default: PC <= 8'b0;
            endcase
        end
    end
        
    
    
endmodule
