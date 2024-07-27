module cache_cont #(parameter cache_width=128, cache_depth=32, memory_width=32, memory_depth=1024)
(
    input wire clk,
    input wire reset_n,
    input wire rd_en,         // Read enable
    input wire wr_en,         // Write enable
    input wire [9:0] address, // 10-bit address
    input wire [cache_width-1:0] data_in, // Data input
    output reg stall,         // Stall signal
    input wire ready,        // Ready signal from data memory
    output reg [cache_width-1:0] data_out // Data output
);

    reg [memory_width-1:0] mem [0:memory_depth-1]; 
    reg [cache_width-1:0] cache [0:cache_depth-1];
    reg [2:0] tag [0:cache_depth-1];   
    reg valid [0:cache_depth-1];       
    
    reg [1:0] next_state, current_state;
    parameter [1:0] idle = 2'b00, write_through = 2'b01, write_around = 2'b10, read = 2'b11;
    
    wire [4:0] index = address[6:2]; 
    wire [2:0] tag_value = address[9:7]; 
    wire hit_miss; 


    assign hit_miss = (valid[index] && (tag[index] == tag_value)) ? 1'b1 : 1'b0;


    always @(posedge clk or negedge reset_n) 
	 begin
        if (~reset_n) begin
            current_state <= idle;
            stall <= 1'b0;
            data_out <= 0;
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
                stall = 1'b0;
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
                        data_out = cache[index]; 
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
                    cache[index] = data_in; 
                    tag[index] = tag_value; 
                    valid[index] = 1'b1; 
                    mem[address] = data_in;
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
                    mem[address] = data_in; // Write data to memory
                    stall = 1'b0;
                    next_state = idle;
                end 
		else 
		begin
                    next_state = write_around;
                end
            end

            read: 
	    begin
                if (ready) 
	        begin
                    data_out = mem[address]; // Read data from memory
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
                data_out = 0;
                next_state = idle;
            end
        endcase
    end

endmodule
