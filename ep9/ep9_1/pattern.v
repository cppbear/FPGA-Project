module pattern(clk, reset, clken, vga_clk, hsync, vsync, valid, red, green, blue);
	input clk, reset, clken;
	reg [23:0] data=24'b0;
	output vga_clk, hsync, vsync, valid;
	wire temp_clk;
	wire [9:0] h_addr, v_addr;
	output [7:0] red, green, blue;
	
	clkgen #(25000000) clk_(clk, 1'b0, 1'b1, temp_clk);

	vga_ctrl ctrl(temp_clk, 1'b0, data, h_addr, v_addr, hsync, vsync, valid, red, green, blue);
	assign vga_clk = temp_clk;
	
	always @(posedge vga_clk)
	begin
		if (h_addr <= 100)
			data = 24'hff0000;
		else if (h_addr <= 200)
			data = 24'h00ff00;
		else if (h_addr <= 300)
			data = 24'h0000ff;
		else if (h_addr <= 400)
			data = 24'hffff00;
		else if (h_addr <= 500)
			data = 24'hff00ff;
		else if (h_addr <= 600)
			data = 24'h00ffff;
		else
			data = 24'hffffff;
	end
endmodule
