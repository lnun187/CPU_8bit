`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input Clk,
    input Reset,
    input En,
    input [2:0] Opcode,
    output reg En_write_reg,
    output reg En_write_mem,
    output reg [2:0] ALU_OP
    );
    
    wire write_reg_next = (Opcode == 3'b010 || Opcode == 3'b011 || Opcode == 3'b100 || Opcode == 3'b101);
    wire write_mem_next = (Opcode == 3'b110);
    
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            En_write_reg <= 1'b0;
            En_write_mem <= 1'b0;
            ALU_OP <= 3'b000;
        end else if (En) begin
            En_write_reg <= write_reg_next;
            En_write_mem <= write_mem_next;
            ALU_OP <= Opcode;
        end
    end
endmodule
