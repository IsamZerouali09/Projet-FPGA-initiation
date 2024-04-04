// State machien that counts up when button are pressed

module fsm_moore(

	//Inputs
	input 						clk,
	input 						rst_btn,
	input 						go_btn,

	
	//Outputs
	output reg [3:0]			led,
	output reg 					done_signal
);

	// States
	localparam STATE_IDLE		= 2'd0;
	localparam STATE_COUNTING	= 2'd1;
	localparam STATE_DONE		= 2'd2;
	
	// Max counts for clock divider and counter (0.25s period)
	localparam MAX_CLK_COUNT	= 24'd1500000;
	localparam MAX_LED_COUNT	= 4'hf;
	
	//Internal signal
	wire rst;
	wire go;
	
	//Internal storage elements
	reg			div_clk;
	reg [1:0]	state;
	reg [23:0]	clk_count;
	
	//Invert active low button
	assign rst	= ~rst_btn;
	assign go	= ~go_btn;
	
	//Clock divider
	always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			clk_count 	<= 24'd0;
		end else if (clk_count < MAX_CLK_COUNT) begin
			clk_count 	<= clk_count + 1;
		end else begin
			clk_count	<= 24'd0;
			div_clk 	<= ~div_clk;
		end
	end

	always @ (posedge div_clk or posedge rst) begin
		// On reset, return to idle State
		if (rst == 1'b1) begin
			state 		<= STATE_IDLE;
			
		// Define the state transitions
		end else begin
			case(state)
			
				// Wait for go button to be pressed
				STATE_IDLE: begin
					if (go == 1'b1) begin
						state	<= STATE_COUNTING;
					end
				end
				
				// Go from counting to done if counting reaches max value
				STATE_COUNTING: begin
					if (led == MAX_LED_COUNT) begin
						state	<= STATE_DONE;
					end
				end
				
				//Current state goes to idle
				STATE_DONE: state <= STATE_IDLE;
				
				default: state <= STATE_IDLE;
			endcase
		end
	end

	// handle LED counter
	always @ (posedge div_clk or posedge rst) begin
		// On reset, reset led
		if (rst == 1'b1) begin
			led 		<= 4'd0;
			
		// Define the state transitions
		end else begin
			if ( state == STATE_COUNTING) begin
				led 	<= led + 1;
			end else begin
				led		<= 4'b0;
			end
		end
	end

	// handle done LED output
	always @ ( * ) begin
		if (state == STATE_DONE) begin
			done_signal	= 1'b1;
		end else begin
			done_signal	= 1'b0;
		end
	end
endmodule
	
