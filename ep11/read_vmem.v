module read_vmem(clk, count, q);
	input clk;
	input [11:0]count;
	output [7:0]q;
	
	RAM_videomem vm(8'b0, count, clk, 12'b0, 1'b0, 1'b0, q);

endmodule
