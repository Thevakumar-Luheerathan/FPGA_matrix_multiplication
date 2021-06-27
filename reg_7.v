module reg_7 (//X
input clock,
input LD,
input [2:0] EN,
output reg [3:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        case (EN)
        3'b001:dataout<=4'b1000;
        3'b010:dataout<=4'b0100;
        3'b011:dataout<=4'b0010;
        3'b100:dataout<=4'b0001;
        3'b111:dataout<=4'b1111;
        endcase
end
    
endmodule