module clock_hour(minute, set, x, hex0, hex1);
	input minute, set;
	input [5:0] x;
	reg [4:0] count = 0;
	output [6:0] hex0, hex1;
	
	reg [3:0] hex0_;
	reg [3:0] hex1_;
	
	initial hex0_ = 0;
	initial hex1_ = 0;
	
	my_hex h0(hex0_, hex0);
	my_hex h1(hex1_, hex1);
	
	always @(posedge minute or posedge set)
	begin
		hex0_ <= count % 10;
		hex1_ <= count / 10;
		if (set)
			count <= x;
		else
		begin
			if (count >= 23)
			begin
				count <= 0;
			end
			else
			begin
				count <= count + 1;
			end
		end
	end
endmodule
