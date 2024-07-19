module tb_mux();

reg a;
reg b;
reg s;
wire out;

mux DUT (
    .a(a),
    .b(b),
    .s(s),
    .out(out)
);

initial begin
    a = 0; b = 0; s = 0;
    #10;
    a = 0; b = 0; s = 0;
    #10;
    a = 0; b = 1; s = 0;
    #10;
    a = 1; b = 0; s = 0;
    #10;
    a = 1; b = 1; s = 0;
    #10;
    a = 0; b = 0; s = 1;
    #10;
    a = 0; b = 1; s = 1;
    #10;
    a = 1; b = 0; s = 1;
    #10;
    a = 1; b = 1; s = 1;
    #10;

    $stop;
end

endmodule
