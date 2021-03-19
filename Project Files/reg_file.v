/* CO224 Lab - 05 Part 4 - Register File */
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for 8 x 8 register file */

module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);
	input [7:0] IN;     /* 8 - bit data input port */
	output [7:0] OUT1, OUT2;   /* 8 - bit data output ports */
	input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;  /* 3 - bit address ports */
	input WRITE, CLK, RESET;  /* Control input ports */

	reg [7:0] reg_file [7:0];   /* 8 - bit register array */
	
	/* Loading values to OUT1 and OUT2 from registers where addresses are OUT1ADDRESS and OUT2ADDRESS */
	assign #2 OUT1 =   reg_file[OUT1ADDRESS];
	assign #2 OUT2 =   reg_file[OUT2ADDRESS];
	
	/* i - count */
	integer i;
	
	/* always block will be executed whenever the level triggered RESET signal is changed */
	always @ (RESET)
	begin
	    /* Check if RESET signal is high */	    
		if(RESET)
			begin
			#2 /* Added delay */
			    /* When RESET is high, values of all the registers in the register file will be set to 0 */
				for(i=0;i<8;i=i+1)begin
					reg_file[i] =  8'b00000000;
				end
			end				
	end
	
	/* always block will be executed whenever the edge triggered CLOCK signal is changed */
	always @ (posedge CLK)
	begin
	    /* Check if the signals at WRITE port is high and RESET is low */
		if(WRITE && !RESET)
		begin
		    /* Data in the IN port is written to the input register of address INADDRESS */
			#2 reg_file[INADDRESS] =  IN;
		end				
	end
	
endmodule