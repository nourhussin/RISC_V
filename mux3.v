module mux3 #(parameter width = 32)(
    input wire [width-1 : 0] data1, data2, data3,
    input wire [1:0] selector,

    output wire [width-1 : 0] out_data
    );

    assign out_data = selector[1]? data3 : (selector[0]? data2 : data1);
endmodule