`include "memory_system.v"
module memory_system_tb;
    reg clk = 0, reset_n,WE,RE;
    reg [31 : 0] WD;
    reg [9:0] A;

    wire stall;
    wire[31 : 0] RD;

    memory_system MEMORY(
        .clk(clk),
        .reset_n(reset_n),
        .WE(WE),
        .RE(RE),
        .WD(WD),
        .A(A),
        .RD(RD),
        .stall(stall)
    );

    localparam T = 100;
    always#(T/2) clk = ~clk;

    initial begin
        reset_n = 0; #1; reset_n =1;

        WE = 0; RE = 0; WD = 50; A = 10;
        #(T);

        WE = 1; RE = 0; WD = 50; A = 10;
        #(5*T);
        WE = 1; RE = 0; WD = 51; A = 20;
        #(5*T);
        WE = 1; RE = 0; WD = 52; A = 30;
        #(5*T);

        WE = 0; RE = 1; WD = 0; A = 10;
        #(5*T);
        WE = 0; RE = 1; WD = 0; A = 20;
        #(5*T);
        WE = 1; RE = 0; WD = 51; A = 30;
        #(5*T);
        WE = 0; RE = 1; WD = 0; A = 10;
        #(10*T);

    end
endmodule