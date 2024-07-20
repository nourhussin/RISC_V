module ALU_Decoder
(
	input wire op5,
	input wire [2:0] funct3,
	input wire funct7_5,
	input wire [1:0] ALUOp,
	output reg [2:0] ALUControl
);

	always @(*)
	begin
		case ({ALUOp,funct3,op5,funct7_5})
		7'b00_010_0_x: ALUControl = 3'b000;                              //lw instruction
		7'b00_010_1_x: ALUControl = 3'b000;                              //sw instruction
		7'b10_000_0_x: ALUControl = 3'b000;                              //addi
		7'b10_110_0_x: ALUControl = 3'b011;                              //ori
		7'b10_111_0_x: ALUControl = 3'b010;                              //andi
		7'b10_000_1_0: ALUControl = 3'b000;                              //add
		7'b10_000_1_1: ALUControl = 3'b001;                              //sub
		7'b10_110_1_0: ALUControl = 3'b011;                              //or
		7'b10_111_1_0: ALUControl = 3'b010;                              //and
		7'b01_000_1_x: ALUControl = 3'b001;                              //beq
		7'b01_001_1_x: ALUControl = 3'b001;                              //bne
		7'bxx_xxx_1_x: ALUControl = 3'b000;                              //jal
		7'b10_000_1_x: ALUControl = 3'b000;                              //jalr
		default: ALUControl = 3'bxxx;                  
		endcase
	end
	
endmodule
