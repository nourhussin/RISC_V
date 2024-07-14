module Register_File#(parameter width = 32, registers = 32)(

    input wire clk, WE3,
    input wire[$clog2(registers)-1 : 0] A1,A2,A3,
    input wire[width-1 : 0] WD3,

    output wire[width-1 : 0] RD1,RD2
    );

    reg[width-1 : 0] memory[registers-1 : 0];

    assign RD1 = memory[A1];
    assign RD2 = memory[A2];

    always@(posedge clk)
    begin
        if(WE3)
            memory[A3] <= WD3;
    end

    // Initialize the register file 
    integer iterator;
    initial begin
        for(iterator = 0; iterator < 32; iterator = iterator + 1)
        memory[iterator] = 32'h0;
    end
endmodule