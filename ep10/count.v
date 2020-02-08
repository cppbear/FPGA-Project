module count(mycount, hex4, hex5);
	input [7:0]mycount;
	output reg [6:0]hex4, hex5;
	
	my_hex h4(1, mycount[3:0], hex4);
	my_hex h5(1, mycount[7:4], hex5);
	
endmodule
