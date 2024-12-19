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
    

endmodule
