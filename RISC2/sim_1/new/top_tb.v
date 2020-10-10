`timescale 1ns / 1ps

module top_tb();
    reg CLK,reset;
    
    top RISC_top(
        .CLK(CLK),
        .reset(reset)
        );
    
    initial begin
        CLK   <= 0;
        reset <= 0;
        #50 reset <=1;
        #30 reset <=0;
    end    
    
    always #5 CLK <= ~CLK;
    


endmodule
