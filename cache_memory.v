module cache_memory #(parameter cache_width=128, 
                                cache_depth=32, 
                                memory_width=32, 
                                memory_depth=1024)(

    input wire clk, reset_n, fill,
    input wire[$clog2(memory_depth)-1:0] A,
    input wire[memory_width-1:0] PWD,   // processor write data 1 word
    input wire[cache_width-1 :0] MWD,   // memory write data    4 words

    output wire hit,
    output wire[memory_width-1:0] PRD,  // processor read data  1 word
    output wire[memory_width-1:0] MRD   // memory read data     4 words
);

endmodule