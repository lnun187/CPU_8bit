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


module Data_Memory(
    input Clk,
    input Reset,
    input [7:0] Data_in,
    input En,
    input [4:0] Address,
    output [7:0] Data_out
);
    integer i;
    reg [7:0] memory [31:0];
    assign Data_out = memory[Address];
//    reg [7:0] memory_next [31:0];
    
    // Ghi khi en active + clock lên
    always @(posedge Clk, posedge Reset) begin
        if(Reset) 
            for(i = 0; i < 32; i = i + 1) begin
                memory[i] <= 8'd0;
            end
        else if (En) begin
            memory[Address] <= Data_in;
        end
    end
endmodule
