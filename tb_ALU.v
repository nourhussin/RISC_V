`include "ALU.v"
module tb_ALU();

reg [31:0] ScrA;
reg [31:0] ScrB;
reg [2:0] AluControl;
wire zero;
wire [31:0] ALUResult;

ALU DUT (
    .ScrA(ScrA),
    .ScrB(ScrB),
    .AluControl(AluControl),
    .zero(zero),
    .ALUResult(ALUResult)
);


initial begin

    ScrA = 16'b0;
    ScrB = 16'b0;
    AluControl = 3'b000;
   
    #10;
    ScrA = 16'b1010101010101010;
    ScrB = 16'b0101010101010101;
    AluControl = 3'b000;
    #10;

    ScrA = 16'b1010101010101010;
    ScrB = 16'b0101010101010101;
    AluControl = 3'b001;
    #10;

    ScrA = 16'b0000000000000010;
    ScrB = 16'b0000000000000011;
    AluControl = 3'b010;
    #10;

    ScrA = 16'b1010101010101010;
    ScrB = 16'b0101010101010101;
    AluControl = 3'b100;
    #10;

    ScrA = 16'b1010101010101010;
    ScrB = 16'b0101010101010101;
    AluControl = 3'b101;
    #10;

    ScrA = 16'b0000000000000011;
    ScrB = 16'b0000000000000010;
    AluControl = 3'b110;
    #10;

    ScrA = 16'b0000000000000010;
    ScrB = 16'b0000000000000011;
    AluControl = 3'b111;
    #10;

    ScrA = 16'b0000000000000011;
    ScrB = 16'b0000000000000010;
    AluControl = 3'b111;
    #10;
end

endmodule
