module Instruction_Memory#(parameter depth = 256, width = 32)(
    // 8 Kb memory , if we want increase the size, increase the depth
    input wire[$clog2(depth)-1 : 0] A,

    output wire[width-1 : 0] RD
    );

    reg [width-1 : 0] memory [depth-1 : 0];

    assign RD = memory[A];
    // Upload the program code here 
    /*
    initial begin
        memory[0] = 32'h00000000000000;
        memory[1] = 32'h00000000000000;
        memory[2] = 32'h00000000000000;
        memory[3] = 32'h00000000000000;
    end
    */
    // Initialize the register file with random for test only
    integer iterator;
    initial begin
        for(iterator = 0; iterator < 256; iterator = iterator + 1)
        memory[iterator] = iterator;
    end
endmodule