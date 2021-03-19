/* CO224 Lab - 05 Part 4*/
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for dedicated adder for PC */

module adder(IN_NUM1, IN_NUM2, RESULT);

input [31:0] IN_NUM1, IN_NUM2; /* 32 bit input numbers */
output [31:0] RESULT;  /* 32 bit result of addition */

assign RESULT = IN_NUM1 + IN_NUM2;  /* Get the addition of the two numbers */
endmodule