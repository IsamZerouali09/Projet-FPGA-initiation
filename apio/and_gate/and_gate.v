/* module: When button 1 and 2 are pressed, turn on LED */ 
module and_gate (

	// Inputs
	input	[1:0]	pmod,
	
	// Outputs
	output	[4:0]	led
);
	// wire (net) declaration (internal to module)
	wire not_pmod_0;
	
	// Continuous assignment: replicate 1 wire to 2 outputs 
	assign not_pmod_0 = ~pmod[0];
	assign led[1:0] = {2{not_pmod_0}};
	assign led[2]	= not_pmod_0 & ~pmod[1];
endmodule