`include "Datapath.v"
`include "ControlUnit.v"

module top_module #(parameter width = 32)(
    input wire clk, reset_n,
    input wire [width-1 : 0] Instr, ReadData,

    output wire MemWrite,
    output wire [width-1 : 0] PC, ALUResult, WriteData

    );

    wire ALUSrc, RegWrite, PCSrc, Zero;
    wire [1 : 0] ResultSrc, ImmSrc;
    wire [2 : 0] ALUControl;

    ControlUnit CU(
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7_5(Instr[30]),
        .Zero(Zero),
        .ALUControl(ALUControl),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc)
    );

    Datapath DP(
        .clk(clk),    
        .reset_n(reset_n),
        .PCSrc(PCSrc),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ResultSrc(ResultSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .Instr(Instr),
        .ReadData(ReadData),
        .Zero(Zero),
        .PC(PC),
        .ALUResult(ALUResult),
        .WriteData(WriteData)
    );
    
endmodule