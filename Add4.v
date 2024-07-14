module Add4 #(parameter width = 32)
(
	input wire [width-1:0] PC,
	output reg [width-1:0] PCPlus4
);

	always @(*)
	begin
		PCPlus4 = PC + 4;
	end
	
endmodule 