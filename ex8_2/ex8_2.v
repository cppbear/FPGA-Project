module ex8_2(clk,clrn,ps2_clk,ps2_data,a1,a2,a3,a4,a5,a6);
	input clk,clrn,ps2_clk,ps2_data;
	reg nextdata_n;
	wire [7:0] data;
	wire ready;
	wire overflow; 
	output wire [6:0]a1;
	output wire [6:0]a2;
	output wire [6:0]a3;
	output wire [6:0]a4;
	output wire [6:0]a5;
	output wire [6:0]a6;
	reg [6:0] count_clk;
	reg clk_s;
endmodule

	
