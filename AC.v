module AC (
input clock,
input LD,
input RST,
input [15:0] alu_out,
output reg [15:0] dataout,
output    z
);

assign z= (dataout==16'd0)? 1'd1:1'd0;

always @(posedge clock) 
begin
    if (LD==1)
        dataout<=alu_out;    
    if (RST==1)
        dataout<=16'd0;
end
    
endmodule