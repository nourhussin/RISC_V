`include "Instruction_Memory.v"
module Instruction_Memory_tb;

    reg[7:0] A;

    wire[31:0] RD;

    Instruction_Memory DUT(A, RD);

    // Read first 32 instructions
    integer iterator;
    initial begin
        for(iterator = 0; iterator < 32; iterator = iterator + 1)
        begin
        A = iterator; #5;
        end
    end

endmodule