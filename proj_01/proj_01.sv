module proj_01 (input logic modo, input clk, reset, output logic A_green, A_yellow, A_red, output logic B_green, B_yellow, B_red);//, output logic [2:0] clock_count);

	// 3'b100 -> vermelho
	// 3'b010 -> amarelo
	// 3'b001 -> verde

	//const reg on = 1;
	//const reg off = 0;

	//reg period;
	//reg [2:0] clock_count;    
	
	//reg diurno = 1, noturno = 0;
	//reg  a=1, b=2, c=3, d=4;//, e=5, f=6;
	//logic [2:0] a=3'b001, b=3'b010, c=3'b011, d=3'b100, e=3'b101, f=3'b110;

	reg [2:0] state;
	//logic [2:0] state = 3'b001;
	//reg state_next;

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
			3'b000 : begin if (modo == 0) begin state <= 3'b001;
				end else state <= 3'b100;
				//end  else state <= e;
			end
			3'b001 : begin if (modo == 0) begin state <= 3'b010;
				//end  else state <= e;
				end else state <= 3'b100;
			end
			3'b010 : begin if (modo == 0) begin state <= 3'b011;
				//end else state <= e;
				end else state <= 3'b100;
			end
			3'b011 : begin if (modo == 0) begin state <= 3'b000;
				//end // else state <= e;
				end else state <= 3'b100;
			end

			3'b100 : begin if (modo == 1) begin state <= 3'b101;
				end else state <= 3'b000;
			end
			3'b101 : begin if (modo == 1) begin state <= 3'b100;
				end else state <= 3'b000;

			end
			endcase
		end
	end

	always_comb begin
	A_green = 0; B_green = 0;
	A_yellow = 0; B_yellow = 0;
	A_red = 0; B_red = 0;
/*
		A_green = 0;
		A_yellow = 0;
		A_red = 0;

		B_green = 0;
		B_yellow = 0;
		B_red = 0;
*/

		case (state)
		3'b000 : begin 
			A_green = 1;
			B_red = 1; 
		end
		3'b001 : begin 
			A_yellow = 1;
			B_red = 1; 
		end
		3'b010 : begin 
			B_green = 1;
			A_red = 1;
		end
		3'b011 : begin 
			B_yellow = 1;
			A_red = 1;
		end
		3'b100 : begin 
			A_yellow = 1;	B_yellow = 1;
		end
		3'b101 : begin 
		end
		endcase
	end

/*
	always_comb begin
		//state_next = state;
		case (state)
		a : if (modo == 0) begin state_next = b;
			end else state_next = e;
		b : if (modo == 0) begin state_next = c;
			end else state_next = e;
		c : if (modo == 0) begin state_next = d;
			end else state_next = e;
		d : if (modo == 0) begin state_next = a;
			end else state_next = e;
		e : if (modo == 1) begin state_next = f;
			end else state_next = a;
		f : if (modo == 1) begin state_next = e;
			end else state_next = a;
		endcase
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

/*
	always @(posedge clk, negedge reset) begin
		if (~reset) begin
			if (modo == 0)
				A <= green; B <= red;
			else	A <= yel; B <= yel;
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
*/
	
endmodule 
