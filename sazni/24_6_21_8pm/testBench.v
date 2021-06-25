module testBench();
	reg CI,CJ,CK,SI,SJ,SK;
	wire AA;
	wire AB;
	wire AD;
	
	address_module test_address(
		.CI(CI),
		.CJ(CJ),
		.CK(CK),
		.SI(SI),
		.SJ(SJ),
		.SK(SK),
		.AA(AA),
		.AB(AB),
		.AD(AD)
	);
	initial begin
		 CI=1'd3;
		 CJ=1'd4;
		 CK=1'd5;
		 SI=1'd0;
		 SJ=1'd0;
		 SK=1'd0;
		 $display({AA,AB,AD});
		 #20;
		 
		 for (SI=0; SI<CI; SI=SI+1) begin
			for (SJ=0; SJ<CI; SJ=SJ+1) begin
				for (SK=0; SK<CK; SK=SK+1) begin
					$display({AA,AB,AD});
					#20;
				end
			end
		end
	end
		 
endmodule
