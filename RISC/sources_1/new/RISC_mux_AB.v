`timescale 1ns / 1ps

module mux_AB(
    input [14:0] IM,
    input CS,
    input [31:0] Bus_Dprime,
    input [7:0] PC_1,
    input [31:0] A_Data,
    input [31:0] B_Data,
    input MB,
    input MA,
    input HA,
    input HB,
    output reg [31:0] Bus_A,Bus_B //outputs
    );
    reg [1:0] muxA_sel,muxB_sel;
    initial begin
        {Bus_A,Bus_B,muxA_sel,muxB_sel}<=0;
    end
    always @(*) 
        begin
            muxA_sel <= {HA,MA};
            muxB_sel <= {HB,MB};  
            case(muxA_sel)
                2'b00:     Bus_A <= A_Data;
                2'b01:     Bus_A <= {24'b0,PC_1};
                2'b10:     Bus_A <= Bus_Dprime;
                default:   Bus_A <= 32'bx;
            endcase
            case(muxB_sel)
                2'b00:     Bus_B <= B_Data;
                2'b01:     Bus_B <= CS ? {{17{IM[14]}},IM} :{17'b0,IM};
                2'b10:     Bus_B <= Bus_Dprime;
                default:  Bus_B <= 32'bx;
            endcase
        end  
endmodule
