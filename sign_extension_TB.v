module sign_extension_TB;

	parameter width = 32;	
		
	//define TB signals
	reg [11:0] Instr_TB;                    
	wire [width-1:0] ImmExt_TB;
	
	//instantiation of Module
	sign_extension #(.width(width)) DUT
	(
	.Instr(Instr_TB),
	.ImmExt(ImmExt_TB)
	);
	
	
	//initial values and test cases
	initial 
	begin
		Instr_TB = 12'h000;                         // h for hexa decimal type (000 ---> 0000 0000 0000)
		#10
		if (ImmExt_TB == 32'h00000000)
			$display ("Test Case 1 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 1 is not passed ImmExt_TB = %h",ImmExt_TB);
		
		#10
		Instr_TB = 12'h001;
		#10
		if (ImmExt_TB == 32'h00000001)
			$display ("Test Case 2 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 2 is not passed ImmExt_TB = %h",ImmExt_TB);
		
		#10
		Instr_TB = 12'hF10;
		#10
		if (ImmExt_TB == 32'hFFFFFF10)
			$display ("Test Case 3 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 3 is not passed ImmExt_TB = %h",ImmExt_TB);
			
		#10
		$stop;
	end
	
endmodule

	