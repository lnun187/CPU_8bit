`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 09:46:14 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input Clk,
    input Reset,
    input En,
    input [7:0] data_in,
    output [7:0] data_out
    );
    reg [7:0] data;
    assign data_out = data;
    always @(posedge Clk, posedge Reset) begin
        if(Reset) data <= 8'd0;
        else if(En) data <= data_in;
    end
endmodule
