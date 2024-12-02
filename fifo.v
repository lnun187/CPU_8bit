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
    input RD,
    input PC,
    output [7:0] data_out,
    output full,
    output empty
    );
    parameter LENGTH = 32;
    reg [4:0] wr_ptr;
    reg [4:0] wr_ptr_next;
//    reg [4:0] rd_ptr;
//    reg [4:0] rd_ptr_next;
    reg [7:0] memory [LENGTH - 1:0];
    assign full = wr_ptr == LENGTH - 1 ? 1'b1 : 1'b0;
    assign empty = wr_ptr == 5'd0 ? 5'd1 : 1'b0;
    assign data_out = memory[PC];
//    assign data_out = wr_ptr;   
    always @(*) begin
        wr_ptr_next = wr_ptr + 5'd1;
//        rd_ptr_next = rd_ptr + 5'd1;
//        rd_ptr_next = wr_ptr - 1'b1;
    end
    always @(posedge CPU_Clk, posedge Reset) begin
        if(Reset) begin
            wr_ptr <= 5'd0;
        end else if(WR && !full) begin
            wr_ptr <= wr_ptr_next;
            memory[wr_ptr] <= data_in;
        end
    end
//    always @(posedge CPU_Clk, posedge Reset) begin
//        if(Reset) begin
//            rd_ptr <= 5'd0;
//        end else if(RD && !empty) begin
//            rd_ptr <= rd_ptr_next;
////            data_out <= memory[rd_ptr];
//        end
//    end
endmodule
