module reg_6 (//AA,AB,AD
input clock,
input [7:0] datain,
output reg [7:0] dataout
);

always @(posedge clock) 
begin
    dataout<= datain;   
end   
endmodule