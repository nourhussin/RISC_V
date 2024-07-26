module cache_memory #(parameter cache_width=128, 
                                cache_depth=32, 
                                memory_width=32, 
                                memory_depth=1024)(

    input wire clk, refill, update,
    input wire[1:0] offset,
    input wire[4:0] index,
    input wire[cache_width-1:0] line_data,   
    input wire[memory_width-1 :0] write_data,

    output reg[memory_width-1:0] read_data
    );

    wire [cache_width-1 : 0] read_cache_line;
    reg [cache_width-1 : 0] write_cache_line;
    reg [cache_width-1 : 0] cache_mem [cache_depth-1 : 0];


    assign read_cache_line = cache_mem[index];
    always @(*)
    begin
        case (offset)
        2'b00:
        begin
            read_data = read_cache_line[31:0];
            write_cache_line = {read_cache_line[127:32], write_data};
        end
        2'b01:
        begin
            read_data = read_cache_line[63:32];
            write_cache_line = {read_cache_line[127:64], write_data, read_cache_line[31:0]};

        end
        2'b10:
        begin
            read_data = read_cache_line[95:64];
            write_cache_line = {read_cache_line[127:96], write_data, read_cache_line[63:0]};
        end
        2'b11:
        begin
            read_data = read_cache_line[127:96];
            write_cache_line = {write_data, read_cache_line[95:0]};
        end
        endcase
    end

    always @(posedge clk)
    begin
        if(refill)
            cache_mem[index] <= line_data;
        else if(update)
            cache_mem[index] <= write_cache_line;

    end
endmodule