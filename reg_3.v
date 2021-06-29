module reg_3 (//R
input clock,
input LD,
input [15:0] datain,
output reg [15:0] dataout
);

always @(negedge clock) 
begin
    if (LD==1)
        dataout<= datain;   
end 
endmodule