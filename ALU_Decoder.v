module ALU_Decoder
(
	input wire op5,
	input wire [2:0] funct3,
	input wire funct7_5,
	input wire [1:0] ALUOp,
	output reg [2:0] ALUControl
);
always@*
begin

case(ALUOp)
	2'b00:ALUControl=3'b000;///lw,sw
	2'b01:ALUControl=3'b001;///beq
	2'b10:
		begin
		case(funct3)
			3'b000:
			begin
				if({op5,funct7_5}==2'b11)
				ALUControl=3'b001;//sub
				else 
				ALUControl=3'b000;//add
			end
			3'b010:ALUControl=3'b101;//slt
			3'b110:ALUControl=3'b011;//or
			3'b111:ALUControl=3'b010;//and
			default:ALUControl=3'b000;
		endcase
		end
	default:ALUControl=3'b000;
endcase
end
endmodule