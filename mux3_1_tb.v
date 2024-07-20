module mux3_1_tb ();

reg q1;
reg q2;
reg q3;
reg s;
wire out;

mux3_1 DUT (
.q1(q1_tb),
.q2(q2_tb),
.q3(q3_tb),
.s(s_tb),
.out(out_tb)
);

initial begin
      q1 = 0; q2 = 0; q3 = 0; s= 2'b00;
		#10;
		q1 = 0; q2 = 0; q3 = 1; s =2'b01;
		#10;
		q1 = 0; q2 = 1; q3 = 0; s =2'b10;
		#10;
		q1 = 1; q2 = 0; q3 = 0; s= 2'b00;
		#10;
		q1 = 0; q2 = 0; q3 = 1; s= 2'b11;
		
		$stop;
end
endmodule		