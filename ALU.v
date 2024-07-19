module ALU (ScrA,ScrB,AluControl,zero,ALUResult);

input [width-1:0] ScrA,ScrB;
input [2:0] AluControl;
output zero;
output [width-1:0] ALUResult;                        // how many bit in the result?

parameter width =32;

always @(*) begin
case(AluControl)
  3'b010: ALUResult <= ScrA & ScrB ;                
  3'b011: ALUResult <= ScrA | ScrB ;
  3'b000: ALUResult <= ScrA + ScrB ;			 	 
  3'b001: ALUResult <= ScrA - ScrB ;	
  3'b101: if (ScrA <ScrB) begin
		ALUResult<=32'b0000_0000_0000_0001;
		end else
		    ALUResult<= 32'b0;
   default: ALUResult <=32'b0;
endcase
					
end
endmodule		 
	  
