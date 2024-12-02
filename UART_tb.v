`timescale 1ns / 1ps

module UART_tb;

    // Testbench Signals
    reg Clk;
    reg RX;
    reg Load;
    wire [255:0] memory_ins;
    wire FE;
    wire [12:0]in;
    // Instantiate UART module
    UART #(.Baudrate(24)) uut (
        .Clk(Clk),
        .RX(RX),
        .Load(Load),
        .memory_ins(memory_ins),
        .FE(FE),
        .index(in)
    );

    // Clock generation (25MHz clock -> 40ns period)
    initial begin
        Clk = 0;
        forever #2 Clk = ~Clk; // 20ns clock period
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
        RX = 1; // Idle state (UART line high)
        Load = 0;

        // Wait for system to stabilize
        #12;

        // Apply Load signal (reset)
        Load = 1;

        // Wait for system ready
        #2;

        // Send valid bytes
        send_uart_byte(8'h55); // Send 0x55 (binary: 01010101)
        send_uart_byte(8'hA3); // Send 0xA3 (binary: 10100011)
        send_uart_byte(8'hFF); // Send 0xFF (binary: 11111111)
        send_uart_byte(8'h00); // Send 0x00 (binary: 00000000)

        // Wait for processing
        #200000;

        // Display results
        $display("Memory contents: %h", memory_ins);
        $display("Frame Error (FE): %b", FE);

        // End simulation
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time = %0dns | RX = %b | Load = %b | FE = %b | memory_ins = %h",
                 $time, RX, Load, FE, memory_ins);
    end

endmodule
