module main_memory (clk,reset,add,write_data,mem_read,mem_write,read_data,ready);

parameter add_width = 12;
parameter data_width = 32;
parameter mem_depth = 4096;

input clk,reset,mem_read,mem_write;
input [add_width-1:0] add;
input [data_width-1:0] write_data;
output reg [data_width-1:0] read_data;
output reg ready;

reg [data_width-1:0] mem [0:mem_depth-1];

always @(posedge clk or negedge reset)
begin
if (!reset)                                // initialize the memory 
begin
  integer i;
  for (i=0; i< mem_depth; i=i+1) begin
    mem[i]<= 0;
  end 
  ready<= 0;
  read_data<= 0;
end else if (mem_write) begin               // write in the memory
   mem[add] <= write_data;
   ready <= 1;
end else if (mem_read) 	begin               // read from the memory
   read_data<= mem[add];
	ready<=1;
end else 
   ready<=0;
end	



endmodule