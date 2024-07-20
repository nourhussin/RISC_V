module mux3_1 (q1,q2,q3,s,out);

input q1,q2,q3;
input [1:0] s;
output reg out;

always @(*)
begin
   if (s<=2'b00)
	begin
	out<= q1;
	end
	else if (s<=2'b10) 
	begin
	out<= q2;
	end
	else begin
	out<= q3;
	end
end	
endmodule	