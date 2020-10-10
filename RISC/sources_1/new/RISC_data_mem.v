`timescale 1ns / 1ps

module data_mem(
    input CLK,
    input reset,
    input [5:0] addr,
    input MW,
    input [31:0] data_in,
    output [31:0] out
    );
    reg [31:0] memory [63:0];
    integer i;
    
    initial 
        begin
            for (i=0; i<64;i=i+1)
                memory[i]=i;
        end
        
    always @ (posedge CLK)
        begin
            if (MW)
                memory[addr] <=data_in;
            else if (reset)
                for (i=0; i<64;i=i+1)
                    memory[i]=i;
        end   
    assign out = memory[addr];
endmodule
