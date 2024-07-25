`include "cache_memory.v"
`include "cache_control.v"
`include "data_memory.v"

module memory_system #(parameter memory_width = 32, memory_depth = 1024)(
    input wire clk, reset_n,WE,RE,
    input wire[memory_width-1 : 0] RD,
    input wire[$clog2(memory_depth)-1:0] A,

    output wire stall,
    output wire[memory_width-1 : 0] WD
    );

endmodule