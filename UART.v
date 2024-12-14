`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: UART
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

module UART(
    input Clk,
    input RX,
    input Load,
    input [4:0] PC,
    output [7:0] data_out,
//    output [7:0] test,
    output FE
//    output Clk_out
    );
    parameter UBRR = 10415;
    wire [7:0] memory[31:0];
    assign memory[0]  = 8'b11111110;
    assign memory[1]  = 8'b00000000;
    assign memory[2]  = 8'b00000000;
    assign memory[3]  = 8'b10111010;
    assign memory[4]  = 8'b00100000;
    assign memory[5]  = 8'b00000000;
    assign memory[6]  = 8'b10111011;
    assign memory[7]  = 8'b00100000;
    assign memory[8]  = 8'b11101010;
    assign memory[9]  = 8'b00000000;
    assign memory[10] = 8'b11011100;
    assign memory[11] = 8'b10111010;
    assign memory[12] = 8'b11011100;
    assign memory[13] = 8'b10111100;
    assign memory[14] = 8'b00100000;
    assign memory[15] = 8'b00000000;
    assign memory[16] = 8'b10011011;
    assign memory[17] = 8'b00100000;
    assign memory[18] = 8'b11110100;
    assign memory[19] = 8'b00000000;
    assign memory[20] = 8'b10011011;
    assign memory[21] = 8'b00100000;
    assign memory[22] = 8'b00000000;
    assign memory[23] = 8'b00000000;
    assign memory[24] = 8'b11100000;
    assign memory[30] = 8'b11100011;
    assign memory[31] = 8'b00000000;
    assign data_out = memory[PC];

endmodule
