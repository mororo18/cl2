module proj_01 (input logic modo, input clk, reset, output logic [2:0] A, output logic [2:0] B);

	// 3'b100 -> vermelho
	// 3'b010 -> amarelo
	// 3'b001 -> verde

	logic red = 3'b100;
	logic yel = 3'b010;
	logic green = 3'b001;

	reg period;
	integer clock_count = 0;

	always_comb begin

		if (A == green && B == red)
			period = 4;	
		else if (A == yel && B == red)
			period = 1;
		else if (A == red && B == green)
			period = 3;
		else if (A == red && B == yel)
			period = 1;
		else begin
			A = green; B = red;
		end
	end

	always @(posedge clk, negedge reset) begin
		if (~reset) begin
			A <= green; B <= red;
			clock_count = 0;
		end else
			clock_count += 1;
			case ({A, B})
			{green, red} : if (clock_count == period)
				{A, B} <= {yel, red};
			{yel, red} : if (clock_count == period)
				{A, B} <= {red, green};
			{red, green} : if (clock_count == period)
				{A, B} <= {red, yel};
			{red, yel} : if (clock_count == period)
				{A, B} <= {green, red};
			endcase
		
	end
	
endmodule 
