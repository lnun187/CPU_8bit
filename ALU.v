`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Khoa
// 
// Create Date: 11/25/2024 10:25:43 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [7:0] inA,
    input [7:0] inB,
    input [2:0] ALU_OP,
    output [7:0] result,
    output SKZ_cmp
    );
    reg [7:0] ALU_result;
    reg SKZ_source;
    wire [7:0] adder_result;
    
    assign result = ALU_result;
    assign SKZ_cmp = SKZ_source;
    ADDER full_adder(inA, inB, adder_result);
    
    always @(*)
    begin
        case(ALU_OP)
        3'b110: // STO 
            ALU_result = inA;
        3'b101: // LDA
            ALU_result = inB;
        3'b011: // AND
            ALU_result = inA & inB;
        3'b100: // XOR
            ALU_result = inA ^ inB;
        3'b010: // ADD
            ALU_result = adder_result;
        default:
            ALU_result = inA;
        endcase
        
        case (ALU_OP)
            3'b000, 3'b001, 3'b110, 3'b111: // NOR all bits
                SKZ_source = ~(inA[7] | inA[6] | inA[5] | inA[4] |
                               inA[3] | inA[2] | inA[1] | inA[0]);
            default: // NOR all bits
                SKZ_source = ~(ALU_result[7] | ALU_result[6] | ALU_result[5] | ALU_result[4] |
                               ALU_result[3] | ALU_result[2] | ALU_result[1] | ALU_result[0]);
                
        endcase
        
    end
    
endmodule
