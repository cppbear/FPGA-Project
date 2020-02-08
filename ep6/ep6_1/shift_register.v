module shift_register(clk, control, x, y, out);
	input clk, y;
	input [7:0] x;
	input [2:0] control;
	output reg [7:0] out;
	
	always @(posedge clk)
		case(control)
			0: out <= 0;
			1: out <= x;
			2: out <= {1'b0, out[7:1]};
			3: out <= {out[6:0], 1'b0};
			4: out <= {out[7], out[7:1]};
			5: out <= {y, out[7:1]};
			6: out <= {out[0], out[7:1]};
			7: out <= {out[6:0], out[7]};
		endcase
endmodule
