`include "cache_memory.v"
`include "cache_cont.v"
`include "main_memory.v"

module memory_system #(parameter memory_width = 32, memory_depth = 1024)(
    input wire clk, reset_n,WE,RE,
    input wire[memory_width-1 : 0] WD,
    input wire[$clog2(memory_depth)-1:0] A,

    output wire stall,
    output wire[memory_width-1 : 0] RD
    );

    wire mem_read_en, mem_write_en, ready_to_read, finished_writing;
    wire hit, refill, update;
    wire [(4*memory_width)-1 : 0] internal_data_line;
    
    main_memory MEMORY(
        .clk(clk),
        .mem_read(mem_read_en),
        .mem_write(mem_write_en),
        .add(A),
        .write_data(WD),
        .read_data(internal_data_line),
        .ready_to_read(ready_to_read),
        .finished_writing(finished_writing)
    );
    cache_cont CONTROL (
        .clk(clk),
        .reset_n(reset_n),
        .rd_en(RE),
        .wr_en(WE),
        .hit(hit),
        .ready_to_read(ready_to_read),
        .finished_writing(finished_writing),
        .stall(stall),
        .refill(refill),
        .update(update),
        .mem_read_en(mem_read_en),
        .mem_write_en(mem_write_en)
    );
    cache_memory CACHE(
        .clk(clk),
        .reset_n(reset_n),
        .RE(RE),
        .refill(refill),
        .update(update),
        .offset(A[1:0]),
        .index(A[6:2]),
        .tag(A[9:7]),
        .line_data(internal_data_line),
        .write_data(WD),
        .read_data(RD),
        .hit(hit)
    );

endmodule