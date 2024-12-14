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
    wire [7:0] memory [31:0];
    
    assign Data_out = memory[Address];
    generate
        genvar i;
        for(i = 0; i < 32; i = i + 1) begin: dataGen
            data_mem u(
                .Clk(Clk),
                .Reset(Reset),
                .Reset_value((i == 8'h00) ? 8'h00 :8'h00 
                           | (i == 8'h01 ? 8'h04: 8'h00)
                           | (i == 8'h02 ? 8'h02: 8'h00)
                           | (i == 8'h03 ? 8'h03: 8'h00)
                           | (i == 8'h04 ? 8'hFF: 8'h00)
                           | (i == 8'h05 ? 8'hFF: 8'h00)), 
                .En(Address == i && En),
                .data_in(Data_in),
                .data_out(memory[i])
                );
        end
    endgenerate
    
endmodule
