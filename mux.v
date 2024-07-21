module mux #(parameter width = 32)(
    input wire [width-1 : 0] data1, data2,
    input wire selector,   

    output reg [width-1 : 0] out_data
    );

always @(*)
begin 
  if (selector) begin
      out_data = data2;
  end else 
      out_data = data1; 
end
endmodule		