module	data_memory(
input wire clk,
input wire [31:0] ALUResult,
input wire memwrite,
input wire [31:0] write_data,
output reg [31:0] read_data );
  
reg [31:0] mem [0:127];

//-----------------main code------------------
always @(posedge clk)
  begin
  if (memwrite)
      begin
		mem[ALUResult]<=write_data;
  end
  
  
  if (!memwrite)
      begin
	   read_data <= mem[ALUResult];
	end	

  end
endmodule