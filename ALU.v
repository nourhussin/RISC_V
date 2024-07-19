module ALU (clk,reset,ScrA,ScrB,AluControl,zero,ALUResult);

input [15:0] ScrA,ScrB;
input clk,reset;
input [2:0] AluControl;
output reg zero;
output reg  [31:0] ALUResult;                        // how many bit in the result?

parameter width =32;

always @(posedge clk,negedge reset) begin
       if (reset) begin 
		        ALUResult<= 32'b0;
		 end
       else begin 
              case(AluControl)
			         3'b000: ALUResult <= ScrA & ScrB ;                
			         3'b001: ALUResult <= ScrA | ScrB ;
			         3'b010: ALUResult <= ScrA + ScrB ;		
			         3'b100: ALUResult <= ScrA & ~ScrB ;	 
			         3'b101: ALUResult <= ScrA | ~ScrB ;	
			         3'b110: ALUResult <= ScrA - ScrB ;	
			         3'b111: if (ScrA <ScrB) begin
									ALUResult<=32'b0000_0000_0000_0001;
								  end else
								   ALUResult<= 32'b0;
			         default: ALUResult <=32'b0;
					endcase
		 end			
end
endmodule		 
	  
