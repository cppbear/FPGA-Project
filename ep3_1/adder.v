module adder(a,b,control,result,carry,zf,of);
	input [3:0] a,b;
	input control;
	output reg [3:0] result;
	output reg carry,zf,of;
	reg [3:0] t;
	always @ (*)
		if (control==0) begin
			{carry,result} = a+b;
			of = (a[3]==b[3])&&(result[3]!=a[3]);
			zf = ~(|result);
		end
		else begin
			t = ((4'b1111)^b)+1;
			{carry,result} = a+t;
			of = (a[3]!=b[3])&&(result[3]!=a[3]);
			zf = ~(|result);
		end
endmodule 