module code(pre, my_data, hex0, hex1);
	input pre;
	input [7:0] my_data;
	reg en;
	output reg [6:0]hex0, hex1;
	
	my_hex h0(en, my_data[3:0], hex0);
	my_hex h1(en, my_data[7:4], hex1);
	
	always
		if(pre != 1 || my_data[7:0] == 8'hf0)
			en = 0;
		else
			en = 1;

endmodule
