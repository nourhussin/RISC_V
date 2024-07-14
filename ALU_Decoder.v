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
		7'b00_xxx_xx: ALUControl = 3'b000;             //lw , sw
		7'b01_xxx_xx: ALUControl = 3'b001;             //beq
		7'b10_000_00: ALUControl = 3'b000;             //add
		7'b10_000_01: ALUControl = 3'b000; 	            //add
		7'b10_000_10: ALUControl = 3'b000;             //add
		7'b10_000_11: ALUControl = 3'b001;             //sub
		7'b10_010_xx: ALUControl = 3'b101;             //slt
		7'b10_110_xx: ALUControl = 3'b011;              //or
		7'b10_111_xx: ALUControl = 3'b010;              //and
		default: ALUControl = 3'bxxx;                   //nop
		endcase
	end
	
endmodule
