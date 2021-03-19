/* CO224 Lab - 05 Part 4*/
/* Name : Adikari A.M.I.N. */
/* Reg no. : E/16/012 */
/* module for testbench for CPU*/

`include "cpu.v"

module cpu_tb;

    reg CLK, RESET;
    wire [31:0] PC;
    wire  [31:0] INSTRUCTION;
    
    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
	/* Initializing an array of registers (8x1024) to be used as instruction memory */
    reg [7:0] INSTRUCTION_MEM [1023:0];

	/* Fetching an instruction from instruction memory */
	assign #2 INSTRUCTION = {INSTRUCTION_MEM[PC+32'd3], INSTRUCTION_MEM[PC +32'd2], INSTRUCTION_MEM[PC+32'd1], INSTRUCTION_MEM[PC]};
	   
    initial
    begin
        /* Initializing instruction memory with a set of instructions */
        
		// loadi 4 0x19
        {INSTRUCTION_MEM[8'd3], INSTRUCTION_MEM[8'd2], INSTRUCTION_MEM[8'd1], INSTRUCTION_MEM[8'd0]} = 32'b00000000000001000000000000011001;
		//loadi 3 0x19
		{INSTRUCTION_MEM[8'd7], INSTRUCTION_MEM[8'd6], INSTRUCTION_MEM[8'd5], INSTRUCTION_MEM[8'd4]} = 32'b00000000000000110000000000011001;
		// beq x02 3 4
		{INSTRUCTION_MEM[8'd11], INSTRUCTION_MEM[8'd10], INSTRUCTION_MEM[8'd9], INSTRUCTION_MEM[8'd8]} = 32'b00000111000000100000001100000100;
		//loadi 4 0x0F
		{INSTRUCTION_MEM[8'd15], INSTRUCTION_MEM[8'd14], INSTRUCTION_MEM[8'd13], INSTRUCTION_MEM[8'd12]} = 32'b00000000000000100000000000001111;
		//loadi 7 0x03
		{INSTRUCTION_MEM[8'd19], INSTRUCTION_MEM[8'd18], INSTRUCTION_MEM[8'd17], INSTRUCTION_MEM[8'd16]} = 32'b00000000000000100000000000000011;
		//add 7 4 3
		{INSTRUCTION_MEM[8'd23], INSTRUCTION_MEM[8'd22], INSTRUCTION_MEM[8'd21], INSTRUCTION_MEM[8'd20]} = 32'b00000100000001110000010000000011;
		//mov 5 4
		{INSTRUCTION_MEM[8'd27], INSTRUCTION_MEM[8'd26], INSTRUCTION_MEM[8'd25], INSTRUCTION_MEM[8'd24]} = 32'b00000001000001010000000000000100;
		// j 0x03 
		{INSTRUCTION_MEM[8'd31], INSTRUCTION_MEM[8'd30], INSTRUCTION_MEM[8'd29], INSTRUCTION_MEM[8'd28]} = 32'b00000110000000110000000000000000;
		//sub 6 5 2
		{INSTRUCTION_MEM[8'd35], INSTRUCTION_MEM[8'd34], INSTRUCTION_MEM[8'd33], INSTRUCTION_MEM[8'd32]} = 32'b00000101000001100000010100000010;
		//and 7 4 2
		{INSTRUCTION_MEM[8'd39], INSTRUCTION_MEM[8'd38], INSTRUCTION_MEM[8'd37], INSTRUCTION_MEM[8'd36]} = 32'b00000010000001110000010000000010;
		//or 4 4 2
		{INSTRUCTION_MEM[8'd43], INSTRUCTION_MEM[8'd42], INSTRUCTION_MEM[8'd41], INSTRUCTION_MEM[8'd40]} = 32'b00000011000001000000010000000010;
		//or 6 5 7
		{INSTRUCTION_MEM[8'd47], INSTRUCTION_MEM[8'd46], INSTRUCTION_MEM[8'd45], INSTRUCTION_MEM[8'd44]} = 32'b00000011000001100000010100000111;
		//sub 6 6 7
		{INSTRUCTION_MEM[8'd51], INSTRUCTION_MEM[8'd50], INSTRUCTION_MEM[8'd49], INSTRUCTION_MEM[8'd48]} = 32'b00000101000001100000011000000111;
		//and 6 6 7
		{INSTRUCTION_MEM[8'd55], INSTRUCTION_MEM[8'd54], INSTRUCTION_MEM[8'd53], INSTRUCTION_MEM[8'd52]} = 32'b00000010000001100000011000000111;
		
    end
    
    /* 
    -----
     CPU
    -----
    */
    cpu mycpu(PC, INSTRUCTION, CLK, RESET);

    initial
    begin
    
        /* Generate files needed to plot the waveform using GTKWave */
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
		#3
		/* Resetting the CPU to start the program execution */
		RESET = 1'b1;
        
        #5
		RESET = 1'b0;
		
        /* Finishing simulation after some time */
        #500
        $finish;
        
    end
    
    /* Clock signal generation */
    always
        #5 CLK = ~CLK;
        

endmodule