module sign_extension #(parameter width = 32)
(
	input wire [11:0] Instr,                       //bits [31:20] of isntruction
	output reg [width-1:0] ImmExt
);

	always @(Instr)
	begin
			ImmExt = {{20{Instr[11]}},Instr};             //extend the Instr to be 32 bits instead of 12 bits
	end
endmodule 
