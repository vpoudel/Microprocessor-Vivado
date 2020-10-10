`timescale 1ns / 1ps

module data_forwarding(
    input reset,
    input MA,
    input MB,
    input [4:0] AA,
    input [4:0] BA,
    input RW_1,
    input [4:0] DA_1,
    output reg HA,
    output reg HB
    );
    
    reg comp_AA;
    reg comp_BA;
    initial begin
        {comp_AA,comp_BA,HA,HB}<='b0;
    end
    
    always @(*)
        begin
            if (reset)  {comp_AA,comp_BA,HA,HB}<='b0;
            else
            begin
                comp_AA <= (AA==DA_1);
                comp_BA <= (BA==DA_1);
                HA      <= (|DA_1) & (RW_1) & (~MA) & comp_AA;
                HB      <= (|DA_1) & (RW_1) & (~MB) & comp_BA;
            end
        end
endmodule
