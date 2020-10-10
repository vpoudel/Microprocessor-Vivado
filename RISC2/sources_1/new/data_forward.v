`timescale 1ns / 1ps

module RISC_data_forward(
    input MA,
    input MB,
    input [4:0] AA,
    input [4:0] BA,
    input RW,
    input [4:0] DA,
    output HA,
    output HB
    );
    
    assign HA = (|DA) & (RW) & (~MA) & (AA==DA);
    assign HB = (|DA) & (RW) & (~MB) & (BA==DA);
    
endmodule


//    always @(*)
//        begin
//            if (reset)  {comp_AA,comp_BA,HA,HB}<='b0;
//            else
//            begin
//                comp_AA <= (AA==DA);
//                comp_BA <= (BA==DA);
//                HA      <= (|DA) & (RW) & (~MA) & comp_AA;
//                HB      <= (|DA) & (RW) & (~MB) & comp_BA;
//            end
//        end

