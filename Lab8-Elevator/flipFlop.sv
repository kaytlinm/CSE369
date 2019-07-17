module flipFlop(clk, d1, q1, q2); 
	 input logic clk, d1;
	 output logic q1, q2;

	    always_ff @(posedge clk) begin
		     q1 <= d1;
			  q2 <= q1;
		 end
endmodule
