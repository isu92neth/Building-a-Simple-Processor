/* CO224 Lab - 05 Part 4*/
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for get 2s complement of a 8 bit number */

module twos_com(IN_NUM, OUT_NUM);

input [7:0] IN_NUM;  /* 8 bit input */
output reg [7:0] OUT_NUM;  /* 8 bit output */

/* Executes in change of input number */
always @ (IN_NUM)
	begin
		OUT_NUM = ~IN_NUM + 1'b1;	/* Return the 2s complement value of the given number */
	end

endmodule