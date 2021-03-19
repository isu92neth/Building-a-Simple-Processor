/* CO224 Lab - 05 Part 4*/
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for CPU */

`include "alu.v"
`include "control_unit.v"
`include "reg_file.v"
`include "mux_2x1.v"
`include "twos_com.v"
`include "pc_adder.v"
`include "adder.v"
`include "left_shift.v"
`include "adder_signed.v"


module cpu(PC,INSTRUCTION,CLK,RESET);

input [31:0] INSTRUCTION;  /* 32 bit instruction */
input CLK,RESET;    /* Control inputs */
output  [31:0] PC;   /* Output next 32 bit PC value */

wire [31:0] nextpc; /* To get the next PC value */

wire [7:0] OPCODE,SOURCE1,SOURCE2,IMMEDIATE;
wire [2:0] READREG2,READREG1,WRITEREG,ALUOP;
wire WRITEENABLE,LOADI_signal,SUB_signal,J_signal,BEQ_signal;
wire signed [7:0] DESTINATION;
wire [7:0] ALURESULT;     
wire [7:0] REGOUT1, REGOUT2; 
wire [7:0] REGOUT2_com2s;
wire [7:0] mux_sub_out;
wire [7:0] mux_loadi_out;
wire ZERO;

/* Instantiating pc_adder module to get PC Update */ 
pc_adder  get_next_pc(PC,nextpc, CLK,RESET,BEQ_signal,J_signal,DESTINATION,ZERO);
/* Write the next PC value to PC */
assign PC = nextpc;

/* Instantiating control_unit module to Decode the Instruction */
control_unit  cu(INSTRUCTION,OPCODE,SOURCE1,SOURCE2,DESTINATION,READREG2,READREG1,WRITEREG,IMMEDIATE,ALUOP,WRITEENABLE,LOADI_signal,SUB_signal,J_signal,BEQ_signal);

/* Instantiating reg_file module to read and write registers */
reg_file  register(ALURESULT, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);

/* Instantiating twos_com module to get 2s complement value of a number */
twos_com com_2s(REGOUT2,REGOUT2_com2s);

/* Instantiating mux_2x1 module to forward 2s complement value of a number for sub instruction */
mux_2x1 mux_sub(REGOUT2,REGOUT2_com2s,SUB_signal,mux_sub_out);

/* Instantiating mux_2x1 module to forward immediate value for loadi instruction */
mux_2x1 mux_loadi(mux_sub_out,IMMEDIATE,LOADI_signal,mux_loadi_out);

/* Instantiating alu module to get the ALURESULT */
alu  myalu(REGOUT1, mux_loadi_out, ALURESULT, ALUOP,ZERO);

endmodule