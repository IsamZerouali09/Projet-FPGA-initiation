/* module: When button 1 and 2 are pressed, turn on LED */ 
module and_gate (

	// Inputs
	input 	pmod_0,
	input	pmod_1,
	
	// Outputs
	output 	led_0,
	output	led_1,
	output	led_2,
);
	// Continuous assignment: NOT and AND operators
	assign led_0 = ~pmod_0 & ~pmod_1;
	assign led_1 = ~pmod_0;
	assign led_2 = ~pmod_0;
endmodule