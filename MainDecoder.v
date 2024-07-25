module MainDecoder
(
	input wire [6:0] op,
<<<<<<< HEAD
	output reg Branch,MemWrite,MemRead,ALUSrc,RegWrite,
	output reg [1:0] ImmSrc,ALUOp,ResultSrc,Jump
=======
	output reg Branch,MemWrite,ALUSrc,RegWrite,
	output reg [1:0] ImmSrc,ALUOp,ResultSrc,
	output reg [1:0] Jump                     //input for a mux which decide it's a (PCTarget) or a (jump address) or (PC + 4)
>>>>>>> a2a3c89907f3e265ad00354540033060a5f979d4
);

	always @(*)
	begin
		case (op)
			7'b0000011:                             //lw istruction
			begin
				RegWrite = 1'b1;
				ImmSrc = 2'b00;
				ALUSrc = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b1;
				ResultSrc = 2'b01;
				Branch = 1'b0;
				ALUOp = 2'b00;
				Jump = 2'b00;                         //No jump (PC + 4)
			end
			
			7'b0100011:                             //sw instruction
			begin
				RegWrite = 1'b0;
				ImmSrc = 2'b01;
				ALUSrc = 1'b1;
				MemWrite = 1'b1;
				MemRead = 1'b0;
				ResultSrc = 2'b00;
				Branch = 1'b0;
				ALUOp = 2'b00;
				Jump = 2'b00;                         //No jump (PC + 4)
			end
			
			7'b0110011:                             //R-type instruction
			begin
				RegWrite = 1'b1;
				ImmSrc = 2'b00;
				ALUSrc = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b00;
				Branch = 1'b0;
				ALUOp = 2'b10;
				Jump = 2'b00;                         //No jump (PC + 4)
			end
			
			7'b1100011:                             //B-type instruction
			begin
				RegWrite = 1'b0;
				ImmSrc = 2'b10;
				ALUSrc = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b00;
				Branch = 1'b1;
				ALUOp = 2'b01;
				Jump = 2'b01;                         //Jump to (PCTarget)
			end
			
			7'b0010011:                             //I-type ALU instruction
			begin
				RegWrite = 1'b1;
				ImmSrc = 2'b00;
				ALUSrc = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b00;
				Branch = 1'b0;
				ALUOp = 2'b10;
				Jump = 2'b00;                         //No jump (PC + 4)
			end
			
			7'b1101111:                             //jal instruction
			begin
				RegWrite = 1'b1;
				ImmSrc = 2'b11;
				ALUSrc = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b10;
				Branch = 1'b0;
				ALUOp = 2'b00;
				Jump = 2'b01;                         //Jump to (PCTarget)
			end
		
			7'b1100111:                             //jalr instruction
			begin
				RegWrite = 1'b1;
				ImmSrc = 2'b00;
				ALUSrc = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b10;
				Branch = 1'b0;
				ALUOp = 2'b00;
				Jump = 2'b10;                         //Jump to (jump address)
			end
			
			default:
			begin
				RegWrite = 1'b0;
				ImmSrc = 2'b00;
				ALUSrc = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				ResultSrc = 2'b00;
				Branch = 1'b0;
				ALUOp = 2'b00;
				Jump = 2'b00;
			end
		endcase
	end
	
endmodule
