module proj_01 (input logic modo, input clk, reset, output logic A_green, A_yellow, A_red, output logic B_green, B_yellow, B_red);

    localparam [2:0] 
        g_r = 0,
        y_r = 1,
        r_g = 2,
        r_y = 3,
        y_y = 4,
        b_b = 5;

    localparam T4 = 4;
    localparam T1 = 1;
    localparam T3 = 3;

	reg [2:0] state, state_next;
	reg [2:0] t;

	always_comb begin
		state_next = state;
        case (state)
        g_r : begin if (modo == 0 && t > T4 - 1) begin state_next = y_r;
            end else if (modo == 1) state_next = y_y;
        end
        y_r : begin if (modo == 0 && t > T1 - 1) begin state_next = r_g;
            end else if (modo == 1) state_next = y_y;
        end
        r_g : begin if (modo == 0 && t > T3 - 1) begin state_next = r_y;
            end else if (modo == 1) state_next = y_y;
        end
        r_y : begin if (modo == 0 && t > T1 - 1) begin state_next = g_r;
            end else if (modo == 1) state_next = y_y;
        end

        y_y : begin if (modo == 1 && t > T1 - 1) begin state_next = b_b;
            end else if (modo == 0) state_next = g_r;
        end
        b_b : begin if (modo == 1 && t > T1 - 1) begin state_next = y_y;
            end else if (modo == 0) state_next = g_r;
        end
        endcase
	end

	always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            t <= 1;
        end
        else begin
            if (state != state_next) // mudanca d estado
                t <= 1;
            else
                t <= t + 1;
        end
    end

	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= g_r;
		else begin
            state <= state_next; 
		end
	end

	always_comb begin
	A_green = 0;  B_green = 0;
	A_yellow = 0; B_yellow = 0;
	A_red = 0;    B_red = 0;

		case (state)
		g_r : begin 
			A_green = 1;
			B_red = 1; 
		end
		y_r : begin 
			A_yellow = 1;
			B_red = 1; 
		end
		r_g : begin 
			A_red = 1;
			B_green = 1;
		end
		r_y : begin 
			A_red = 1;
			B_yellow = 1;
		end
		y_y : begin 
			A_yellow = 1;	
            B_yellow = 1;
		end
		endcase
	end


endmodule 
