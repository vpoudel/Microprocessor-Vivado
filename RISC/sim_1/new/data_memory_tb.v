`timescale 1ns / 1ps

module data_memory_tb();
    //Inputs
    reg CLK, reset, MW;
    reg [5:0] addr;
    reg [31:0] data_in;
    //Output
    wire [31:0] out;
    data_mem RISC_data_mem(
        .CLK(CLK),
        .reset(reset),
        .addr(addr),
        .MW(MW),
        .data_in(data_in),
        .out(out)
        );
    initial begin
        {CLK,reset,MW,addr,data_in}<=0;
        #30;
        MW <=1'b1; 
        addr <= 6'd1; 
        data_in <= 32'h56; 
        #10;
        addr <= 6'd2;
        data_in <= 32'h25; 
        #10;
        MW <=1'b0;
        addr <= 6'd3;
        data_in <= 32'h99; 
        #10;
        reset<=1;
    end
    
    always #5 CLK <= ~CLK;
endmodule
