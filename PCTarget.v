module PCTarget #(parameter width = 32)
(
	input wire [width-1:0] PC,ImmExt,
	output reg [width-1:0] PCTarget
);

	always @(*)
	begin
		PCTarget = PC + ImmExt;
	end
	
endmodule

