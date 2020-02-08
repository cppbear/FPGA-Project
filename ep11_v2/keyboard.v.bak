module keyboard(clk, ps2_clk, ps2_data, sign, temp);
	input clk, ps2_clk, ps2_data;
	output reg sign;
	
	reg up, upflag1, upflag2, nextdata_n, pre;
	wire myClock, ready, overflow;
	wire [7:0] data, ascii_low, ascii_cap;
	reg [7:0] my_data;
	reg [11:0] vmem_addr = 12'b0;
	reg key, back, enter;
	wire [11:0] row;
	wire [11:0] num;
	wire clear;
	output [8:0]temp;

	initial
	begin
		nextdata_n = 1;
		pre = 1;
		//count_ = 8'b00000000;
		my_data = 8'b00000000;
		up = 0;
		upflag1 = 0;
		upflag2 = 0;
		key = 0;
		back = 0;
		enter = 0;
	end

	assign temp=row[8:0];
	
	my_clock mycl(clk, myClock);
	ps2_keyboard keybo(clk, 1'b1, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
	//ROM_low low(my_data, clk, ascii_low);
	//ROM_cap cap(my_data, clk, ascii_cap);
	RAM_backspace bac(ps2_clk, key, back, enter, row, num, clear);
	write_vmem wrvm(myClock, up, vmem_addr, my_data);
	
	always @(posedge myClock)
	begin
		if (ready == 1)
		begin
			if (data[7:0] == 8'h58)				//Caps
			begin
				if (pre == 1 && upflag1 == 0)
				begin
					up = ~up;
					upflag1 = 1;
				end
				else if (pre == 0)
					upflag1 = 0;
			end
			
			if (data[7:0] == 8'h12 || data[7:0] == 8'h59)	//Shift
			begin
				if (pre == 1 && upflag2 == 0)
				begin
					up = ~up;
					upflag2 = 1;
				end
				else if (pre == 0)
				begin
					up = ~up;
					upflag1 = 0;
				end
			end
			
			//if (data[7:0] == 8'h)
			
			
			if((data[7:0] != 8'hf0) && (pre == 1))
			begin
				sign=1;
				if (data[7:0] == 8'h66)					//Backspace
				begin
					pre = 1;
					key = 0;
					back = 1;
					enter = 0;
					vmem_addr = row<<6+row<<2+row<<1+num;
					my_data = 8'h00;
				end
				else if (data[7:0] == 8'h5a)			//Enter
				begin
					pre = 1;
					key = 0;
					back = 0;
					enter = 1;
					vmem_addr = row<<6+row<<2+row<<1;
					my_data = 8'h00;
				end
				else
				begin
					pre = 1;
					my_data = data;
					vmem_addr = vmem_addr + 1'b1;
					key = 1;
					back = 0;
					enter = 0;
				end
			end
			
			else if(data[7:0] == 8'hf0)			//断码
			begin
				sign=0;
				pre = 0;
				//count_ = count_ + 1;
				//my_data = data;
				key = 0;
				back = 0;
				enter = 0;
			end
			
			else if(pre == 0)    
				pre = 1;
			
			nextdata_n = 0;
		end
		
		else
			nextdata_n = 1;
	end

endmodule
