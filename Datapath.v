`include "Add4.v"
`include "ALU.v"
`include "mux.v"
`include "mux3.v"
`include "PC.v"
`include "PCTarget.v"
`include "sign_extension.v"
`include "Register_File.v"

module Datapath #(parameter width = 32)(
    input wire clk, reset_n, ALUSrc, RegWrite, // we may need to add 1 bit in RegWrite
    input wire [1 : 0] ResultSrc, ImmSrc, PCSrc,
    input wire [2 : 0] ALUControl,
    input wire [width-1 : 0] Instr, ReadData,

    output wire Zero,
    output wire [width-1 : 0] PC, ALUResult, WriteData
    );

    wire [width-1 : 0] PCNext, PCPlus4, PCTarget, ImmExt, SrcA, SrcB, Result;

    //--------------------PC----------------------------
    PC pcreg (
        .clk(clk),
        .reset_n(reset_n),
        .PC(PC),
        .PCNext(PCNext)
    );
    Add4 adder0 (
        .PC(PC),
        .PCPlus4(PCPlus4)
    );
    PCTarget adder1 (
        .PC(PC),
        .ImmExt(ImmExt),
        .PCTarget(PCTarget)
    );
    mux3 pc_src (
        .data1(PCPlus4),
        .data2(PCTarget),
        .data3(ALUResult),
        .selector(PCSrc),
        .out_data(PCNext)
    );

    //-----------------Register File--------------------
    Register_File rf (
        .clk(clk),
        .WE3(RegWrite),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(Result),
        .RD1(SrcA),
        .RD2(WriteData)
    );
    sign_extension extend (
        .Instr(Instr[31:7]),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    //----------------------ALU-------------------------
    mux alu_src (
        .data1(WriteData),
        .data2(ImmExt),
        .selector(ALUSrc),
        .out_data(SrcB)
    );
    ALU alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .AlUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );
    mux3 result_src(
        .data1(ALUResult),
        .data2(ReadData),
        .data3(PCPlus4),
        .selector(ResultSrc),
        .out_data(Result)
    );
    endmodule