module show_ascii(pre,up,my_data,ascii1,ascii2,seg3,seg4,preflag);
	input pre;
	input preflag;
	input up;
	input [7:0]my_data;
	input [7:0]ascii1;
	input [7:0]ascii2;
	reg [7:0] ascii;
	output reg [6:0]seg3;
	output reg [6:0]seg4;
	
	always
	begin
		if(((pre == 1) && (my_data[7:0] != 8'hf0))) //&& (preflag == 1))	
		begin	
			
			if(up == 1)
			begin
				ascii = ascii2;
			end
			else
			begin
				ascii = ascii1;
			end	
			
			case(ascii[3:0])
			0: seg3[6:0] = 7'b1000000;
			1: seg3[6:0] = 7'b1111001;
			2: seg3[6:0] = 7'b0100100;
			3: seg3[6:0] = 7'b0110000;
			4: seg3[6:0] = 7'b0011001;
			5: seg3[6:0] = 7'b0010010;
			6: seg3[6:0] = 7'b0000010;
			7: seg3[6:0] = 7'b1111000;
			8: seg3[6:0] = 7'b0000000;
			9: seg3[6:0] = 7'b0010000;
			10:seg3[6:0] = 7'b0001000;
			11:seg3[6:0] = 7'b0000011;
			12:seg3[6:0] = 7'b1000110;
			13:seg3[6:0] = 7'b0100001;
			14:seg3[6:0] = 7'b0000110;
			15:seg3[6:0] = 7'b0001110;
			endcase
		
			case(ascii[7:4])
			0: seg4[6:0] = 7'b1000000;
			1: seg4[6:0] = 7'b1111001;
			2: seg4[6:0] = 7'b0100100;
			3: seg4[6:0] = 7'b0110000;
			4: seg4[6:0] = 7'b0011001;
			5: seg4[6:0] = 7'b0010010;
			6: seg4[6:0] = 7'b0000010;
			7: seg4[6:0] = 7'b1111000;
			8: seg4[6:0] = 7'b0000000;
			9: seg4[6:0] = 7'b0010000;
			10:seg4[6:0] = 7'b0001000;
			11:seg4[6:0] = 7'b0000011;
			12:seg4[6:0] = 7'b1000110;
			13:seg4[6:0] = 7'b0100001;
			14:seg4[6:0] = 7'b0000110;
			15:seg4[6:0] = 7'b0001110;
			endcase
		end
		else
		begin
			seg3[6:0] = 7'b1111111;
			seg4[6:0] = 7'b1111111;
		end
	end
endmodule
