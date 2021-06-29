module reg_5 (//SI,SJ,SK
input clock,
input INC,
input RST,
output reg [7:0] dataout
);

always @(negedge clock) 
begin
if (INC==1)
    dataout<= dataout + 8'd1;
if (RST==1)
    dataout<= 8'd0;   
end
    
endmodule