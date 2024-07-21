`include "PC.v"
module PC_TB;
	
	parameter width = 32;
	
	//define signals of TB
	reg clk_TB,reset_n_TB;
	reg [width-1:0] PCNext_TB;
	wire [width-1:0] PC_TB;
	
	//generate clock
	always#5 clk_TB = ~clk_TB;         // we assume that the period is 10 ns
	
	//instantiation
	PC #(.width(width)) DUT
	(
	.clk(clk_TB),
	.reset_n(reset_n_TB),
	.PCNext(PCNext_TB),
	.PC(PC_TB)
	);
	
	//initial values and test cases
	initial
	begin
		//initialization
		clk_TB = 1'b0;
		reset_n_TB = 1'b1;
		PCNext_TB = 20;
		
		//reseting the PC
		#10
		reset_n_TB = 1'b0;       
		#10
		reset_n_TB = 1'b1;                //deactivation of reset after one period
		
		//Test case
		#5
		PCNext_TB = 32'h00000004;         // change value of PCNext from 0 to 4 at 25ns
	
		#5
		if (PC_TB == 32'h00000004)
		$display ("PC is work correctly, PC = %h",PC_TB);
		else
		$display ("PC is not work correctly, PC = %h",PC_TB);
		
		#10
		$stop;
		
	end
	
endmodule
