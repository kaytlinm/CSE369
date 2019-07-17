module elevator (clk, reset, destination, display1, display2, direction, directionlight, HEXdisp3,HEXdisp2);
	input  logic clk, reset;
	input logic [5:0] destination;
	output logic [6:0] display1, display2;
	output logic direction, directionlight;
	output logic [6:0] HEXdisp3,HEXdisp2;	

	// State variables.
	enum { first, second, secondD, secondM, secondMD, third, thirdD, thirdM, thirdMD, fourth} ps, ns;

	// Next State logic
	always_comb begin
		case(ps)
		first: begin
				 if (destination[0] == 1 ||(destination[5:1] == 0) )   
					ns = first;
		       else                       
					ns = second;
				 end

		second: begin
				  if (destination[1] == 1 || (destination[0] == 0 & destination[5:2] == 0))     
				      ns = second;
				  else if(destination[2]==1 | destination[3]==1 | destination[4]==1 |destination[5]==1)
                  ns = secondM;
              else 
                  ns = secondD;				  
				  end

		secondD: begin
					if (destination[1] == 1 || (destination[0] == 0 & destination[5:2] == 0))    
				       ns = secondD;
				   else if(destination[0]==1)
                   ns = first;
               else 
                   ns = second;				  
				   end

		secondM: begin
					if (destination[2] == 1 || (destination[1:0] == 0 & destination[5:3] == 0))    
				      ns = secondM;
				   else if(destination[3]==1 | destination[4]==1 |destination[5]==1)
                  ns = third;
               else 
                  ns = secondD;				 
				   end


	   secondMD: begin
					 if (destination[2] == 1 || (destination[1:0] == 0 & destination[5:3] == 0))   
				       ns = secondMD;
				    else if(destination[1]==1 | destination[0]==1)
                   ns = secondD;
                else 
                   ns = secondM;				  
				    end	
				
		third: begin
				 if (destination[3] == 1 || (destination[5:4] == 0 & destination[2:0] == 0))    
				    ns = third;
				 else if(destination[4]==1 |destination[5]==1)
                ns = thirdM;
             else 
                ns = thirdD;				  
				 end

	   thirdD: begin
				  if (destination[3] == 1 || (destination[5:4] == 0 & destination[2:0] == 0))    
				     ns = thirdD;
				  else if(destination[2]==1 | destination[1]==1 | destination[0]==1)
                 ns = secondMD;
              else 
                 ns = third;				  
				  end
		

		thirdM: begin
					if(destination[4] == 1 || (destination[5] == 0 & destination[3:0] == 0))    
				      ns = thirdM;
				   else if(destination[5]==1)
                  ns = fourth;
               else 
                  ns = thirdMD;				  
				   end

		thirdMD: begin
					if(destination[4] == 1 || (destination[5] == 0 & destination[3:0] == 0))    
				      ns = thirdMD;
				   else if(destination[3]==1 | destination[2]==1 | destination[1]==1 | destination[0]==1)
                  ns = thirdD;
               else 
                  ns = thirdM;				  
				   end

		fourth: begin
				 if (destination[5] == 1 || (destination[4:0] == 0))   
						ns = fourth;
		       else                           
						ns = thirdMD;
				 end

      default: ns = first;

	   endcase

	end


	//assigning the outputs
	always_comb begin
		case(ps)

	   first: begin

			    direction = 1;
			    display1 = 7'b1001111;//1
			    display2 = 7'b1111111;//off 

				 if (destination[0] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off
					 end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end

				 if(destination[0] == 1 & destination[5:1] == 0)
			       directionlight = 0;
				 else if (destination[0] == 0 & destination[5:1] == 0)
				    directionlight = 0;
				 else 
			       directionlight = 1;	 	 
				 end

				 
		second: begin
				  display1 = 7'b0100100;//2
				  display2 = 7'b1111111;//off
				  direction = 1;

				  if (destination[1] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off
					 end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end
				  
				  if(destination[1] == 1 & destination[5:2] == 0 & destination[0] == 0)
			       directionlight = 0;
				  else if (destination[1] == 0 & destination[5:2] == 0 & destination[0] == 0)
				    directionlight = 0;
				  else if (destination[5:2] == 0 & destination[0] == 1)
				    directionlight = 0;
				  else 
			       directionlight = 1;
				 end
				 

		secondD: begin
				   display1 = 7'b0100100;//2
				   display2 = 7'b1111111;//off
		         direction = 0;
		
					if (destination[1] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off
						end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end

					if(destination[1] == 1 & destination[5:2] == 0 & destination[0] == 0)
			       directionlight = 0;
				   else if (destination[1] == 0 & destination[5:2] == 0 & destination[0] == 0)
				    directionlight = 0;
					else if((destination[5] == 1 | destination[4] == 1 | destination[3]==1  | destination[2] == 1)& destination[0] == 0)
					  directionlight = 0;
					else 
			       directionlight = 1;
				   end

		
		secondM: begin
					display1 = 7'b0100100;//2
				   display2 = 7'b0001001;//H
		         direction = 1;

					if (destination[2] == 1) begin
				    HEXdisp3 = 7'b0000110;//E
					 HEXdisp2 = 7'b1111111;//off
					end
					else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end
					
					if(destination[2] == 1 & destination[5:3] == 0 & destination[1:0] == 0)
			       directionlight = 0;
					else if (destination[2] == 0 & destination[5:3] == 0 & destination[1:0] == 0)
				    directionlight = 0;
					else if (destination[5:3] == 0 & (destination[1] == 1 | destination[0] == 1))
				    directionlight = 0;
				   else 
			       directionlight = 1;
				   end

	   secondMD: begin
					 display1 = 7'b0100100;//2
				    display2 = 7'b0001001;//H
		          direction = 0;			  

					 if (destination[2] == 1) begin
						HEXdisp3 = 7'b0000110;//E
						HEXdisp2 = 7'b1111111;//off
						end
					 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					end
					 
				    if(destination[2] == 1 & destination[5:3] == 0 & destination[1:0] == 0)
						directionlight = 0;
					 else if (destination[2] == 0 & destination[5:3] == 0 & destination[1:0] == 0)
						directionlight = 0;
					 else if((destination[5] == 1 | destination[4] == 1 | destination[3]==1) & (destination[1] == 0 & destination[0] == 0))
						directionlight = 0;
				    else 
						directionlight = 1;
				 end	

		third: begin
				 display1 = 7'b0110000;//3
				 display2 = 7'b1111111;//off
		       direction = 1;  

				 if (destination[3] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off

				 end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					end
				 
				 if(destination[3] == 1 & destination[5:4] == 0 & destination[2:0] == 0)
			       directionlight = 0;
				 else if(destination[3] == 0 & destination[5:4] == 0 & destination[2:0] == 0)
				    directionlight = 0;
				 else if (destination[5:4] == 0 & (destination[2] == 1 | destination[1] == 1 | destination[0] == 1))
				    directionlight = 0;
				 else 
			       directionlight = 1;

				 end

	   thirdD: begin
				  display1 = 7'b0110000;//3
				  display2 = 7'b1111111;//off
		        direction = 0;		

				  if (destination[3] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off

					end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end

				  if(destination[3] == 1 & destination[5:4] == 0 & destination[2:0] == 0)
			       directionlight = 0;
				  else if(destination[3] == 0 & destination[5:4] == 0 & destination[2:0] == 0)
				    directionlight = 0;
				  else if((destination[5] == 1 | destination[4] == 1) & (destination[2] == 0 & destination[1] == 0 & destination[0] == 0))
					  directionlight = 0;
				  else 
			       directionlight = 1;
					 
				  end
		

		thirdM: begin
					display1 = 7'b0110000;//3
				   display2 = 7'b0001001;//H
		         direction = 1;	

					if (destination[4] == 1) begin
				    HEXdisp3 = 7'b1000001;//W
					 HEXdisp2 = 7'b1000001;//W
					end
					else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end

					if(destination[4] == 1 & destination[5] == 0 & destination[3:0] == 0)
			       directionlight = 0;
					else if(destination[4] == 0 & destination[5] == 0 & destination[3:0] == 0)
				    directionlight = 0;
					else if (destination[5] == 0 & (destination[3] == 1 | destination[2] == 1 | destination[1] == 1 | destination[0] == 1))
				    directionlight = 0;
				   else 
			       directionlight = 1;

	
				   end

		

		thirdMD: begin
					display1 = 7'b0110000;//3
				   display2 = 7'b0001001;//H
		         direction = 0;				  

					if (destination[4] == 1) begin
				    HEXdisp3 = 7'b1000001;//W
					 HEXdisp2 = 7'b1000001;//W
					end
					else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end
					
					if(destination[4] == 1 & destination[5] == 0 & destination[3:0] == 0)
			       directionlight = 0;
					else if(destination[4] == 0 & destination[5] == 0 & destination[3:0] == 0)
				    directionlight = 0;
					else if((destination[5] == 1) & (destination[3] == 0 & destination[2] == 0 & destination[1] == 0 & destination[0] == 0))
					  directionlight = 0;
				   else 
			       directionlight = 1;

				   end

		

		fourth: begin
			     display1 = 7'b0011001;//4
				  display2 = 7'b1111111;//off
		        direction = 0;

				 if (destination[5] == 1) begin
				    HEXdisp3 = 7'b0000011;//b
					 HEXdisp2 = 7'b1111111;//off
				 end
				 else begin
				    HEXdisp3 = 7'b1111111;//off
					 HEXdisp2 = 7'b1111111;//off
					 end
				  
				  if(destination[5] == 1 & destination[4:0] == 0)
			       directionlight = 0;
				  else if(destination[5] == 0 & destination[4:0] == 0)
				    directionlight = 0;
				  else 
			       directionlight = 1;

				 end

	   endcase

	end
		
	// DFFs
	always_ff@(posedge clk)begin
	   if (reset)
		   ps <= first;
		else
		   ps <= ns;
   end
endmodule

module elevator_testbench();
   logic clk;
	logic reset; // True when not pressed, False when pressed
	logic [5:0] destination;
	logic [6:0] display1, display2,HEXdisp3,HEXdisp2;
	logic [2:0] ns;
	logic direction,directionlight;

	elevator dut (clk, reset, destination, display1, display2, direction, directionlight, HEXdisp3,HEXdisp2);
	
 //Set up the clock.
 parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end 

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

	reset <= 1;																	@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	reset <= 0; 																@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk); 

																					@(posedge clk); 

	destination[6:1] <= 6'b000010;             	             	@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination [6:1] <= 6'b000100;	   								@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b001000;				  						   @(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b010000;				  							@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b100000;				  							@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b010000;             				    	@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b001000;				   						@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b100100;				   						@(posedge clk);

																					@(posedge clk);

																					@(posedge clk); 

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b100000; 			   	               @(posedge clk);

																					@(posedge clk); 

																					@(posedge clk);

	destination[6:1] <=6'b101000; 						            @(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b000001;				   						@(posedge clk);

																					@(posedge clk);

	destination[6:1]	<=6'b100001; 										@(posedge clk);

																					@(posedge clk);

	destination[6:1] <=6'b000001;              						@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	destination[6:1] <= 6'b100000;									   @(posedge clk);

																					@(posedge clk);

	destination[6:1] <= 6'b000000;										@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

	reset <=1;	 																@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

																					@(posedge clk);

		$stop; // End the simulation.

	end

endmodule

