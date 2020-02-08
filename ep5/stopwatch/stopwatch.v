module stopwatch(clk, pause, clr, over, hex1, hex2);
	input clk, pause, clr;
	reg clk_1s;
	reg [3:0] out_1 = 0, out_2 = 0;
	output reg over;
	output reg [6:0] hex1, hex2;
	reg [24:0] count_clk = 0;
	
	initial over = 0;
	initial clk_1s = 1;
	initial hex1 = 7'b1111111;
	initial hex2 = 7'b1111111;
	
	always @(posedge clk)
		if(count_clk==25000000)
		begin
			count_clk <=0;
			clk_1s <= ~clk_1s;
		end
		else
			count_clk <= count_clk+1;
	
	always @(posedge clk_1s or posedge clr or posedge pause)
		if (clr)
		begin
			out_1 <= 0;
			out_2 <= 0;
		end
		else if (pause)
		begin
			out_1 <= out_1;
			out_2 <= out_2;
		end
		else
		begin
			if (out_1 == 9 && out_2 == 9)
			begin
				out_1 <= 0;
				out_2 <= 0;
				over <= 1;
			end
			else if (out_2 == 9)
			begin
				out_1 <= out_1 + 1;
				out_2 <= 0;
				over <= 0;
			end
			else
			begin
				out_2 <= out_2 + 1;
				over <= 0;
			end
		end
		
	always @(posedge clk_1s)
		case(out_1)
			0: hex1 <= 7'b1000000;
			1: hex1 <= 7'b1111001;
			2: hex1 <= 7'b0100100;
			3: hex1 <= 7'b0110000;
			4: hex1 <= 7'b0011001;
			5: hex1 <= 7'b0010010;
			6: hex1 <= 7'b0000010;
			7: hex1 <= 7'b1111000;
			8: hex1 <= 7'b0000000;
			9: hex1 <= 7'b0010000;
		endcase
	
	always @(posedge clk_1s)
		case(out_2)
			0: hex2 <= 7'b1000000;
			1: hex2 <= 7'b1111001;
			2: hex2 <= 7'b0100100;
			3: hex2 <= 7'b0110000;
			4: hex2 <= 7'b0011001;
			5: hex2 <= 7'b0010010;
			6: hex2 <= 7'b0000010;
			7: hex2 <= 7'b1111000;
			8: hex2 <= 7'b0000000;
			9: hex2 <= 7'b0010000;
		endcase
endmodule
