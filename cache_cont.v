module cache_cont #(parameter cache_width=128, cache_depth=32, memory_width=32, memory_depth=1024)
(
    input wire clk,
    input wire reset_n,
    input wire rd_en,         // Read enable
    input wire wr_en,         // Write enable
	 input wire hit_miss,
    output reg stall,         // Stall signal
    input wire ready        // Ready signal from data memory
);
    
    
    reg [1:0] next_state, current_state;
    parameter [1:0] idle = 2'b00, write_through = 2'b01, write_around = 2'b10, read = 2'b11;
    


    always @(posedge clk or negedge reset_n) 
	 begin
        if (~reset_n) 
		  begin
            current_state <= idle;
        end 
		  else 
		  begin
            current_state <= next_state;
        end
    end


    always @(*) 
	 begin
	 
        case (current_state)
            idle: 
				begin
                if (wr_en) 
					 begin
                    if (hit_miss) 
						  begin
                        stall = 1'b1;
                        next_state = write_through;
                    end 
						  else 
						  begin
                        stall = 1'b1;
                        next_state = write_around;
                    end
                end 
					 else if (rd_en) 
					 begin
                    if (hit_miss) 
						  begin
                        next_state = idle;
                    end 
						  else
						  begin
                        stall = 1'b1;
                        next_state = read;
                    end
                end 
					 else 
					 begin
                    next_state = idle;
                end
            end

            write_through: 
				begin
                if (ready) 
					 begin 
                    stall = 1'b0;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = write_through;
                end
            end

            write_around: 
				begin
                if (ready) 
					 begin
                    stall = 1'b0;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = write_around;
                end
            end

            read: begin
                if (ready) 
					 begin
                    stall = 1'b0;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = read;
                end
            end

            default: 
				begin
                stall = 1'b0;
                next_state = idle;
            end
        endcase
    end

endmodule
