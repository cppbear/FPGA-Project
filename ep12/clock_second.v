module clock_second(clk, set, x, alarm_set, alarm, hex0, hex1, carry, sec, hour, min, alarm_hour, alarm_min, freq, alarm_en);
	input clk, set;
	input [5:0] x;
	input [5:0] min;
	
	input [2:0] alarm_set;
	input [5:0] alarm;
	
	input [5:0] hour, alarm_hour, alarm_min;
	input alarm_en;
	
	output reg [5:0] sec = 0;
	output reg [6:0] hex0, hex1;
	output reg carry = 0;
	output reg [15:0] freq;
	
	reg [5:0] val;
	
	wire clk_1s;
	
	reg [25:0] count;
	
	my_clock mclk(clk, clk_1s);
	
	
	reg [3:0] hex0_clock, hex1_clock;
	reg [3:0] hex0_alarm, hex1_alarm;
	wire [6:0] hex0_temp1, hex1_temp1;
	wire [6:0] hex0_temp2, hex1_temp2;
	
	
	my_hex h0_clock(hex0_clock, hex0_temp1);
	my_hex h1_clock(hex1_clock, hex1_temp1);
	
	my_hex h0_alarm(hex0_alarm, hex0_temp2);
	my_hex h1_alarm(hex1_alarm, hex1_temp2);
	
	always @(posedge clk)
	begin
		hex0_alarm <= val % 10;
		hex1_alarm <= val / 10;
		if (alarm_set)
		begin
			if (alarm_set[0])
				val <= alarm;
			
			hex0 <= hex0_temp2;
			hex1 <= hex1_temp2;
		end
		else
		begin
			hex0 <= hex0_temp1;
			hex1 <= hex1_temp1;
		end
	end
	
	
	
	always @(posedge clk or posedge set)
	begin
		if (set)
			count <= 0;
		else if (count == 50000000)
			count <= 0;
		else
			count <= count + 26'b1;
	end
	
	
	always @(posedge clk)
	begin
		if (alarm_en && hour == alarm_hour && min == alarm_min && (sec == val || sec == val + 6'd1 || sec == val + 6'd2))
		begin
			if (count <= 18000000)
				freq = 1396.9;
			else
				freq = 16'b0;
		end
		
		else if ((min == 59 && (sec == 57 || sec == 58 || sec == 59)) || (min == 0 && sec == 0))
		begin
			if (count <= 12500000)
			begin
				if (sec == 0)
					freq = 1174.7;
				else
					freq = 783.99;
			end
			else
				freq = 16'b0;
		end
		else
			freq = 16'b0;
	end
	
	
	always @(posedge clk_1s or posedge set)
	begin
		hex0_clock <= sec % 10;
		hex1_clock <= sec / 10;
		if (set)
			sec <= x;
		else
		begin
			if (sec >= 59)
			begin
				carry <= 1;
				sec <= 0;
			end
			else
			begin
				carry <= 0;
				sec <= sec + 1;
			end
		end
	end
endmodule
