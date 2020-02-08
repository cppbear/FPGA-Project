module picture(clk, reset, clken, vga_clk, hsync, vsync, valid, red, green, blue, 
					hour, min, sec, year, month, day);
	input clk, reset, clken;
	input [5:0] hour, min, sec;
	input [13:0] year;
	input [5:0] month, day;
	
	reg [23:0] data=24'b0;
	
	output vga_clk, hsync, vsync, valid;
	
	wire temp_clk, clk1s;
	wire [9:0] h_addr, v_addr;
	
	output [7:0] red, green, blue;
	
	reg [18:0] rom_addr=19'b0;
	
	wire [11:0] temp_color1, temp_color2;
	
	reg [31:0] h_sec = 0, v_sec = 0;
	reg [31:0] h_min = 0, v_min = 0;
	reg [31:0] h_hour = 0, v_hour = 0;
	
	wire [19:0] temp1_sec,temp2_sec;
	wire [11:0] temp3_sec,temp4_sec,temp5_sec,temp6_sec;
	wire [19:0] temp1_min,temp2_min;
	wire [11:0] temp3_min,temp4_min,temp5_min,temp6_min;
	wire [19:0] temp1_hour,temp2_hour;
	wire [11:0] temp3_hour,temp4_hour,temp5_hour,temp6_hour;
	
	
	reg [5:0] sin_sec, cos_sec;
	reg [5:0] sin_min, cos_min;
	reg [5:0] sin_hour, cos_hour;
	
	reg [3:0] ymd [7:0];
	reg [2:0] count;
	reg [7:0] offset_x, offset_y, base;
	wire [11:0] char_color;
	
	initial
	begin
		ymd[0]=4'd2;
		ymd[1]=4'd0;
		ymd[2]=4'd1;
		ymd[3]=4'd9;
		ymd[4]=4'd1;
		ymd[5]=4'd2;
		ymd[6]=4'd2;
		ymd[7]=4'd6;
	end
	
	clkgen #(25000000) clk_(clk, 1'b0, 1'b1, temp_clk);
	vga_ctrl ctrl(temp_clk, 1'b0, data, h_addr, v_addr, hsync, vsync, valid, red, green, blue);
	ROM rom(rom_addr, temp_clk, temp_color1);
	
	assign vga_clk = temp_clk;
	
	//my_clock m_c(clk, clk1s);
	sin19 s19_sin_sec(sin_sec, temp_clk, temp1_sec);
	sin19 s19_cos_sec(cos_sec, temp_clk, temp2_sec);
	sin240 s2_sin_sec(sin_sec, temp_clk, temp3_sec);
	sin240 s2_cos_sec(cos_sec, temp_clk, temp4_sec);
	sin320 s3_sin_sec(sin_sec, temp_clk, temp5_sec);
	sin320 s3_cos_sec(cos_sec, temp_clk, temp6_sec);
	
	sin19 s19_sin_min(sin_min, temp_clk, temp1_min);
	sin19 s19_cos_min(cos_min, temp_clk, temp2_min);
	sin240 s2_sin_min(sin_min, temp_clk, temp3_min);
	sin240 s2_cos_min(cos_min, temp_clk, temp4_min);
	sin320 s3_sin_min(sin_min, temp_clk, temp5_min);
	sin320 s3_cos_min(cos_min, temp_clk, temp6_min);
	
	sin19 s19_sin_hour(sin_hour, temp_clk, temp1_hour);
	sin19 s19_cos_hour(cos_hour, temp_clk, temp2_hour);
	sin240 s2_sin_hour(sin_hour, temp_clk, temp3_hour);
	sin240 s2_cos_hour(cos_hour, temp_clk, temp4_hour);
	sin320 s3_sin_hour(sin_hour, temp_clk, temp5_hour);
	sin320 s3_cos_hour(cos_hour, temp_clk, temp6_hour);
	
	//my_hex h0(h / 10, h5);
	//my_hex h1(h % 10, h4);
	
	ROM_char char(base, temp_clk, char_color);
	
	
	
	always @(posedge temp_clk)
	begin
		ymd[0] = year / 1000;
		ymd[1] = (year % 1000) / 100;
		ymd[2] = (year % 100) / 10;
		ymd[3] = year % 10;
		
		ymd[4] = month / 10;
		ymd[5] = month % 10;
		
		ymd[6] = day / 10;
		ymd[7] = day % 10;
		
		count = h_addr / 9;
		offset_x = h_addr - {count, 3'b0} - count;
		offset_y = v_addr;
		base = {ymd[count], 4'b0} + offset_y;
	end
	
	
	
	always @(posedge temp_clk)
	begin
		if (sec >= 0 && sec < 15)
		begin
			sin_sec = sec << 1;
			cos_sec = (15 - sec) << 1;
			h_sec = (({22'b0, h_addr} * temp2_sec) >> 10) + (({22'b0, v_addr} * temp1_sec) >> 10) - temp6_sec - temp3_sec + 320;
			v_sec = (({22'b0, h_addr} * temp1_sec) >> 10) - (({22'b0, v_addr} * temp2_sec) >> 10) - temp5_sec + temp4_sec;
		end
		if (sec >= 15 && sec < 30)
		begin
			sin_sec = (30 - sec) << 1;
			cos_sec = (sec - 15) << 1;
			h_sec = -(({22'b0, h_addr} * temp2_sec) >> 10) + (({22'b0, v_addr} * temp1_sec) >> 10) + temp6_sec - temp3_sec + 320;
			v_sec = (({22'b0, h_addr} * temp1_sec) >> 10) + (({22'b0, v_addr} * temp2_sec) >> 10) - temp5_sec - temp4_sec;
		end
		if (sec >= 30 && sec < 45)
		begin
			sin_sec = (sec - 30) << 1;
			cos_sec = (45 - sec) << 1;
			h_sec = -(({22'b0, h_addr} * temp2_sec) >> 10) - (({22'b0, v_addr} * temp1_sec) >> 10) + temp6_sec + temp3_sec + 320;
			v_sec = -(({22'b0, h_addr} * temp1_sec) >> 10) + (({22'b0, v_addr} * temp2_sec) >> 10) + temp5_sec - temp4_sec;
		end
		if (sec >= 45 && sec <= 59)
		begin
			sin_sec = (60 - sec) << 1;
			cos_sec = (sec - 45) << 1;
			h_sec = (({22'b0, h_addr} * temp2_sec) >> 10) - (({22'b0, v_addr} * temp1_sec) >> 10) - temp6_sec + temp3_sec + 320;
			v_sec = -(({22'b0, h_addr} * temp1_sec) >> 10) - (({22'b0, v_addr} * temp2_sec) >> 10) + temp5_sec + temp4_sec;
		end
	end
	
	always @(posedge temp_clk)
	begin
		if (min >= 0 && min < 15)
		begin
			sin_min = min << 1;
			cos_min = (15 - min) << 1;
			h_min = (({22'b0, h_addr} * temp2_min) >> 10) + (({22'b0, v_addr} * temp1_min) >> 10) - temp6_min - temp3_min + 320;
			v_min = (({22'b0, h_addr} * temp1_min) >> 10) - (({22'b0, v_addr} * temp2_min) >> 10) - temp5_min + temp4_min;
		end
		if (min >= 15 && min < 30)
		begin
			sin_min = (30 - min) << 1;
			cos_min = (min - 15) << 1;
			h_min = -(({22'b0, h_addr} * temp2_min) >> 10) + (({22'b0, v_addr} * temp1_min) >> 10) + temp6_min - temp3_min + 320;
			v_min = (({22'b0, h_addr} * temp1_min) >> 10) + (({22'b0, v_addr} * temp2_min) >> 10) - temp5_min - temp4_min;
		end
		if (min >= 30 && min < 45)
		begin
			sin_min = (min - 30) << 1;
			cos_min = (45 - min) << 1;
			h_min = -(({22'b0, h_addr} * temp2_min) >> 10) - (({22'b0, v_addr} * temp1_min) >> 10) + temp6_min + temp3_min + 320;
			v_min = -(({22'b0, h_addr} * temp1_min) >> 10) + (({22'b0, v_addr} * temp2_min) >> 10) + temp5_min - temp4_min;
		end
		if (min >= 45 && min <= 59)
		begin
			sin_min = (60 - min) << 1;
			cos_min = (min - 45) << 1;
			h_min = (({22'b0, h_addr} * temp2_min) >> 10) - (({22'b0, v_addr} * temp1_min) >> 10) - temp6_min + temp3_min + 320;
			v_min = -(({22'b0, h_addr} * temp1_min) >> 10) - (({22'b0, v_addr} * temp2_min) >> 10) + temp5_min + temp4_min;
		end
	end
	
	always @(posedge temp_clk)
	begin
		if ((hour >= 0 && hour < 3) || (hour >= 12 && hour < 15))
		begin
			if (hour >= 0 && hour < 3)
			begin
				sin_hour = (hour * 5 << 1) + min / 6;
				cos_hour = ((3 - hour) * 5 << 1) - min / 6;
			end
			else
			begin
				sin_hour = ((hour - 12) * 5 << 1) + min / 6;
				cos_hour = ((15 - hour) * 5 << 1) - min / 6;
			end
			h_hour = (({22'b0, h_addr} * temp2_hour) >> 10) + (({22'b0, v_addr} * temp1_hour) >> 10) - temp6_hour - temp3_hour + 320;
			v_hour = (({22'b0, h_addr} * temp1_hour) >> 10) - (({22'b0, v_addr} * temp2_hour) >> 10) - temp5_hour + temp4_hour;
		end
		if ((hour >= 3 && hour < 6) || (hour >= 15 && hour < 18))
		begin
			if (hour >= 3 && hour < 6)
			begin
				sin_hour = ((6 - hour) * 5 << 1) - min / 6;
				cos_hour = ((hour - 3) * 5 << 1) + min / 6;
			end
			else
			begin
				sin_hour = ((18 - hour) * 5 << 1) - min / 6;
				cos_hour = ((hour - 15) * 5 << 1) + min / 6;
			end
			h_hour = -(({22'b0, h_addr} * temp2_hour) >> 10) + (({22'b0, v_addr} * temp1_hour) >> 10) + temp6_hour - temp3_hour + 320;
			v_hour = (({22'b0, h_addr} * temp1_hour) >> 10) + (({22'b0, v_addr} * temp2_hour) >> 10) - temp5_hour - temp4_hour;
		end
		if ((hour >= 6 && hour < 9) || (hour >= 18 && hour < 21))
		begin
			if (hour >= 6 && hour < 9)
			begin
				sin_hour = ((hour - 6) * 5 << 1) + min / 6;
				cos_hour = ((9 - hour) * 5 << 1) - min / 6;
			end
			else
			begin
				sin_hour = ((hour - 18) * 5 << 1) + min / 6;
				cos_hour = ((21 - hour) * 5 << 1) - min / 6;
			end
			h_hour = -(({22'b0, h_addr} * temp2_hour) >> 10) - (({22'b0, v_addr} * temp1_hour) >> 10) + temp6_hour + temp3_hour + 320;
			v_hour = -(({22'b0, h_addr} * temp1_hour) >> 10) + (({22'b0, v_addr} * temp2_hour) >> 10) + temp5_hour - temp4_hour;
		end
		if ((hour >= 9 && hour <= 11) || (hour >= 21 && hour <= 23))
		begin
			if (hour >= 9 && hour <= 11)
			begin
				sin_hour = ((12 - hour) * 5 << 1) - min / 6;
				cos_hour = ((hour - 9) * 5 << 1) + min / 6;
			end
			else
			begin
				sin_hour = ((24 - hour) * 5 << 1) - min / 6;
				cos_hour = ((hour - 21) * 5 << 1) + min / 6;
			end
			h_hour = (({22'b0, h_addr} * temp2_hour) >> 10) - (({22'b0, v_addr} * temp1_hour) >> 10) - temp6_hour + temp3_hour + 320;
			v_hour = -(({22'b0, h_addr} * temp1_hour) >> 10) - (({22'b0, v_addr} * temp2_hour) >> 10) + temp5_hour + temp4_hour;
		end
	end
	
	always @(posedge clk)
	begin
		if (h_addr <= 72 && v_addr <= 16)
		begin
			if (char_color[offset_x])
				data = 0;
			else
				data = 24'hffffff;
		end
		else if (h_sec >= 318 && h_sec <= 321 && v_sec >= 0 && v_sec <= 155)
			data = 24'hff0000;
		else if (h_min >= 316 && h_min <= 325 && v_min >= 0 && v_min < 130)
			data = 24'h00ff00;
		else if (h_hour >= 313 && h_hour <= 328 && v_hour >= 0 && v_hour < 100)
			data = 24'h0000ff;
		else
		begin
			rom_addr = {h_addr, v_addr[8:0]};
			data[23:20] = temp_color1[11:8];
			data[19:16] = 4'b0000;
			data[15:12] = temp_color1[7:4];
			data[11:8] = 4'b0000;
			data[7:4] = temp_color1[3:0];
			data[3:0] = 4'b0000;
		end
	end

endmodule
