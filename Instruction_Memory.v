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
    input [4:0] Program_counter,
    input [255:0] mem_ins,
    output reg [2:0] Opcode,
    output reg [4:0] Address
    );
    reg [2:0] opcode_next;
    reg [4:0] address_next;

    always @(*) begin
        opcode_next = mem_ins[Program_counter * 8 +: 3];
        address_next = mem_ins[Program_counter * 8 + 3 +: 5];
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
