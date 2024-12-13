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
    .Reset(Reset),
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
        Reset = 1;
        RX = 1; // Idle state (UART line high)
        Load = 0;

        // Wait for system to stabilize
        #12;

        // Apply Load signal (reset)
        Load = 1;
        Reset = 0;
        // Wait for system ready
        #4;

        // Send valid bytes
    send_uart_byte(8'b111_11110);     //  00   BEGIN:   JMP TST_JMP
    send_uart_byte(8'b000_00000);     //  01            HLT        
    send_uart_byte(8'b000_00000);     //  02            HLT       
    send_uart_byte(8'b101_11010);     //  03   JMP_OK:  LDA DATA_1
    send_uart_byte(8'b001_00000);     //  04            SKZ
    send_uart_byte(8'b000_00000);     //  05            HLT        
    send_uart_byte(8'b101_11011);     //  06            LDA DATA_2
    send_uart_byte(8'b001_00000);     //  07            SKZ
    send_uart_byte(8'b111_01010);     //  08            JMP SKZ_OK
    send_uart_byte(8'b000_00000);     //  09            HLT        
    send_uart_byte(8'b110_11100);     //  0A   SKZ_OK:  STO TEMP   
    send_uart_byte(8'b101_11010);     //  0B            LDA DATA_1
    send_uart_byte(8'b110_11100);     //  0C            STO TEMP   
    send_uart_byte(8'b101_11100);     //  0D            LDA TEMP
    send_uart_byte(8'b001_00000);     //  0E            SKZ        
    send_uart_byte(8'b000_00000);     //  0F            HLT        
    send_uart_byte(8'b100_11011);     //  10            XOR DATA_2
    send_uart_byte(8'b001_00000);     //  11            SKZ        
    send_uart_byte(8'b111_10100);     //  12            JMP XOR_OK
    send_uart_byte(8'b000_00000);     //  13            HLT        
    send_uart_byte(8'b100_11011);     //  14   XOR_OK:  XOR DATA_2
    send_uart_byte(8'b001_00000);     //  15            SKZ
    send_uart_byte(8'b000_00000);     //  16            HLT        
    send_uart_byte(8'b000_00000);     //  17   END:     HLT        
    send_uart_byte(8'b111_00000);     //  18            JMP BEGIN  
    send_uart_byte(8'b000_00000);     //  19            HLT
    send_uart_byte(8'b000_00000);     //  1A            HLT
    send_uart_byte(8'b000_00000);     //  1B            HLT
    send_uart_byte(8'b000_00000);     //  1C            HLT
    send_uart_byte(8'b000_00000);     //  1D            HLT
    send_uart_byte(8'b111_00011);     //  1E   TST_JMP: JMP JMP_OK
    send_uart_byte(8'b000_00000);     //  1F            HLT
        
        #4 Load = 0;
        // Wait for processing
        #200;
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
