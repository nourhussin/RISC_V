module sign_extension #(parameter width = 32)
(
	input wire [24:0] Instr,  	 //maps Instr [31:7] from the instruction memory
	input wire [1:0] ImmSrc,        //selector to select the extension operation for a specific type
	output reg [width-1:0] ImmExt
);

	always @(*)
	begin
		case (ImmSrc)
		2'b00: ImmExt = {{20{Instr[24]}},Instr[24:13]};             //extension for I type
		2'b01: ImmExt = {{20{Instr[24]}},Instr[24:18],Instr[4:0]};             //extension for S type
		2'b10: ImmExt = {{20{Instr[24]}},Instr[0],Instr[23:18],Instr[4:1],1'b0};             //extension for B type
		2'b11: ImmExt = {{12{Instr[24]}},Instr[12:5],Instr[13],Instr[23:14],1'b0};             //extension for J type
		endcase
	end
	
endmodule 
