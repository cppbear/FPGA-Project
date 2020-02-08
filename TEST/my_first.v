module my_first(
	input A,
	input B,
	output F
	);
	assign F = ~A&B | A&~B;
endmodule 