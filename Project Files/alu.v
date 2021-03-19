/* CO224 Lab - 05 Part 4 - ALU */
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for 8 - bit ALU */

module alu(DATA1, DATA2, RESULT, SELECT, ZERO);
	input [7:0] DATA1, DATA2;     /* 8 - bit input ports */
	input [2:0] SELECT;           /* 3 - bit control input port */ 
	output [7:0] RESULT;          /* 8 - bit output port */
	output ZERO;

	/* RESULT port stores values */
	reg [7:0] RESULT;  
	/* ZERO: Output 1 if RESULT is 0 */
	wire ZERO;
	/* Get output ZERO */
	nor u3(ZERO,RESULT[0],RESULT[1],RESULT[2],RESULT[3],RESULT[4],RESULT[5],RESULT[6],RESULT[7]);
	/* always block will be executed whenever the values of signals at DATA1 or DATA2 or SELECT change */
	always @ (DATA1, DATA2, SELECT) 
		begin
			case(SELECT)
			    /* FORWARD function for loadi, mov instructions */
				/* Forwards value from DATA2 into RESULT */
				3'b000: #1 RESULT = DATA2; 
				/* ADD function for add, sub instructions */
				/* Add values in DATA1 and DATA2 */
				3'b001: #2 RESULT = DATA1 + DATA2;				          
				/* AND function */
				/* Does bitwise AND on values in DATA1 with DATA2 for and instruction */
				3'b010: #1 RESULT = DATA1 & DATA2;
				/* OR function */
				/* Does bitwise OR on values in DATA1 with DATA2 for Or instruction */
				3'b011: #1 RESULT = DATA1 | DATA2;
				/* Any other combinations are reserved for future use */
				default:RESULT = 8'bxxxxxxxx;					
			endcase

		end
endmodule