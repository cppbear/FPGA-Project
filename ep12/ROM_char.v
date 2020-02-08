module ROM_char
#(parameter DATA_WIDTH=12, parameter ADDR_WIDTH=8)
(
	input [ADDR_WIDTH-1:0] outaddr, 
	input clk,
	output reg [DATA_WIDTH-1:0] q
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	wire clk_1s;
	
	initial
	begin
		$readmemh("F:/FPGA Project/ep12/vga_font.txt", ram, 0, 159);
	end
	
	my_clock clock(clk, clk_1s);
	
	always @ (posedge clk)
	begin
		q <= ram[outaddr];
	end

endmodule