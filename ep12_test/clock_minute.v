module clock_minute(clk, second, set, x, alarm_set, alarm, hex0, hex1, carry, min, alarm_min);
	input clk, second, set;
	input [5:0] x;
	
	input [2:0] alarm_set;
	input [5:0] alarm;
	
	output reg [5:0] min = 0;
	output reg [6:0] hex0, hex1;
	output [5:0] alarm_min;
	
	output reg carry = 0;
	reg [5:0] val;
	
	wire clk_1s;
	
	reg [3:0] hex0_clock, hex1_clock;
	reg [3:0] hex0_alarm, hex1_alarm;
	wire [6:0] hex0_temp1, hex1_temp1;
	wire [6:0] hex0_temp2, hex1_temp2;
	
	assign alarm_min = val;
	
	//my_clock mclk(clk, clk_1s);
	
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
			if (alarm_set[1])
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
	
	
	always @(posedge second or posedge set)
	begin
		hex0_clock <= min % 10;
		hex1_clock <= min / 10;
		if (set)
			min <= x;
		else
		begin
			if (min >= 59)
			begin
				carry <= 1;
				min <= 0;
			end
			else
			begin
				carry <= 0;
				min <= min + 1;
			end
		end
	end
endmodule
