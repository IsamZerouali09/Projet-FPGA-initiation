/* module: When button 1 and 2 are pressed, turn on LED */ 
module and_gate (

	// Inputs
	input	[2:0]	pmod,
	
	// Outputs
	output	[4:0]	led
);
	// wire (net) declaration (internal to module)
	wire or_pmod_02;
	wire and_pmod_02;
	wire A;
	wire B;
	wire C;
	
	// Continuous assignment: replicate 1 wire to 2 outputs 
	assign A 		= ~pmod[0];
	assign B 		= ~pmod[1];
	assign C 		= ~pmod[2];
	assign led[0]	= (B&(A|C))|(A&C);
	assign led[1]	= (~A&((B&~C)|(~B&C)))|(A&((B&C)|(~B&~C)));
endmodule