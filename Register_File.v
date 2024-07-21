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
        memory[0] <= 0;
        if(WE3 && A3) // Never write in X0
            memory[A3] <= WD3;
    end

endmodule