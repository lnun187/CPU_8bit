`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 11:35:54 AM
// Design Name: 
// Module Name: ControlUnit_testbench
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


`timescale 1ns / 1ps

module tb_Control_Unit;

    // Inputs
    reg Clk;
    reg Reset;
    reg En;
    reg [2:0] Opcode;

    // Outputs
    wire En_write_reg;
    wire En_write_mem;
    wire [2:0] ALU_OP;

    // Instantiate the module
    // Unit under test
    Control_Unit uut (
        .Clk(Clk),
        .Reset(Reset),
        .En(En),
        .Opcode(Opcode),
        .En_write_reg(En_write_reg),
        .En_write_mem(En_write_mem),
        .ALU_OP(ALU_OP)
    );

    // Clock generation (50MHz)
    always #10 Clk = ~Clk; // Clock period = 20ns (50MHz)

    // Testbench logic
    initial 
    begin
        // Initialize inputs
        Clk = 0;
        Reset = 0;
        En = 0;
        Opcode = 3'b000;

        // Apply Reset
        #5 Reset = 1; // Activate Reset
        #20 Reset = 0; // Deactivate Reset

        // Test case 1: Opcode = 100, En = 1 => reg = 0, mem = 1
        #10 Opcode = 3'b100; En = 1;
        #20;

        // Test case 2: Opcode = 010, En = 1 => reg = 0, mem = 1
        Opcode = 3'b010;
        #20;

        // Test case 3: Opcode = 101, En = 1 => reg = 0, mem = 1
        Opcode = 3'b101;
        #20;

        
        // Test case 4: Opcode = 110, En = 1 => reg = 1, mem = 0
        Opcode = 3'b110;
        #20; 
        
        
        // Test case 5: Opcode = 011, En = 1 => reg = 0, mem = 1
        Opcode = 3'b011;
        #5;
        
        // Test case 6: Disable Enable (En = 0)
        // next immediate clk: outputs' value didnt change 
        En = 0;
        #15
        Opcode = 3'b100;
        #20;
        
        // Test case 7: Enable again (En = 1)
        // next immediate clk: outputs' value changed
        En = 1;
        Opcode = 3'b101;
        #20;

        // Apply Reset again
        #20
        Reset = 1;
        #20 Reset = 0;

        // Finish simulation
        #50;
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time = %0dns | Reset = %b | En = %b | Opcode = %b | En_write_reg = %b | En_write_mem = %b | ALU_OP = %b", 
                 $time, Reset, En, Opcode, En_write_reg, En_write_mem, ALU_OP);
    end

endmodule

