// Count up on each button press and display on LEDs

module button_counter (

	// Inputs
	input				pmod,
	input				clk,
	
	// Outputs
	output reg	[3:0]	led
);

	wire rst;
	reg clk_1Hz;
	reg [31:0] inc;
	//localparam [31:0] max_count = 6000000;
	
	// Reset is the inverse of the first button
	assign rst = ~pmod[0];
	
	// Clock signal of 1 Hz with oscillator of 12 MHz
	always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			//led		<=	4'b0;
			clk_1Hz	<=	1'b0;
			inc		<=	32'b0;
		end else if (inc <= 6000000) begin
			inc 	<= inc + 1;
		end else begin
			inc <= 0;
			clk_1Hz <= ~clk_1Hz;
		end
	end

	// Count up on clock rising edge or reset on button push
	always @ (posedge clk_1Hz or posedge rst) begin
		if (rst == 1'b1) begin
			led <= 4'b0;
		end else begin
			led <= led + 1'b1;
		end
	end
	
endmodule