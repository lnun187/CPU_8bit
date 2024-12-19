`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input Clk,
    input Reset,
    input [4:0] PC,
    output reg [2:0] Opcode,
    output reg [4:0] Address
    );
    reg [2:0] opcode_next;
    reg [4:0] address_next;
    wire [7:0] memory[31:0];
    wire [7:0] mem_ins;
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
    assign mem_ins = memory[PC];
    always @(*) begin
        opcode_next = mem_ins[7:5];
        address_next = mem_ins[4:0];
    end

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            Opcode <= 3'b0;      
            Address <= 5'b0;    
        end else begin
            Opcode <= opcode_next;
            Address <= address_next;
        end
    end
endmodule
