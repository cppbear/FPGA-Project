module keyboard(clk, ps2_clk, ps2_data, sign, hex5, hex4, hex3, hex2, hex1, hex0);
	input clk, ps2_clk, ps2_data;
	output reg sign;
	
	reg up, upflag1, upflag2, nextdata_n, pre;
	wire myClock, ready, overflow;
	wire [7:0] data, ascii_low, ascii_cap;
	reg [7:0] my_data, count_;
	reg [11:0] vmem_addr = 12'b0;
	reg key, back, enter;
	wire [11:0] row;
	wire [11:0] num;
	wire [7:0] q;
	wire clear;
	output [6:0]hex5, hex4, hex3, hex2, hex1, hex0;

	initial
	begin
		nextdata_n = 1;
		pre = 1;
		count_ = 8'b00000000;
		my_data = 8'b00000000;
		up = 0;
		upflag1 = 0;
		upflag2 = 0;
		key = 0;
		back = 0;
		enter = 0;
	end

	my_hex h1(row[7:4], hex1);
	my_hex h0(row[3:0], hex0);
	
	my_hex h5(q[7:4], hex5);
	my_hex h4(q[3:0], hex4);
	
	my_hex h3(vmem_addr[7:4], hex3);
	my_hex h2(vmem_addr[3:0], hex2);
	
	
	RAM_videomem vm_test(8'b0, vmem_addr - 1'b1, clk, 12'b0, 1'b0, 1'b0, q);
	
	
	my_clock mycl(clk, myClock);
	ps2_keyboard keybo(clk, 1'b1, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
	//ROM_low low(my_data, clk, ascii_low);
	//ROM_cap cap(my_data, clk, ascii_cap);
	RAM_backspace bac(myClock, key, back, enter, row, num, clear);
	write_vmem wrvm(clk, up, vmem_addr, my_data);
	
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
					count_ = count_ + 1'b1;
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
