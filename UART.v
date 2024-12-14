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
    input [4:0] PC,
    output [7:0] data_out,
//    output [7:0] test,
    output FE
//    output Clk_out
    );
    parameter UBRR = 10415;
    wire [7:0] memory[31:0];
    assign memory[0] = 8'h45;
    assign memory[1] = 8'h35;
    assign memory[2] = 8'h00;
    assign data_out = memory[PC];
//    wire    [15:0] count_clk_next;
//    reg     [15:0] count_clk;
//    wire    Reset;
//    reg     [3:0] i;
//    wire    [3:0] i_next;
//    reg     [9:0] buffer;
//    reg    [9:0] buffer_next;
//    wire    tmp_a;
//    wire    En_1;
////    wire [7:0] data_out;
//    wire    En_2;
//    reg     [4:0] address;
//    wire    [4:0] address_next;
//    reg     [7:0] memory_ins[31:0];
//    reg     [7:0] memory_ins_next [31:0];
    
//    posedge_detection a(
//        .CPU_Clk(Clk),
//        .signal_in(Load),
//        .signal_out(Reset)
//    );

//    assign FE = (i == 4'd9) & ~RX;
////assign FE = t;
//assign test = buffer[8:1];
//assign Clk_out = Clk;
//    //count_clk        
//    assign count_clk_next = (count_clk == UBRR - 1'b1) ? 13'd0 : (count_clk + 13'd1);
//    always @(posedge Clk, posedge Reset) begin
//        if(Reset) count_clk <= 13'd0;
//        else count_clk <= count_clk_next;
//    end
//    reg t;
//    always@ (posedge Clk, posedge Reset) begin
//        if(Reset) t <= 0;
//        else if(count_clk == UBRR - 1'b1) t <= ~t;
//    end
//    //buffer and i
//    assign i_next = (i == 4'd9) ? 4'd0 : ((RX & i == 4'd0) ? 4'd0 : (i + 4'd1));
//    assign En_1 = Load & (count_clk == UBRR - 1'b1);
    
//    always @(*) begin
//        buffer_next = buffer;
//        buffer_next[i] = RX;
//    end
//    always @(posedge Clk, posedge Reset) begin
//        if(Reset) begin
//            buffer <= 10'd0;
//            i <= 4'd0;
//        end else if(En_1) begin
//            buffer <= buffer_next;
//            i <= i_next;
//        end
//    end
    
//    //Insmem and address
//    assign En_2 = RX & (i == 4'd9) & (count_clk == UBRR - 1'b1);
//        fifo #(.LENGTH(32)) b(
//        .CPU_Clk(Clk),
//        .Reset(Reset),
//        .data_in(buffer[8:1]),
//        .WR(En_2),
//        .PC(PC),
//        .data_out(data_out),
//        .full(),
//        .empty()
//    );
//    assign data_out = buffer[8:1];
endmodule
