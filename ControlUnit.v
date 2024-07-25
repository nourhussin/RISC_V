module ControlUnit
(
	input wire [6:0] op,                      //connected with Instr [6:0] in the top
	input wire [2:0] funct3,                   //connected with Instr [14:12] in the top
	input wire funct7_5,                       //connected with Instr [30] in the top
	input wire Zero,                               //output from ALU module 
	output wire MemWrite,MemRead,ALUSrc,RegWrite,
	output wire [1:0] ImmSrc,ResultSrc,PCSrc,
	output wire [2:0] ALUControl
);

	wire Branch;
	wire [1:0] ALUOp,Jump;
	
	MainDecoder B0
	(
	.op(op),
	.Branch(Branch),
	.Jump(Jump),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.ALUSrc(ALUSrc),
	.RegWrite(RegWrite),
	.ImmSrc(ImmSrc),
	.ALUOp(ALUOp),
	.ResultSrc(ResultSrc)
	);
	
	ALU_Decoder B1
	(
	.op5(op[5]),
	.funct3(funct3),
	.funct7_5(funct7_5),
	.ALUOp(ALUOp),
	.ALUControl(ALUControl)
	);
	
	assign PCSrc[0] = (((funct3 == 3'b000) & Zero & Branch) |
					   ((funct3 == 3'b001) & !Zero & Branch) |
					   	Jump[0]);

	assign PCSrc[1] = Jump[1];


endmodule
