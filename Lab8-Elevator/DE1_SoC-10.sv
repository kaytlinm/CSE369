module  DE1_SoC  (CLOCK_50,  HEX0,  HEX1, HEX4, HEX5,  KEY,  LEDR, SW); 
   input  logic CLOCK_50; 
	output logic[6:0]  HEX0, HEX1, HEX4, HEX5; 
	output logic[9:0]  LEDR;
	input  logic[3:0]  KEY;
	input  logic[9:0]  SW; 
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic[31:0] clk;
	parameter whichClock = 24;
	clock_divider cdiv (CLOCK_50, clk);
	
	// Hook up inputs and outputs.
	logic [5:0] dest;
	logic directionled, temp0,lighton;
	logic [6:0] dis;
	logic [3:0] hexdis;
	assign reset = SW[9];
	
	flipFlop set0(.clk(clk[whichClock]), .d1(KEY[0]), .q1(temp0), .q2(clean0));

	reqFloor getfloor (.SW(SW[5:0]), .clk(clk[whichClock]), .reset(SW[9]), .whichFlr(dest), .closeDr(~clean0));

	elevator move(.clk(clk[whichClock]), .reset(SW[9]), .destination(dest), .display1(HEX5), .display2(HEX4), 

	.direction(directionled), .directionlight(lighton), .HEXdisp3(HEX1), .HEXdisp2(HEX0));

	assign LEDR[9] = (directionled == 1 & lighton == 1);
	assign LEDR[8] = (directionled == 0 & lighton == 1);
	assign LEDR[5:0] = SW[5:0];

endmodule


module clock_divider (clock, divided_clocks);
   input logic          clock;
	output logic  [31:0]divided_clocks;

	initial begin
	   divided_clocks <= 0;
	end
	
	always_ff@(posedge clock) begin
	   divided_clocks <= divided_clocks + 1;
	end
endmodule


module DE1_SoC_testbench();
   logic 		CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; 
	logic [9:0] SW;

 DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX4, HEX5, KEY, LEDR, SW);


 // Set up the clock.
 parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	SW[9] <= 1;									@(posedge CLOCK_50);

	                                    @(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[9] <= 0; 								@(posedge CLOCK_50);

	                                    @(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1; SW[8:0]<=9'b000000000; @(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0; 		   					@(posedge CLOCK_50);

	                                    @(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;  					         @(posedge CLOCK_50);

												   @(posedge CLOCK_50);

	                                    @(posedge CLOCK_50);

	KEY[0] <= 0; 				            @(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1; 								@(posedge CLOCK_50);

													@(posedge CLOCK_50);	

													@(posedge CLOCK_50);

	KEY[0] <= 0; 								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;					   		@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;			   				@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 1;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	KEY[0] <= 0;								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[9] <= 1;									@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[9] <= 0; 								@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[8:0]<=9'b0111111110; KEY[0] <=0;	@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[9] <=1;									@(posedge CLOCK_50);

													@(posedge CLOCK_50);

	SW[9] <=0;									@(posedge CLOCK_50);

													@(posedge CLOCK_50);

		$stop; // End the simulation.

	end

endmodule
