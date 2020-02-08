module MUX4_1(x,y,f);
	input [7:0] x;
	input [1:0] y;
	output reg [1:0] f;
	
	always @ (x or y)
		case (y)
			0:f=x[1:0];
			1:f=x[3:2];
			2:f=x[5:4];
			3:f=x[7:6];
		endcase
		
endmodule 