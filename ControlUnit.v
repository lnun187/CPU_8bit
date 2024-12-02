`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 11:24:24 AM
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
    
     // Internal wires for combinational logic
    wire write_reg_next;
    wire write_mem_next;
    wire [2:0] ALU_op_next;

    // Combinational logic for next state
    assign ALU_op_next = Opcode;
    assign write_reg_next = (Opcode == 3'b110)? 1 : 0;
    assign write_mem_next = (Opcode == 3'b010) || (Opcode == 3'b011) || (Opcode == 3'b100) || (Opcode == 3'b101)? 1 : 0;

    // Sequential logic for ALU_OP
    always @(posedge Clk or posedge Reset) begin
        if (Reset) 
            ALU_OP <= 3'b000; // Reset ALU_OP to default
        else if (En) begin
            ALU_OP <= ALU_op_next;
        end 
     end

    // Sequential logic for En_write_mem
    always @(posedge Clk or posedge Reset) begin
        if (Reset) 
            En_write_reg <= 1'b0; // Reset En_write_reg to default
        else if (En) begin
            En_write_reg <= write_reg_next;
        end
    end
    
    // Sequential logic for En_write_mem
    always @(posedge Clk or posedge Reset) begin
        if (Reset) 
            En_write_mem <= 1'b0; // Reset En_write_mem to default
        else if (En) begin
            En_write_mem <= write_mem_next;
        end
    end
endmodule
