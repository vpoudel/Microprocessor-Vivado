`timescale 1ns / 1ps

module shifter(
    input [31:0] shift_in,
    input [4:0] SH,
    input [2:0] ftn,
    output reg [31:0]  shift_out
    );
    
    wire [63:0] rot;
    wire [63:0] logical;
    wire [63:0] arith;
    initial begin
        shift_out <= 0;
    end
    assign rot = {shift_in,shift_in};
    assign logical={32'b0,shift_in};
    assign arith={{32{shift_in[31]}},shift_in};
    
    always @(*)
    begin
        case (ftn)
            3'b000: 	shift_out =    logical << SH;
			3'b001: 	shift_out =    logical >> SH;
			3'b010: 	shift_out =      arith << SH;
			3'b011: 	shift_out =      arith >> SH;
			3'b100:     shift_out =        rot >> (32-SH);
			3'b101: 	shift_out =        rot >> SH;
			default: 	shift_out =    shift_in;
		endcase
    end
endmodule
