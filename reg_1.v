module reg_1 ( //AR,IR,CI,CJ,CK
input clock,
input LD,
input [7:0] datain,
output reg [7:0] dataout
);

always @(negedge clock) 
begin
    if (LD==1)
        dataout<= datain;   
end
endmodule