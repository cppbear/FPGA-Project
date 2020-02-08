module my_clock(clk, clk_1s);
	input clk;
	output reg clk_1s=0;
	reg [24:0] count=0;
	
	always @(posedge clk)
		if(count == 25000000)
		begin
			count <= 0;
			clk_1s <= ~clk_1s;
		end
		else
			count <= count + 1;
endmodule
