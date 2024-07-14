module sign_extension_TB;

	parameter width = 32;	
		
	//define TB signals
	reg [24:0] Instr_TB;                               
	reg [1:0] ImmSrc_TB;
	wire [width-1:0] ImmExt_TB;
	
	
	//instantiation of Module
	sign_extension #(.width(width)) DUT
	(
	.Instr(Instr_TB),
	.ImmSrc(ImmSrc_TB),
	.ImmExt(ImmExt_TB)
	);
	
	
	//initial values and test cases
	initial 
	begin
		Instr_TB = 25'b0000000000000000000010100; 
		ImmSrc_TB = 2'b00;
		#10
		if (ImmExt_TB == 32'h00000000)
			$display ("Test Case 1 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 1 is not passed ImmExt_TB = %h",ImmExt_TB);
		
		#10
		ImmSrc_TB = 2'b01;
		#10
		if (ImmExt_TB == 32'h00000014)
			$display ("Test Case 2 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 2 is not passed ImmExt_TB = %h",ImmExt_TB);
		
		#10
		ImmSrc_TB = 2'b10;
		#10
		if (ImmExt_TB == 32'h00000014)
			$display ("Test Case 3 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 3 is not passed ImmExt_TB = %h",ImmExt_TB);
			
		#10
		ImmSrc_TB = 2'b11;
		#10
		if (ImmExt_TB == 32'h00000000)
			$display ("Test Case 4 is passed ImmExt_TB = %h",ImmExt_TB);
		else
			$display ("Test Case 4 is not passed ImmExt_TB = %h",ImmExt_TB);
			
		#10
		$stop;
	end
	
endmodule

