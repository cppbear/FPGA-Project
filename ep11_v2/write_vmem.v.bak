module write_vmem(clk, up, count, data);
	input clk, up;
	input [11:0] count;
	input [7:0] data;
	wire [7:0] ascii_low, ascii_cap;
	wire [7:0] dummy;
	reg [7:0] my_data;
	//integer i, j;
	
	ROM_low low(data, clk, ascii_low);
	ROM_cap cap(data, clk, ascii_cap);
	RAM_videomem vm(my_data, 12'b0, 1'b0, count, clk, 1'b1, dummy);
	
	always @(posedge clk)
	begin
		if (up)
			my_data = ascii_cap;
		else
			my_data = ascii_low;
		/*
		if (clear)							逐行前移
		begin
			for (i = 0; i < 69; i = i + 1)
				
		end
		*/
	end
endmodule
