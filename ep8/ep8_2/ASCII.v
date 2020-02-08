module ASCII(pre, up, my_data, ascii1, ascii2, hex2, hex3);
	input pre, up;
	input [7:0]my_data, ascii1, ascii2;
	reg en=1;
	reg [7:0] ascii= 8'b00000000;
	output [6:0]hex2, hex3;
	
	my_hex h2(en, ascii[3:0], hex2);
	my_hex h3(en, ascii[7:4], hex3);
	
	always
	begin
		if(pre == 1 && my_data[7:0] != 8'hf0)
		begin
			en = 1;
			if(up == 1)
				ascii = ascii2;
			else
				ascii = ascii1;
		end
		else
		en = 0;
	end
endmodule
