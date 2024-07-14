module Add4_TB;

	parameter width = 32; 
   
	//define TB signals
	reg [width-1:0] PC_TB;
	wire [width-1:0] PCPlus4_TB;
	
	//instantiation of Module
	Add4 #(.width(width)) DUT
	(
	.PC(PC_TB),
	.PCPlus4(PCPlus4_TB)
	);
	
	
	//initial values and test cases
	initial 
	begin
		PC_TB = 32'h00000000;                         // h for hexa decimal type (000 ---> 0000 0000 0000)
		#10
		if (PCPlus4_TB == 32'h00000004)
			$display ("The block is working correctly PCPlus4 = %h",PCPlus4_TB);
		else
			$display ("The block is not working correctly PCPlus4 = %h",PCPlus4_TB);
		#10
		$stop;
	end
	
endmodule

	