module data_flag(data,nextdata_n,a3,a1,a2,ready,clk);
input [7:0]data;
input clk;
input ready;
output reg nextdata_n;
reg [7:0] ram1;

 reg ctrl_flag;
 reg upper_flag;
 reg [7:0]preram1;

reg [7:0] count;
output wire [6:0]a1;
output wire [6:0]a2;
output wire [6:0]a3;

reg stop_flag;


out_put p1(ram1[3:0],a1);
out_put p2(ram1[7:4],a2);
out_put p3(count[3:0],a3);

initial 
	begin
		ram1=8'b00000000;
		preram1=8'b00000000;
		count=8'b00000000;
		stop_flag=1'b0;
		upper_flag=1'b0;
		ctrl_flag=1'b0;
	end
	
always @(posedge clk)
	begin
		if(ready)
		begin
			if(data==8'h58)
				upper_flag=~upper_flag;
			else
			begin
				if(data!=8'hF0)
				begin
					if(preram1==8'h14)
						if(data==8'h21||data==8'h2A)
							ctrl_flag=1;
						else
							ctrl_flag=0;
					else
						ctrl_flag=0;
					if(preram1==8'hF0)
						stop_flag=1;
					else
					begin
						stop_flag=0;
						count=count+1;
						ram1=data;
					end
				end
				else
					stop_flag=1;
			preram1=data;
			nextdata_n=0;
			end
		end
		else
		begin
			nextdata_n=1;
		end  
	end
endmodule
		
		