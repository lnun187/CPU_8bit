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
    assign memory[0] = 8'hA0;
    assign memory[1] = 8'h41;
    assign memory[2] = 8'h62;
    assign memory[3] = 8'h83;
    assign memory[4] = 8'h00;
    assign data_out = memory[PC];

endmodule
