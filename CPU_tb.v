`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 06:06:44 PM
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb;
    // Testbench Signals
    reg Clk;
    reg RX;
    reg Load;
    reg Reset;
    wire FE;
    wire [7:0] Instruction;
    wire [7:0] Acc;
    wire [7:0] Mem;
    wire [4:0] Program_counter;
    // Instantiate CPU module
CPU #(.Baudrate(24)) uut(
    .Clk(Clk),
    .Load(Load),
    .RX(RX),
    .Reset1(Reset),
    .FE(FE),
    .Instruction(Instruction),
    .Acc(Acc),
    .Mem(Mem),
    .Program_counter(Program_counter)
    );
    // Clock generation (250MHz clock -> 4ns period)
    initial begin
        Clk = 0;
        forever #2 Clk = ~Clk; // 4ns clock period
    end

    // Task to send a byte via UART
    task send_uart_byte;
        input [7:0] data;
        integer i;
        begin
            // Start bit (low)
            RX = 0;
            #(24 * 4); // Baudrate duration
            
            // Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                RX = data[i];
                #(24 * 4); // Baudrate duration
            end
            
            // Stop bit (high)
            RX = 1;
            #(24 * 4); // Baudrate duration
        end
    endtask

    // Test Sequence
    initial begin
        // Initialize signals
        Reset = 0;
        Load = 0;
        #10 Reset = 1;
        RX = 1; // Idle state (UART line high)

        // Wait for system to stabilize
        #12;

        // Apply Load signal (reset)
        Reset = 0;
        // Wait for system ready
        #20
        Load = 1;
        #8
        Load = 0;
        // Wait for processing
        #20;
        // Display results
        $display("Instruction contents: %h", Instruction);
        $display("Accumulator contents: %h", Acc);
        $display("Memory[address] contents: %h", Mem);
        $display("Frame Error (FE): %b", FE);

        // End simulation
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time = %0dns | RX = %b | Load = %b | Instruction = %b | FE = %b | Accumulator = %h | Memory[address] = %h",
                 $time, RX, Load, Instruction, FE, Acc, Mem);
    end

endmodule
