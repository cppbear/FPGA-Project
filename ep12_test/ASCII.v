module ASCII(pre, my_data, ascii);
	input pre, up;
	input [7:0]my_data, ascii;
	reg en=1;
	reg [7:0] ascii= 8'b00000000;
	
	
	always
	begin
		if(pre == 1 && my_data[7:0] != 8'hf0)
		begin
			ascii = ascii2;
		end
		else
		en = 0;
	end
endmodule
