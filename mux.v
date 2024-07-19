module mux (a,b,s,out);

input a,b,s;
output reg out;

always @(*)
begin 
  if (s) begin
      out<=b;
  end else 
      out<=a; 
end
endmodule		