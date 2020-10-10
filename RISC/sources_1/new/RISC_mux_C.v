`timescale 1ns / 1ps

module mux_C_branch(
    input CLK,
    input reset,
    input [7:0] PC_toMuxC,
    input [1:0] BS,
    input PS,
    input Z,
    input [31:0] BrA,
    input [31:0] RAA,
    output reg [7:0] PC = 16'b0,
    output reg branch_predict
    );
    reg [1:0] sel_logic;
    initial begin
        {sel_logic,PC} <=0;
    end  
    
    always @(*)
    begin
        sel_logic <= { BS[1] , ( ( (PS^Z) | BS[1]) & BS[0] ) };
        branch_predict = ~(|sel_logic);
    end
    always @(negedge CLK or posedge reset) 
    begin
        if (reset)begin
             PC <= 0;
             sel_logic <= 0;
         end
        else begin
            case (sel_logic)
                2'd0:    PC <= PC_toMuxC;
                2'd1:    PC <= BrA[7:0];
                2'd2:    PC <= RAA[7:0];
                2'd3:    PC <= BrA[7:0];
                default: PC <= 8'bx;
            endcase
        end
    end
    
endmodule
