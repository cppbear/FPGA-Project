module keyboard(clk, ps2_clk, ps2_data, 
					clock_set_hour, clock_set_min, clock_set_sec, clock_result_hour, clock_result_min, clock_result_sec,
					alarm_set_hour, alarm_set_min, alarm_set_sec, alarm_result_hour, alarm_result_min, alarm_result_sec);
	
	input clk, ps2_clk, ps2_data;
	
	input clock_set_hour, clock_set_min, clock_set_sec;		//set clock
	output reg [5:0] clock_result_hour, clock_result_min, clock_result_sec;
	
	input alarm_set_hour, alarm_set_min, alarm_set_sec;		//set alarm
	output reg [5:0] alarm_result_hour, alarm_result_min, alarm_result_sec;
	
	
	reg nextdata_n, pre;
	wire myClock, ready, overflow;
	wire [7:0] data;
	reg [7:0] my_data;
	
	reg [5:0] clock_ten, clock_one, clock_temp, clock_result;
	reg clock_flag;
	
	reg [5:0] alarm_ten, alarm_one, alarm_temp, alarm_result;
	reg alarm_flag;

	initial
	begin
		nextdata_n = 1;
		pre = 1;
		my_data = 8'b00000000;
		
	end

	
	
	//reg [15:0] freq;
	
	
	my_clock_key mycl(clk, myClock);
	ps2_keyboard key(clk, 1'b1, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
	//ROM r1(my_data, clk, ascii);
	
	//ASCII ascii(pre, up, my_data, ascii1, ascii2, hex2, hex3);
	
	always @(posedge myClock)
	begin
		if (ready == 1)
		begin
			
			if((data[7:0] != 8'hf0) && (pre == 1))
			begin
				pre = 1;
				my_data = data;
				if (clock_set_hour || clock_set_min || clock_set_sec)
				begin
					//my_data = 0;
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
					//default: clock_temp = 0;
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
					//my_data = 0;
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
					//default: alarm_temp = 0;
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
