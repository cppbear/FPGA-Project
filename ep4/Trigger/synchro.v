module synchro(clk, clr, in_data, out, out_n);
	input clk, clr, in_data;
	output reg out, out_n;
	
	always @(posedge clk)
		if(clr)
		begin
			out <= 0;
			out_n <= 1;
		end
		else
		begin
			out <= in_data;
			out_n <= ~in_data;
		end
endmodule
