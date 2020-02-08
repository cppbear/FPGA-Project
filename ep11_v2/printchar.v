module printchar(clk, reset, clken, vga_clk, hsync, vsync, valid, red, green, blue);
	input clk, reset, clken;
	reg [23:0] data=24'b0;
	output vga_clk, hsync, vsync, valid;
	wire temp_clk;
	wire [9:0] h_addr, v_addr;
	wire [11:0] x;
	wire [11:0] y;
	output [7:0] red, green, blue;
	//output [6:0] hex5, hex4;
	reg [11:0] ram_addr=12'b0;
	//output reg [8:0] addr;
	wire [7:0]ascii;
	
	reg [11:0] base, offset_x, offset_y;
	wire [11:0] temp_data;
	
	clkgen #(25000000) clk_(clk, 1'b0, 1'b1, temp_clk);
	vga_ctrl ctrl(temp_clk, 1'b0, data, h_addr, v_addr, x, y, hsync, vsync, valid, red, green, blue);
	read_vmem rdvm(temp_clk, ram_addr, ascii);
	ROM_char char(base, temp_clk, temp_data);
	
	
	assign vga_clk = temp_clk;
	
	always @(posedge clk)
	begin
		ram_addr = x << 6 + x << 2 + x << 1 + y;
		//addr=ram_addr[8:0];
		offset_x = h_addr - (x << 3) - x;
		offset_y = v_addr - (y << 4);
		base = {ascii, 4'b0000} + offset_y;
		if (temp_data[offset_x])
			data = 24'hffffff;
		else
			data = 24'b0;
	end

endmodule
