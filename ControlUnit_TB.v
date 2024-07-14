module ControlUnit_TB;

	//define TB signals
	reg [6:0] op_TB;                     
	reg [2:0] funct3_TB;                   
	reg funct7_5_TB;                  
	reg Zero_TB;                          
	wire PCSrc_TB,MemWrite_TB,ALUSrc_TB,RegWrite_TB;
	wire [1:0] ImmSrc_TB,ResultSrc_TB;
	wire [2:0] ALUControl_TB;
	
	wire [10:0] control_signals = {ALUControl_TB,RegWrite_TB,ImmSrc_TB,ALUSrc_TB,MemWrite_TB,ResultSrc_TB,PCSrc_TB};
	
	//instantiation
	ControlUnit DUT
	(
	.op(op_TB),                      
	.funct3(funct3_TB),                   
	.funct7_5(funct7_5_TB),                       
	.Zero(Zero_TB),                              
	.PCSrc(PCSrc_TB),
	.MemWrite(MemWrite_TB),
	.ALUSrc(ALUSrc_TB),
	.RegWrite(RegWrite_TB),
	.ImmSrc(ImmSrc_TB),
	.ResultSrc(ResultSrc_TB),
	.ALUControl(ALUControl_TB)
	);
	
	
	//initial values and test cases
	initial
	begin
		
		#10   
		
		Zero_TB = 1'b0;
		op_TB = 7'b0010011;
		funct3_TB = 3'b000;
		funct7_5_TB = 1'b1;    
		
		#10
		
		if (control_signals == 11'b000_1_00_1_0_00_0)  
		$display ("Control unit is working correctly -----> control_signals = %b \n ALUControl_TB = %b \t RegWrite_TB = %b \t ImmSrc_TB = %b \t ALUSrc_TB = %b \t MemWrite_TB = %b \t ResultSrc_TB = %b \t PCSrc_TB = %b",control_signals,ALUControl_TB,RegWrite_TB,ImmSrc_TB,ALUSrc_TB,MemWrite_TB,ResultSrc_TB,PCSrc_TB);
		else
		$display ("Control unit is not working correctly -----> control_signals = %b \n ALUControl_TB = %b \t RegWrite_TB = %b \t ImmSrc_TB = %b \t ALUSrc_TB = %b \t MemWrite_TB = %b \t ResultSrc_TB = %b \t PCSrc_TB = %b",control_signals,ALUControl_TB,RegWrite_TB,ImmSrc_TB,ALUSrc_TB,MemWrite_TB,ResultSrc_TB,PCSrc_TB);
		
		#10
		$stop;
		
	end

endmodule
