module reg_4 (//TAC
input clock,
input LD,
input RST,
input [15:0] datain,
output reg [15:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        dataout<= datain;
    if (RST==1)
        dataout<= 16'd0;   
end   
endmodule