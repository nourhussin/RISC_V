module cache_cont #(parameter cache_depth=32)
(
    input wire clk,
    input wire reset_n,
    input wire rd_en,                        // Read enable
    input wire wr_en,                        // Write enable
    output reg stall,                         // Stall signal
    input wire ready,                        // Ready signal from data memory
	 input wire [9:0] address,
	 output reg read_en,write_en              //outputs to the mem
);
    
    reg [2:0] tag_v [cache_depth-1:0];
	 reg [4:0] index_v [cache_depth-1:0];
	 
	 wire hit_miss;
	 assign hit_miss = (tag_v[address [6:2]] == address [9:7]) ? 1'b1 : 1'b0;
	 
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
						  write_en = 1'b1;
                    stall = 1'b0;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = write_through;
						  write_en = 1'b0;
                end
            end

            write_around: 
				begin
                if (ready) 
					 begin
					     write_en = 1'b1;
                    stall = 1'b0;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = write_around;
						  write_en = 1'b0;
                end
            end

            read: begin
                if (ready) 
					 begin
                    stall = 1'b0;
						  read_en = 1'b1;
                    next_state = idle;
                end 
					 else 
					 begin
                    next_state = read;
						  read_en = 1'b0;
                end
            end

            default: 
				begin
                stall = 1'b0;
					 write_en = 1'b0;
					 read_en = 1'b0;
                next_state = idle;
            end
        endcase
    end

	 
endmodule

