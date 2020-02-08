module clock_second(clk, set, x, hex0, hex1, carry);
	input clk, set;
	input [5:0] x;
	wire clk_1s;
	reg [5:0] count = 0;
	output [6:0] hex0, hex1;
	output reg carry = 0;
	
	reg [3:0] hex0_;
	reg [3:0] hex1_;
	
	initial hex0_ = 0;
	initial hex1_ = 0;
	
	my_clock mclk(clk, clk_1s);
	
	my_hex h0(hex0_, hex0);
	my_hex h1(hex1_, hex1);
	
	always @(posedge clk_1s or posedge set)
	begin
		hex0_ <= count % 10;
		hex1_ <= count / 10;
		if (set)
			count <= x;
		else
		begin
			if (count >= 59)
			begin
				carry <= 1;
				count <= 0;
			end
			else
			begin
				carry <= 0;
				count <= count + 1;
			end
		end
	end
endmodule