module reg_2 (//DAR,PC
input clock,
input LD,
input INC,
input RST,
input [7:0] datain,
output reg [7:0] dataout
);

always @(negedge clock) 
begin
    if (LD==1)
        dataout<= datain;
    if (INC==1)
        dataout<= dataout + 8'd1; 
    if (RST==1)
        dataout<=8'd0;  
end
endmodule