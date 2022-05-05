module proj_01 (input logic modo, input clk, reset, output logic [2:0] A, output logic [2:0] B, output logic [2:0] clock_count);

	// 3'b100 -> vermelho
	// 3'b010 -> amarelo
	// 3'b001 -> verde

	reg [2:0] red = 3'b100;
	reg [2:0] yel = 3'b010;
	reg [2:0] green = 3'b001;

	reg period;
	//reg [2:0] clock_count;    

    reg [2:0] t;

    /*
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
    */

    /*
	always @(posedge clk, negedge reset) begin
		if (~reset) begin
            t <= 0;
		end else begin
        end
    end
    */

	always @(posedge clk, negedge reset) begin
		if (~reset) begin
			A <= green; B <= red;
			clock_count <= 1;
		end else begin
			clock_count <= clock_count + 1;
			case ({A, B})
			{green, red} : if (clock_count == 4) begin
				{A, B} <= {yel, red}; clock_count <= 1; end
			{yel, red} : if (clock_count == 1) begin
				{A, B} <= {red, green};  clock_count <= 1; end
			{red, green} : if (clock_count == 3) begin
				{A, B} <= {red, yel};  clock_count <= 1; end
			{red, yel} : if (clock_count == 1) begin
				{A, B} <= {green, red};  clock_count <= 1; end
			endcase
        end
		
	end
	
endmodule 
