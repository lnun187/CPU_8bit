`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: UART
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

module UART(
    input Clk,
    input RX,
    input Load,
    output reg [255:0] memory_ins,
    output FE,
    output [12:0] index
    );
    parameter Baudrate = 2603;
    wire    [12:0] count_clk_next;
    reg     [12:0] count_clk;
    wire    Reset;
    reg     [3:0] i;
    wire    [3:0] i_next;
    reg     [9:0] buffer;
    reg    [9:0] buffer_next;
    wire    tmp_a;
    wire    En_1;
    wire    En_2;
    reg     [4:0] address;
    wire    [4:0] address_next;
    reg     [255:0] memory_ins_next;
    
    assign index = i;
    
    posedge_detection a(
            .CPU_Clk(Clk),
            .signal_in(Load),
            .signal_out(Reset)
            );
    assign FE = (i == 4'd9) & ~RX;
    //count_clk        
    assign count_clk_next = (count_clk == Baudrate) ? 13'd0 : (count_clk + 13'd1);
    always @(posedge Clk, posedge Reset) begin
        if(Reset) count_clk <= 13'd0;
        else count_clk <= count_clk_next;
    end
    
    //buffer and i
    assign i_next = (~RX & i == 4'd0) ? 4'd1 : ((i == 4'd9) ? 4'd0 : (i + 4'd1));
    assign En_1 = Load & (count_clk == Baudrate);
    
    always @(*) begin
        buffer_next = buffer;
        buffer_next[i] = RX;
    end
    always @(posedge Clk, posedge Reset) begin
        if(Reset) begin
            buffer <= 10'd0;
            i <= 4'd0;
        end else if(En_1) begin
            buffer <= buffer_next;
            i <= i_next;
        end
    end
    
    //Insmem and address
    assign En_2 = RX & (i == 4'd9);
    assign address_next = address + 5'd1;
    always @(*) begin
        memory_ins_next = memory_ins;
        memory_ins_next[address*8 +: 8] = buffer[8:1];
    end
    always @(posedge Clk, posedge Reset) begin
        if(Reset) begin
            address <= 4'd0;
            memory_ins <= 256'd0;
        end else if(En_2) begin
            address <= address_next;
            memory_ins <= memory_ins_next;
        end
    end
endmodule
