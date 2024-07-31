module main_memory (clk,add,write_data,mem_read,mem_write,read_data,ready_to_read,finished_writing);

parameter add_width = 10;
parameter data_width = 32;
parameter mem_depth = 1024;

input clk,mem_read,mem_write;
input [add_width-1:0] add;
input [data_width-1:0] write_data;

output reg [(4*data_width)-1:0] read_data;
output reg ready_to_read, finished_writing;

reg [data_width-1:0] mem [0:mem_depth-1];
reg [1 : 0] counter = 2'b00;

always @(posedge clk)
begin
   if (mem_write)
   begin          
      mem[add] <= write_data;
      finished_writing <= (counter == 2'b11)? 1 : 0;
      counter <= counter + 1;
   end

   else if (mem_read) 
   begin    
      ready_to_read <= (counter == 2'b11)? 1 : 0;
      counter <= counter + 1;  
   end
end
always @(*)
begin
      read_data = {mem[{add[9:2], 2'b11}], mem[{add[9:2], 2'b10}], mem[{add[9:2], 2'b01}], mem[{add[9:2], 2'b00}]}; 
end
endmodule
