module clock_hour(clk, minute, set, x, alarm_set, alarm, hex0, hex1, hour, alarm_hour);
	input clk, minute, set;
	input [5:0] x;
	
	input [2:0] alarm_set;
	input [5:0] alarm;
	
	output reg [5:0] hour = 0;
	output reg [6:0] hex0, hex1;
	output [5:0] alarm_hour;
	
	reg [5:0] val;
	
	wire clk_1s;
	
	reg [3:0] hex0_clock, hex1_clock;
	reg [3:0] hex0_alarm, hex1_alarm;
	wire [6:0] hex0_temp1, hex1_temp1;
	wire [6:0] hex0_temp2, hex1_temp2;
	
	assign alarm_hour = val;
	
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
			if (alarm_set[2])
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
	
	
	always @(posedge minute or posedge set)
	begin
		hex0_clock <= hour % 10;
		hex1_clock <= hour / 10;
		if (set)
			hour <= x;
		else
		begin
			if (hour >= 23)
			begin
				hour <= 0;
			end
			else
			begin
				hour <= hour + 1;
			end
		end
	end
endmodule
