`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 10:25:43 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ADDER(
    input [7:0] inA,
    input [7:0] inB,
    output [7:0] total
    );
    Adder_8bit ADD(inA, inB, 1'b0, total, );
endmodule

module Adder_8bit(input [7:0] A, B, input Cin, output [7:0] S, output Cout);
  wire Cout1;
  Adder_4bit ADD1 (A[3:0], B[3:0], Cin, S[3:0], Cout1);
  Adder_4bit ADD2 (A[7:4], B[7:4], Cout1, S[7:4], Cout);
endmodule

module Adder_4bit(input [3:0] A, B, input C0, output [3:0] S, output C4);
  wire C1, C2, C3;
  Full_adder FA0 (S[0], C1, A[0], B[0], C0);
  Full_adder FA1 (S[1], C2, A[1], B[1], C1);
  Full_adder FA2 (S[2], C3, A[2], B[2], C2);
  Full_adder FA3 (S[3], C4, A[3], B[3], C3);
endmodule

module Full_adder(output S, C1, input A, B, C0);
  wire w1, w2, w3;

  Half_Adder HA1 (w1, w2, A, B);
  Half_Adder HA2 (S, w3, w1, C0);

  // Directly use the OR operation for C1
  assign C1 = w2 | w3;
endmodule

module Half_Adder(output S, C, input A, B);
  xor G1 (S, A, B);
  and G2 (C, A, B);
endmodule