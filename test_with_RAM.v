`include "top_module.v"
`include "Instruction_Memory.v"
`include "data_memory.v"

module test_with_RAM;
    reg clk_tb = 0, reset_n_tb;
    wire clk, reset_n;

    assign clk = clk_tb;
    assign reset_n = reset_n_tb;

    wire MemWrite, MemRead;
    wire[31:0] Instr, PC, DataAdr, WriteData, ReadData;

    top_module Processor(
        .clk(clk),
        .reset_n(reset_n),
        .Instr(Instr),
        .ReadData(ReadData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .PC(PC),
        .ALUResult(DataAdr),
        .WriteData(WriteData)
    );

    data_memory RAM(
        .clk(clk),
        .A(DataAdr[9:0]),
        .WE(MemWrite),
        .RE(MemRead),
        .WD(WriteData),
        .RD(ReadData)
    );

    Instruction_Memory IM(
        .A(PC[9:2]),
        .RD(Instr)
    );

    localparam T = 10;
    always#(T/2) clk_tb = !clk_tb;

    initial begin
        reset_n_tb = 1;
        #T;
        reset_n_tb = 0;
        #T;

        reset_n_tb = 1;
        #(30*T);

        #1000
        $stop;
        
    end

endmodule
