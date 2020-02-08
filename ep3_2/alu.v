module alu(a,b,control,result,carry,of);
	input [3:0] a,b;
	input [2:0] control;
	output reg [3:0] result;
	output reg carry,of;
	reg [3:0] temp;
	always @ (*)
		if (control == 3'b111) begin
			{carry,result} = a+b; 
			of = (a[3]==b[3])&&(result[3]!=a[3]);
		end
		else if(control == 3'b110) begin
			temp = ((4'b1111)^b)+1;
			{carry,result} = a+temp;
			of = (a[3]!=b[3])&&(result[3]!=a[3]);
		end
		else if(control == 3'b101) begin
			result = ~a;
			carry = 0;
			of = 0;
		end
		else if(control == 3'b100) begin
			result = a & b;
			carry = 0;
			of = 0;
		end
		else if(control == 3'b011) begin
			result = a | b;
			carry = 0;
			of = 0;
		end
		else if(control == 3'b010) begin
			result = a ^ b;
			carry = 0;
			of = 0;
		end
		else if(control == 3'b001) begin
			carry = 0;
			of = 0;
			if (a[3] == 0 && b[3] == 1)
				result = 1;
			else if(a[3] == 1 && b[3] == 0)
				result = 0;
			else
				result = (a > b) ? 1 : 0;
		end
		else if(control == 3'b000) begin
			carry = 0;
			of = 0;
			result = (a == b) ? 1 : 0;
		end
endmodule
