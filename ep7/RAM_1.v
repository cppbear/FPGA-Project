module RAM_1
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=4)
(
	input [1:0] data,
	input [ADDR_WIDTH-1:0] inaddr,
	input [ADDR_WIDTH-1:0] outaddr, 
	input we, clk,
	output [6:0] hex1,
	output [6:0] hex0
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg=0;
	reg [DATA_WIDTH-1:0] q=0;
	wire clk_1s;
	integer i;
	
	initial
	begin
		$readmemh("F:/FPGA Project/ep7/mem1.txt", ram, 0, 15);
	end
	
	my_clock clock(clk, clk_1s);
	my_hex h1(q[7:4], hex1);
	my_hex h0(q[3:0], hex0);
	
	always @ (posedge clk_1s)
	begin
		if (we)
			ram[inaddr] <= {6'b000000, data};
		else
			q <= ram[addr_reg];
		addr_reg <= outaddr;
	end

endmodule
