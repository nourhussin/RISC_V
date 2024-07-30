module mux2 #(parameter width = 32)(
    input wire [width-1 : 0] data1, data2,
    input wire selector,

    output wire [width-1 : 0] out_data
    );

    assign out_data = (selector? data2 : data1);
endmodule