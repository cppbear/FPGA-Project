module keyboard(clk, ps2_clk, ps2_data, 
					set_year, set_month, set_day, year_result, month_result, day_result,
					clock_set_hour, clock_set_min, clock_set_sec, clock_result_hour, clock_result_min, clock_result_sec,
					alarm_set_hour, alarm_set_min, alarm_set_sec, alarm_result_hour, alarm_result_min, alarm_result_sec);
	
	input clk, ps2_clk, ps2_data;
	
	input set_year, set_month, set_day;
	
	output reg [13:0] year_result;
	output reg [5:0] month_result, day_result;
	
	input clock_set_hour, clock_set_min, clock_set_sec;		//set clock
	output reg [5:0] clock_result_hour, clock_result_min, clock_result_sec;
	
	input alarm_set_hour, alarm_set_min, alarm_set_sec;		//set alarm
	output reg [5:0] alarm_result_hour, alarm_result_min, alarm_result_sec;
	
	
	reg nextdata_n, pre;
	wire myClock, ready, overflow;
	wire [7:0] data;
	reg [7:0] my_data;
	
	reg [13:0] year_th, year_hu, year_ten, year_one, year_temp;
	reg [1:0] year_flag;
	
	reg [5:0] ten, one, temp;
	reg flag;
	
	reg [5:0] clock_ten, clock_one, clock_temp;
	reg clock_flag;
	
	reg [5:0] alarm_ten, alarm_one, alarm_temp;
	reg alarm_flag;

	initial
	begin
		nextdata_n = 1;
		pre = 1;
		my_data = 8'b00000000;
		
	end
	
	
	my_clock_key mycl(clk, myClock);
	ps2_keyboard key(clk, 1'b1, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
	
	
	always @(posedge myClock)
	begin
		if (ready == 1)
		begin
			
			if((data[7:0] != 8'hf0) && (pre == 1))
			begin
				pre = 1;
				my_data = data;
				
				if (set_year)
				begin
					case(my_data)
						8'h45: year_temp = 6'd0;
						8'h16: year_temp = 6'd1;
						8'h1e: year_temp = 6'd2;
						8'h26: year_temp = 6'd3;
						8'h25: year_temp = 6'd4;
						8'h2e: year_temp = 6'd5;
						8'h36: year_temp = 6'd6;
						8'h3d: year_temp = 6'd7;
						8'h3e: year_temp = 6'd8;
						8'h46: year_temp = 6'd9;
						
						8'h70: year_temp = 6'd0;
						8'h69: year_temp = 6'd1;
						8'h72: year_temp = 6'd2;
						8'h7a: year_temp = 6'd3;
						8'h6b: year_temp = 6'd4;
						8'h73: year_temp = 6'd5;
						8'h74: year_temp = 6'd6;
						8'h6c: year_temp = 6'd7;
						8'h75: year_temp = 6'd8;
						8'h7d: year_temp = 6'd9;
					endcase
					if (year_flag == 2'b0)
					begin
						year_th = year_temp;
						year_flag = 2'b1;
					end
					else if (year_flag == 2'b1)
					begin
						year_hu = year_temp;
						year_flag = 2'b10;
					end
					else if (year_flag == 2'b10)
					begin
						year_ten = year_temp;
						year_flag = 2'b11;
					end
					else
					begin
						year_one = year_temp;
						year_flag = 2'b0;
					end
					year_result = year_th * 1000 + year_hu * 100 + year_ten * 10 + year_one;
				end
				
				if (set_month || set_day)
				begin
					case(my_data)
						8'h45: temp = 6'd0;
						8'h16: temp = 6'd1;
						8'h1e: temp = 6'd2;
						8'h26: temp = 6'd3;
						8'h25: temp = 6'd4;
						8'h2e: temp = 6'd5;
						8'h36: temp = 6'd6;
						8'h3d: temp = 6'd7;
						8'h3e: temp = 6'd8;
						8'h46: temp = 6'd9;
						
						8'h70: temp = 6'd0;
						8'h69: temp = 6'd1;
						8'h72: temp = 6'd2;
						8'h7a: temp = 6'd3;
						8'h6b: temp = 6'd4;
						8'h73: temp = 6'd5;
						8'h74: temp = 6'd6;
						8'h6c: temp = 6'd7;
						8'h75: temp = 6'd8;
						8'h7d: temp = 6'd9;
					endcase
					if (flag)
					begin
						one = temp;
						flag = 0;
					end
					else
					begin
						ten = temp;
						flag = 1;
					end
					if (set_month)
						month_result = ten * 10 + one;
					if (set_day)
						day_result = ten * 10 + one;
				end
				
				if (clock_set_hour || clock_set_min || clock_set_sec)
				begin
					case(my_data)
						8'h45: clock_temp = 6'd0;
						8'h16: clock_temp = 6'd1;
						8'h1e: clock_temp = 6'd2;
						8'h26: clock_temp = 6'd3;
						8'h25: clock_temp = 6'd4;
						8'h2e: clock_temp = 6'd5;
						8'h36: clock_temp = 6'd6;
						8'h3d: clock_temp = 6'd7;
						8'h3e: clock_temp = 6'd8;
						8'h46: clock_temp = 6'd9;
						
						8'h70: clock_temp = 6'd0;
						8'h69: clock_temp = 6'd1;
						8'h72: clock_temp = 6'd2;
						8'h7a: clock_temp = 6'd3;
						8'h6b: clock_temp = 6'd4;
						8'h73: clock_temp = 6'd5;
						8'h74: clock_temp = 6'd6;
						8'h6c: clock_temp = 6'd7;
						8'h75: clock_temp = 6'd8;
						8'h7d: clock_temp = 6'd9;
					endcase
					if (clock_flag)
					begin
						clock_one = clock_temp;
						clock_flag = 0;
					end
					else
					begin
						clock_ten = clock_temp;
						clock_flag = 1;
					end
					if (clock_set_hour)
						clock_result_hour = clock_ten * 10 + clock_one;
					if (clock_set_min)
						clock_result_min = clock_ten * 10 + clock_one;
					if (clock_set_sec)
						clock_result_sec = clock_ten * 10 + clock_one;
				end

				if (alarm_set_hour || alarm_set_min || alarm_set_sec)
				begin
					case(my_data)
						8'h45: alarm_temp = 6'd0;
						8'h16: alarm_temp = 6'd1;
						8'h1e: alarm_temp = 6'd2;
						8'h26: alarm_temp = 6'd3;
						8'h25: alarm_temp = 6'd4;
						8'h2e: alarm_temp = 6'd5;
						8'h36: alarm_temp = 6'd6;
						8'h3d: alarm_temp = 6'd7;
						8'h3e: alarm_temp = 6'd8;
						8'h46: alarm_temp = 6'd9;
						
						8'h70: alarm_temp = 6'd0;
						8'h69: alarm_temp = 6'd1;
						8'h72: alarm_temp = 6'd2;
						8'h7a: alarm_temp = 6'd3;
						8'h6b: alarm_temp = 6'd4;
						8'h73: alarm_temp = 6'd5;
						8'h74: alarm_temp = 6'd6;
						8'h6c: alarm_temp = 6'd7;
						8'h75: alarm_temp = 6'd8;
						8'h7d: alarm_temp = 6'd9;
					endcase
					if (alarm_flag)
					begin
						alarm_one = alarm_temp;
						alarm_flag = 0;
					end
					else
					begin
						alarm_ten = alarm_temp;
						alarm_flag = 1;
					end
					if (alarm_set_hour)
						alarm_result_hour = alarm_ten * 10 + alarm_one;
					if (alarm_set_min)
						alarm_result_min = alarm_ten * 10 + alarm_one;
					if (alarm_set_sec)
						alarm_result_sec = alarm_ten * 10 + alarm_one;
				end
				
			end
			else if(data[7:0] == 8'hf0)
			begin
				pre = 0;
				
				my_data = data; 
				
			end
			else if(pre == 0)    
				pre = 1;
			
			nextdata_n = 0;
		end
		
		else
			nextdata_n = 1;
	end

endmodule
