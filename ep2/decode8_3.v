module decode8_3(x,en,y,stat,hex);
	input [7:0] x;
	input en;
	output reg [2:0] y;
	output reg stat;
	output reg [6:0] hex;
	integer i;
	always @(x or en) begin
		if (en) begin
			y=0;
			for (i=0;i<=7;i=i+1)
				if(x[i]==1) y=i;
			
			if (y|x[0]==1) begin
				stat=1;
				case (y)
					3'b000: hex=7'b1000000;
					3'b001: hex=7'b1111001;
					3'b010: hex=7'b0100100;
					3'b011: hex=7'b0110000;
					3'b100: hex=7'b0011001;
					3'b101: hex=7'b0010010;
					3'b110: hex=7'b0000010;
					3'b111: hex=7'b1111000;
				endcase
			end
			else begin
				stat=0;
				hex=7'b1111111;
			end
		end
		
		else begin
			y=0;
			stat=0;
			hex=7'b1111111;
		end
	end
endmodule
