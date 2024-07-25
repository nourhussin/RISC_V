module data_memory #(parameter width = 32, depth = 1024)(//4KB
input wire clk,
input wire [$clog2(depth)-1:0] A,
input wire WE,RE,
input wire [width-1:0] WD,

output reg read_ready, finished_writing,
output reg [width-1:0] RD );
  
reg [width-1:0] mem [depth-1:0];

//-----------------main code------------------
always @(posedge clk)
  begin
  if (WE)
  begin
      mem[A] <= WD;
      finished_writing <= 1;
  end
  else 
      finished_writing <= 0;
  end

always @(*)
  begin
  if(RE)
  begin
    RD = mem[A];
    read_ready = 1;
  end
  else
  begin
    RD = 0;
    read_ready = 0;
  end
  end
endmodule
