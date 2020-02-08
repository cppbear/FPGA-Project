module kyboard(clk,clrn,ps2_clk,ps2_data,ready,overflow,seg1,seg2,seg3,seg4,seg5,seg6,up,ctrlc,ctrlv);
	input clk;
	input clrn;
	input ps2_clk;
	input ps2_data;
	
	output ready;
	output overflow;
	output reg ctrlc;
	output reg ctrlv;
	reg ctrlflag;
	reg ctrl;
	
	output [6:0]seg1;
	output [6:0]seg2;
	output [6:0]seg3;
	output [6:0]seg4;
	output [6:0]seg5;
	output [6:0]seg6;
	
	reg nextdata_n;
	wire [7:0] data;    //接收从ps2_keyboard中得到的8位键码，作为实例化的wire输出
	reg [7:0] my_data;  //接收8位键码
	reg [7:0] mycount;  //用于计数按键次数
	//wire [7:0] ascii;    //存储ascii码
	wire [7:0] ascii1;
	wire [7:0] ascii2;
	reg pre;
	reg clk_f;           //扩了50倍的时钟
	reg [6:0]count_clk;       //用作分频器
	output reg up;
	reg upflag1;
	reg upflag2;
	//reg preflag;
	initial
	begin
		nextdata_n = 1;
		clk_f = 0;
		pre = 1;
		count_clk = 0;
		mycount = 8'b00000000;
		my_data = 8'b00000000;
		up = 0;
		upflag1 = 0;
		upflag2 = 0;
		ctrlc = 0;
		ctrlv = 0;
		ctrlflag = 0;
		ctrl = 0;
		//preflag = 1;
		//overflow = 0;
		//ready = 0;
		/*seg1[6:0] = 7'b1111111;
		seg2[6:0] = 7'b1111111;
		seg3[6:0] = 7'b1111111;
		seg4[6:0] = 7'b1111111;
		seg5[6:0] = 7'b1111111;
		seg6[6:0] = 7'b1111111;
		*/
		//predata[7:0] = 8'b00000000;
		//prepredata[7:0] = 8'b00000000;
	end
	
	always @ (posedge clk)
	begin
		if(count_clk==100)
		begin
			count_clk <= 0;
			clk_f <= ~clk_f;
			end
		else
		count_clk<=count_clk + 1;
	end
	
	ps2_keyboard P(clk,clrn,ps2_clk,ps2_data,data,ready,nextdata_n,overflow);
	ROM my_rom(.address(my_data),.clock(clk),.q(ascii1));
	
	ROMUP my_rom2(.address(my_data),.clock(clk),.q(ascii2));
	
	show s1(.pre(pre), .my_data(my_data), .seg1(seg1), .seg2(seg2), .preflag(preflag));
	show_ascii S2(.pre(pre), .up(up), .my_data(my_data), .ascii1(ascii1), .ascii2(ascii2), .seg3(seg3), .seg4(seg4), .preflag(preflag));
	show_count S3(.mycount(mycount), .seg5(seg5), .seg6(seg6));
	
	
	always @ (posedge clk_f)
	begin
		if(ready == 1)
		begin
			//preflag = 1;
			if(data[7:0] == 8'h58)    //caps的大写识别
			begin
				if((pre == 1) && (upflag1 == 0))
				begin
					up = ~up;
					upflag1 = 1;
				end
				else if(pre == 0)
					upflag1 = 0;
			end
			
			if(data[7:0] == 8'h12 || data[7:0] == 8'h59)    //shift情况的大写
			begin
				if((pre == 1) && (upflag2 == 0))
				begin
					up = ~up;
					upflag2 = 1;
				end
				else if(pre == 0)
				begin
					up = ~up;
					upflag2 = 0;
				end
			end
			
			if(data[7:0] == 8'h14)         //ctrl组合键
			begin
				if((pre == 1) && (ctrlflag == 0))
				begin
					ctrl = 1; ctrlflag = 1;
				end
				else if(pre == 0)
				begin
					ctrl = 0;
					ctrlflag = 0;
				end
			end
			
			if((data[7:0] != 8'hf0) && (pre == 1))
			begin
				pre = 1;
				my_data = data;
				if((ctrl == 1) && (my_data[7:0] == 8'h21))
					ctrlc = 1;
				if((ctrl == 1) && (my_data[7:0] == 8'h2A))
					ctrlv = 1;
			end
			else if(data[7:0] == 8'hf0)
			begin
				pre = 0;
				mycount = mycount + 1;
				my_data = data; 
				ctrlc = 0;
				ctrlv = 0;
			end
			else if(pre == 0)    
			begin
				pre = 1;
				//preflag = 0;
				//my_data = data;
			end

			nextdata_n = 0;
		end
		
		else 
		begin
			nextdata_n = 1;
		end
	end
	
endmodule
