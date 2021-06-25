module address_module(
input [7:0] CI,
input [7:0] CJ,
input [7:0] CK,
input [7:0] SI,
input [7:0] SJ,
input [7:0] SK,
output reg[7:0] AA,
output reg[7:0] AB,
output reg[7:0] AD);

always @ (SI or SJ or SK)
begin
AA = (2+(SI*CJ)+(SJ+1)); //0,1,2 are allocated for CI,CJ,CK
AB= (2+(CI*CJ)+(SJ*CK)+SK+1);
AD= (2+ (CI*CJ)+(CJ*CK)+(SI*CK)+(SK+1));
end
endmodule