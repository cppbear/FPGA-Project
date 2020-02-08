module my_clock(clk, clk_1s);
	input clk;
	output reg clk_1s=1;
	reg [24:0] count=0;
	
	always @(posedge clk)
		if(count == 0)
		begin
			count <= 0;
			clk_1s <= ~clk_1s;
		end
		else
			count <= count + 1;
endmodule
