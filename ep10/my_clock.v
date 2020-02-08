module my_clock(clk, clk_1s);
	input clk;
	output reg clk_1s;
	reg [6:0] count;
	
	always @(posedge clk)
		if(count == 100)
		begin
			count <= 0;
			clk_1s <= ~clk_1s;
		end
		else
			count <= count + 1;
endmodule
