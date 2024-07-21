module data_memory #(parameter width = 32, depth = 128)(//4KB
input wire clk,
input wire [$clog2(depth)-1:0] A,
input wire WE,
input wire [width-1:0] WD,
output reg [width-1:0] RD );
  
reg [width-1:0] mem [depth-1:0];

//-----------------main code------------------
always @(posedge clk)
  begin
  if (WE)
  begin
      mem[A] <= WD;
  end
  end

always @(*)
  begin
  if(!WE)
    RD = mem[A];
  end
endmodule
