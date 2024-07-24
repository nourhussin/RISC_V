module Instruction_Memory#(parameter depth = 256, width = 32)(
    // 8 Kb memory , if we want increase the size, increase the depth
    input wire[$clog2(depth)-1 : 0] A,

    output wire[width-1 : 0] RD
    );

    reg [width-1 : 0] memory [depth-1 : 0];

    assign RD = memory[A];
    // Upload the program code here
     
    initial begin
        memory[0] = 32'h00500113;	//addi x2 x0 5	 x2 = 5                     0           00500113
        memory[1] = 32'h00c00193;	//addi x3 x0 12	 x3 = 12                    4           00C00193
        memory[2] = 32'hff718393;	//addi x7 x3 -9	 x7 = (12 - 9) = 3          8           FF718393
        memory[3] = 32'h0023e233;	//or x4 x7 x2	 x4 = (3 OR 5) = 7          C           0023E233
        memory[4] = 32'h0041f2b3;	//and x5 x3 x4	 x5 = (12 AND 7) = 4        10          0041F2B3
        memory[5] = 32'h004282b3;	//add x5 x5 x4	 x5 = 4 + 7 = 11            14          004282B3
        memory[6] = 32'h02728863;	//beq x5 x7 48	 shouldn't be taken         18          02728863
        memory[7] = 32'h0041a233;	//slt x4 x3 x4	 x4 = (12 < 7) = 0          1C          0041A233
        memory[8] = 32'h00020463;	//beq x4 x0 8	 should be taken            20          00020463
        memory[9] = 32'h00000293;	//addi x5 x0 0	 shouldn't execute          24          00000293
        memory[10] = 32'h0023a233;	//slt x4 x7 x2	 x4 = (3 < 5) = 1           28          0023A233
        memory[11] = 32'h005203b3;	//add x7 x4 x5	 x7 = (1 + 11) = 12         2C          005203B3
        memory[12] = 32'h402383b3;	//sub x7 x7 x2	 x7 = (12 - 5) = 7          30          402383B3
        memory[13] = 32'h0471aa23;	//sw x7 84(x3)	 [96] = 7                   34          0471AA23
        memory[14] = 32'h06002103;	//lw x2 96(x0)	 x2 = [96] = 7              38          06002103
        memory[15] = 32'h005104b3;	//add x9 x2 x5	 x9 = (7 + 11) = 18         3C          005104B3
        memory[16] = 32'h008001ef;	//jal x3 8	     x3 = 0x44                  40          008001EF
        memory[17] = 32'h00100113;	//addi x2 x0 1	 shouldn't execute          44          00100113
        memory[18] = 32'h00910133;	//add x2 x2 x9	 x2 = (7 + 18) = 25         48          00910133
        memory[19] = 32'h0221a023;	//sw x2 32(x3)	 [100] = 25                 4C          0221A023
        memory[20] = 32'h00210063;	//beq x2 x2 0	 infinite loop              50          00210063
    /*
    memory[0]  = 32'h00500113;  // addi x2, x0, 5     x2 = 5                     0x00000000
    memory[1]  = 32'h00c00193;  // addi x3, x0, 12    x3 = 12                    0x00000004
    memory[2]  = 32'hff718393;  // addi x7, x3, -9    x7 = (12 - 9) = 3          0x00000008
    memory[3]  = 32'h0023e233;  // or x4, x7, x2      x4 = (3 OR 5) = 7          0x0000000C
    memory[4]  = 32'h0041f2b3;  // and x5, x3, x4     x5 = (12 AND 7) = 4        0x00000010
    memory[5]  = 32'h004282b3;  // add x5, x5, x4     x5 = 4 + 7 = 11            0x00000014
    memory[6]  = 32'h02728463;  // beq x5, x7, end    shouldn't be taken         0x00000018
    memory[7]  = 32'h00020463;  // beq x4, x0, around shouldn’t be taken         0x0000001C
    memory[8]  = 32'h00000293;  // addi x5, x0, 0     x5 = 0 + 0 = 0             0x00000020
    memory[9]  = 32'h005203b3;  // add x7, x4, x5     x7 = (7 + 0) = 7           0x00000024
    memory[10] = 32'h402383b3;  // sub x7, x7, x2     x7 = (7 - 5) = 2           0x00000028
    memory[11] = 32'h0471aa23;  // sw x7, 84(x3)      [96] = 2                   0x0000002C (testcase1)
    memory[12] = 32'h06002103;  // lw x2, 96(x0)      x2 = [96] = 2              0x00000030
    memory[13] = 32'h005104b3;  // add x9, x2, x5     x9 = (2 + 0) = 2           0x00000034
    memory[14] = 32'h008001ef;  // jal x3, end        jump to end, x3 = 0x3C     0x00000038
    memory[15] = 32'h00100113;  // addi x2, x0, 1     shouldn't execute          0x0000003C
    memory[16] = 32'h00910133;  // add x2, x2, x9     x2 = (2 + 2) = 4           0x00000040
    memory[17] = 32'h0221a023;  // sw x2, 0x20(x3)    [92] = 4                   0x00000044 (testcase2)
    memory[18] = 32'h00210063;  // beq x2, x2, done   infinite loop              0x00000048
       
    memory[0] = 32'h00100020;  // addi x1,x0,10
    memory[1] = 32'h00500113;  // addi x2,x0,5
    memory[2] = 32'h01000033 ; // add x3,x1,x2
    memory[3] = 32'h01400033 ; // sub x3,x1,x2 
    memory[4] = 32'h01100033 ; // and x3,x1,x2
    memory[5] = 32'h01300033 ; // or x3,x1,x2
    memory[6] = 32'h30100022 ; // andi x2,x1, 'b1010
    memory[7] = 32'h30500022 ; // ori x2,x1, 'b0100  
    memory[8] = 32'h00a20023 ; // sw x2,0(x1)
    memory[9] = 32'h00820022 ; // lw x2,0(x1)
    memory[10] = 32'h000000ef ; // jalr x0,x1,0 
    */
    end
endmodule