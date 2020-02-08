module unlock(clk, in_en, in_data, out_unlock1, out_unlock2);
	input clk, in_en, in_data;
	output reg out_unlock1, out_unlock2;
	
	always @(posedge clk)
		if(in_en)
		begin
			out_unlock1 <= in_data;
			out_unlock2 <=out_unlock1;
		end
		else
		begin
			out_unlock1 <= out_unlock1;
			out_unlock2 <= out_unlock2;
		end
endmodule
