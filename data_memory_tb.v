module	data_memory_tb();

reg clk_tb;
reg [31:0] ALUResult_tb;
reg memwrite_tb;
reg [31:0] write_data_tb;
wire [31:0] read_data_tb;


data_memory DUT(
.clk(clk_tb),
.ALUResult(ALUResult_tb),
.memwrite(memwrite_tb),
.write_data(write_data_tb),
.read_data(read_data_tb),
);

always #5 clk_tb=~clk_tb;

initial begin
clk_tb<=0;
memwrite_tb<=1'b1;
#10;
write_data_tb<= 32'b0;


#10;    ALUResult_tb<= 32'b0000_0011_1100_0000;
       write_data_tb<= 32'b0101_0101_0101_0101;
		 
#10;    ALUResult_tb<= 32'b0000_1111_0000_1111;
       write_data_tb<= 32'b1010_1010_1010_1010;
		 
#10;    ALUResult_tb<= 32'b0000_0101_0001_0010;
       write_data_tb<= 32'b0101_1110_1111_0000;
		 
#10;    ALUResult_tb<= 32'b0110_1100_0001_0000;
       write_data_tb<= 32'b0000_0000_0001_0001;	
		 
#10;    ALUResult_tb<= 32'b0000_0000_0000_1111;
       write_data_tb<= 32'b0100_0000_1000_1000;
#10;
memwrite_tb<=1'b0;        ALUResult_tb<=32'b0000_0101_0001_0010;
#10;
memwrite_tb<=1'b0;		    ALUResult_tb<=32'b0000_0000_0000_0001;
#10;
memwrite_tb<=1'b1;
#10;
memwrite_tb<=1'b0;        ALUResult_tb<=32'b0000_0000_0000_1111;       

end
endmodule
