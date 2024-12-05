`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 09:11:11 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
    input Clk,
    input Load,
    input RX,
    input Reset,
    output FE,
    output [7:0] Instruction,
    output [7:0] Data_mem
    );
    wire [7:0] Ins;
    wire [4:0] Program_counter;
    reg [4:0] PC;
//    wire [4:0] PC_next;
    reg En_run;
    wire [4:0] addr;
    reg [4:0] Address;
    reg [7:0] Accumulator;
    wire [7:0] Data_in;
    wire [7:0] Data_out;
    wire En_mem;
    wire En_acc;
    wire En_cpu;
    wire [2:0] Opcode;
    wire jmp_or_not;
    wire SKZ_cmp;
    wire tmp_a;
    wire tmp_b;
    wire tmp_c;
    wire tmp_d;
    wire [4:0] pc_jmp;
    wire En_write_reg;
    wire En_write_mem;
    wire [2:0] ALU_OP;
    wire tmp_e;
    wire tmp_f;
    wire [7:0] result;
    // use uart to receive instruction data
     UART a(
       .Clk(Clk),
       .RX(RX),
       .Load(Load),
       .PC(Program_counter),
       .data_out(Ins),
       .FE(FE)
   );
    //every time Clk rise edge, opcode and address change according to Program_counter
   Instruction_Memory b(
       .Clk(Clk),
       .Reset(Reset),
       .mem_ins(Ins),
       .Opcode(Opcode),
       .Address(addr));
   
   //Chose what pc next in case JMP or SKZ
//   xnor (tmp_a, Opcode, 3'b111);
//   xnor (tmp_b, Opcode, 3'b001);
//   and  (tmp_c, tmp_b, SKZ_cmp);
//   or   (jmp_or_not, tmp_a, tmp_c);
   assign pc_jmp = &(Opcode ~^ 3'b111) || (&(Opcode ~^ 3'b001) && SKZ_cmp) ? Address : (PC + 5'd1);
   
   //Choose what pc next in case Load
   assign Program_counter = ~Load && pc_jmp;
   
   //When HLT or Load then disable
//   xnor (tmp_d, Opcode, 3'b000);
   assign En_cpu = ~Load && | Opcode;
   
   //Program counter and Address
   always @(posedge Clk, posedge Reset) begin
        if(Reset) begin
            PC <= 5'd0;
            Address <= 5'd0;
        end
        else if(En_cpu) begin
            PC <= Program_counter;
            Address <= addr; 
        end
   end
   
   //En_run
   always @(posedge Clk, posedge Reset) begin
        if(Reset) En_run <= 1'b0;
        else En_run <= En_cpu;
   end
   
   //Control unit
   Control_Unit c(
       .Clk(Clk),
       .Reset(Reset),
       .En(En_cpu),
       .Opcode(Opcode),
       .En_write_reg(En_write_reg),
       .En_write_mem(En_write_mem),
       .ALU_OP(ALU_OP)
       );
       
   //When HLT disable Accumulator and Data_Memory after one cycle
//   and  (tmp_e, En_run, En_write_reg);
//   and  (tmp_f, En_run, En_write_mem);
   assign En_acc = ~Load && En_write_reg && En_run;
   assign En_mem = ~Load && En_write_mem && En_run;
   
   //Accumulator
   always @(posedge Clk, posedge Reset) begin
        if(Reset) Accumulator <= 5'd0;
        else if(En_acc) Accumulator <= result;
   end
   
   //Data memory
   Data_Memory d(
       .Clk(Clk),
       .Reset(Reset),
       .Data_in(result),
       .En(En_mem),
       .Address(Address),
       .Data_out(Data_out)
       );
       
   //ALU
   ALU e(
       .inA(Accumulator),
       .inB(Data_out),
       .ALU_OP(ALU_OP),
       .result(result),
       .SKZ_cmp(SKZ_cmp)
       );
endmodule
