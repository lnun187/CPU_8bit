`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2024 09:14:33 PM
// Design Name: 
// Module Name: edge_detection
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


module posedge_detection(
    input CPU_Clk,
    input signal_in,
    output reg signal_out
    );
    reg signal_in_next;
    always @(*) begin
        signal_out = signal_in && ~signal_in_next;
    end
    always @(posedge CPU_Clk) begin
        signal_in_next <= signal_in;
    end
endmodule
