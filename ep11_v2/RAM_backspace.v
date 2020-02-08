module RAM_backspace
#(parameter DATA_WIDTH=7, parameter ADDR_WIDTH=5)
(
	//input [ADDR_WIDTH-1:0] inaddr,
	//input [ADDR_WIDTH-1:0] outaddr, 
	input clk,
	input key,
	input back,
	input enter,
	output reg [4:0]count = 0,
	output reg [DATA_WIDTH-1:0] q=0,
	output reg full = 0
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	//reg [ADDR_WIDTH-1:0] addr_reg=0;
	//reg [DATA_WIDTH-1:0] q=0;
	//wire clk_1s;
	integer i;
	
	//my_clock clock(clk, clk_1s);
	
	always @ (posedge clk)
	begin
		if (key)
		begin
			if (ram[count] < 69)
			begin
				ram[count] <= ram[count]+1'b1;
			end
			else if (count < 29)
			begin
				count <= count + 1'b1;
				ram[count] <= 0;
			end
			else
			begin
				full <= 1;
				for (i=0;i<29;i=i+1)
				begin
					ram[i] <= ram[i+1];
				end
				ram[count] <= 0;
			end
		end
		
		if (back)
		begin
			if (ram[count] > 0)
			begin
				ram[count] <= ram[count]-1'b1;
			end
			else if (count > 0)
			begin
				count <= count - 1'b1;
			end
		end
		
		if (enter)
		begin
			if (count < 29)
			begin
				count <= count + 1'b1;
				ram[count] <= 0;
			end
			else
			begin
				full <= 1;
				for (i=0;i<29;i=i+1)
				begin
					ram[i] <= ram[i+1];
				end
				ram[count] <= 0;
			end
		end
		
		q <= ram[count];
		//addr_reg <= outaddr;
	end

endmodule
