/* CO224 Lab - 05 Part 4*/
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module to increment PC */

module pc_adder(current_pc,next_pc,CLK,RESET,BEQ_signal,J_signal,IMMEDIATE,ZERO);

input [31:0] current_pc;  /* Current program counter value */
input CLK,RESET,BEQ_signal,ZERO,J_signal;   /* Control inputs */
output  reg [31:0] next_pc;   /* Next program counter value */

/* result: 32 bit wire to get the result of the adder */
/* result_J_BEQ: 32 bit wire to get the result of the signed adder */
wire [31:0] result,result_J_BEQ;

/* offset_32: 32 bit offset value */
wire signed [31:0] offset_32; 

/* IMMEDIATE: 8 bit jump or branch target offset */  
input signed [7:0] IMMEDIATE;

/* and_out: Output of and gate */
/* or_out: Output of or gate */
wire and_out,or_out;

/* When RESET is high PC value will be -4 */
always @ (RESET)
begin
	if(RESET)
		begin
			#1 next_pc = -32'd4;
		end
end

/* and to check if the given beq instruction can be executed */
and u1(and_out,ZERO,BEQ_signal);
/* or to check if the given beq or j instructions can be executed */
or u2(or_out,and_out,J_signal);
/* Instantiating the dedicated adder used for PC */
adder addpc(current_pc,32'd4,result);
/* Extend the 8 bit target offset to 32 bit and shift left by 2 */
left_shift shift(IMMEDIATE,offset_32);
/* Instantiating the dedicated adder used to add 32 bit target offset to next PC value */
adder_signed add_pcbeq(result,offset_32,result_J_BEQ);

always @ (posedge CLK)
begin	
	if(RESET)
		begin
			#1 next_pc = -32'd4; /* If RESET is high when writing to PC at a positive edge clock, write -4 to the PC */
		end
	else if(or_out)
		begin
			#1 next_pc = result_J_BEQ; /* Increment the value of PC by the target offset */
		end
	else 
		begin
			#1 next_pc = result; /* Increment the value of PC by 4 */
			
		end
end

endmodule