`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_memory(
    input Clk,
    input [7:0] Data_in,
    input En,
    input [4:0] Address,
    output [7:0] Data_out
);

    reg [7:0] memory [0:31];
    assign Data_out = memory[Address];
    
    // Ghi khi en active + clock lên
    always @(posedge Clk) begin
        if (En) begin
            memory[Address] <= Data_in;
        end
    end
endmodule
