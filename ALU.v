module ALU #(parameter width = 32)(
  input wire[width-1 : 0] SrcA, SrcB,
  input wire[2 : 0] AlUControl,
  output wire Zero,
  output reg[width-1 : 0] ALUResult
  );

always @(*) begin
case(AlUControl)
  3'b010: ALUResult = SrcA & SrcB ;                
  3'b011: ALUResult = SrcA | SrcB ;
  3'b000: ALUResult = SrcA + SrcB ;			 	 
  3'b001: ALUResult = SrcA - SrcB ;	
  3'b101: if (SrcA <SrcB) begin
		ALUResult = 32'b0000_0000_0000_0001;
		end else
		    ALUResult = 32'b0;
   default: ALUResult = 32'b0;
endcase
end
assign Zero = ! (|ALUResult);
endmodule		 
	  
