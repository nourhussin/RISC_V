module PC #(parameter width = 32)
(
	input wire clk,reset_n,
	input wire [width-1:0] PCNext,
	output reg [width-1:0] PC
);
			
			
	always @(posedge clk,negedge reset_n)
	begin
		if (!reset_n)
			PC <= 0;
		else
			PC <= PCNext;
	end

endmodule
