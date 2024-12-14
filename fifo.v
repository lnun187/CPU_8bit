`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 04:46:20 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input CPU_Clk,
    input Reset,
    input [7:0] data_in,
    input WR,
    input [4:0] PC,
    output [7:0] data_out,
    output full,
    output empty
    );
    parameter LENGTH = 32;
    reg [$clog2(LENGTH) - 1 : 0] wr_ptr;
    reg [$clog2(LENGTH) - 1 : 0] wr_ptr_next;
    wire [7:0] memory [LENGTH - 1:0];
    assign full = &wr_ptr;
    assign empty = |wr_ptr;
    assign data_out = memory[PC];
    always @(*) begin
        wr_ptr_next = wr_ptr + 1'b1;
    end
    generate
        genvar i;
        for(i = 0; i < 32; i = i + 1) begin: insGen
            data_mem u(
                .Clk(CPU_Clk),
                .Reset(Reset),
                .Reset_value(0),
                .En(wr_ptr == i && WR && !full),
                .data_in(data_in),
                .data_out(memory[i])
                );
        end
    endgenerate
    always @(posedge CPU_Clk, posedge Reset) begin
        if(Reset) begin
            wr_ptr <= 5'd0;
        end else if(WR && !full) begin
            wr_ptr <= wr_ptr_next;
        end
    end
endmodule
