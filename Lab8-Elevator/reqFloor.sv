module reqFloor (SW, clk, reset, whichFlr, closeDr);
input logic [6:1] SW;
input logic reset, clk, closeDr;
output logic [6:1] whichFlr; 

always @ ( posedge clk) begin  
		if(reset)
			whichFlr[6:1] <= 6'b000001;
		else if (closeDr)
			whichFlr[6:1] <=  SW[6:1] ;
		else
			whichFlr[6:1] <=  whichFlr[6:1];
		end 

endmodule


module reqFloor_testbench();
   logic 		clk;
	logic reset; 
	logic [6:1] SW, whichFlr;
	logic closeDr;

 reqFloor dut (SW, clk, reset, whichFlr, closeDr);

 // Set up the clock.
 parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

	reset <= 1;									@(posedge clk);

	                                    @(posedge clk);

													@(posedge clk);

	reset <= 0; 								@(posedge clk);

	                                    @(posedge clk);

													@(posedge clk);

	closeDr<=1;								@(posedge clk);

													@(posedge clk);

													@(posedge clk); 

	SW [6:1] <= 6'b100000;             @(posedge clk);

													@(posedge clk);

													@(posedge clk);

													@(posedge clk);

	closeDr<=0;							   @(posedge clk);

													@(posedge clk);

	SW [6:1] <= 6'b010000;	   			@(posedge clk);

	                                    @(posedge clk);

													@(posedge clk);

	closeDr<=1;								@(posedge clk);

													@(posedge clk);

													@(posedge clk);

	closeDr<=0;   					      @(posedge clk);

												   @(posedge clk);

	                                    @(posedge clk);

													@(posedge clk);

	SW[6:1] <=6'b000001;				      @(posedge clk);

													@(posedge clk);

													@(posedge clk);

	closeDr<=1;								@(posedge clk);

													@(posedge clk);

													@(posedge clk);	

													@(posedge clk);

	reset <=1;	 								@(posedge clk);

													@(posedge clk);

													@(posedge clk);

													@(posedge clk);

													@(posedge clk);

		$stop; // End the simulation.
	end
endmodule
