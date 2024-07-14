`include "Register_File.v"
module Register_File_tb;

    localparam T = 10;
    reg clk = 0;

    reg WE3;
    reg [4:0] A1,A2,A3;
    reg [31:0] WD3;

    wire[31:0] RD1,RD2;

    Register_File DUT(
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WE3(WE3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2),
        .clk(clk)
    );

    always#(T/2) clk = ~clk;

    initial begin
        WE3 = 0;
        A1 = 5'b10000; A2 = 5'b00111; A3 = 5'b00000;
        WD3 = 32'b01111;
        #T;

        WE3 = 1;
        #T;
        A3 = 5'b01; #T;
        A3 = 5'b10; #T;
        WD3 = 20; A3 = 3; #T;
        WE3 = 0;

        A1 = 0; A2 = 1; #T;
        A1 = 2; A2 = 3; #T;
    end
endmodule