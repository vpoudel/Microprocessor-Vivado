`timescale 1ns / 1ps

module register_file(
    input CLK,
    input reset,
    input RW,
    input [4:0] AA,BA,DA,
    input [31:0] D_Data,
    output [31:0] A_Data,
    output [31:0] B_Data
    );
    
    reg [31:0] reg_file [31:0];
    
    assign A_Data = reg_file[AA];
    assign B_Data = reg_file[BA];
    integer i;
    
    initial begin
        for(i=0; i<32; i=i+1)
            reg_file[i]=i;
    end
    
    always @(posedge CLK)
        begin
            if (reset)
                for(i=0; i<32; i=i+1)
                    reg_file[i]=i;
            else if (RW) begin
                if (DA != 0) reg_file[DA] <= D_Data;
            end
        end    
endmodule
