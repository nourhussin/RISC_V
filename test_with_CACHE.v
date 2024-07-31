`include "top_module.v"
`include "Instruction_Memory.v"
`include "memory_system.v"

module test_with_CACHE;
    reg clk_tb = 0, reset_n_tb;
    wire clk, reset_n, stall;

    assign clk = clk_tb;
    assign reset_n = reset_n_tb;

    wire MemWrite, MemRead;
    wire[31:0] Instr, PC, DataAdr, WriteData, ReadData;

    top_module Processor(
        .clk(clk),
        .reset_n(reset_n),
        .stall(stall),
        .Instr(Instr),
        .ReadData(ReadData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .PC(PC),
        .ALUResult(DataAdr),
        .WriteData(WriteData)
    );

    memory_system CACHE(
        .clk(clk),
        .reset_n(reset_n),
        .A(DataAdr[9:0]),
        .WE(MemWrite),
        .RE(MemRead),
        .WD(WriteData),
        .RD(ReadData),
        .stall(stall)
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
