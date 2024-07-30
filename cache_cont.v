module cache_cont #(parameter cache_depth=32)
(
    input wire clk, reset_n,
    input wire rd_en, wr_en, hit, ready_to_read, finished_writing,

    output reg stall, refill, update,  
	output reg mem_read_en, mem_write_en   
    );	 
	 
    reg [1:0] next_state, current_state;
    parameter [1:0] idle = 2'b00, 
                    read = 2'b01, 
                    write = 2'b10;
                    
    
always @(negedge clk or negedge reset_n) 
    begin
    if (~reset_n) 
        current_state <= idle;
    else            
        current_state <= next_state;
end

always @(*) 
begin
    //Default values:
    stall = 0;
    refill = 0;
    update = 0;
    mem_read_en = 0;
    mem_write_en = 0;
    next_state = idle;

    case (current_state)
    idle: 
	begin
        if (wr_en) 
            next_state = write;

        else if (rd_en & (!hit)) 
            next_state = read;
        else
            next_state = idle;
    end

    write: 
	begin
        stall = 1;
        update = hit;
        mem_write_en = 1;

        if(finished_writing) 
            next_state = idle; 
        else
            next_state = write;
    end

    read: 
    begin
        stall = 1;
        refill = 1;
        mem_read_en = 1;

        if(ready_to_read) 
            next_state = idle;
        else
            next_state = read;
    end
    endcase
end	 
endmodule

