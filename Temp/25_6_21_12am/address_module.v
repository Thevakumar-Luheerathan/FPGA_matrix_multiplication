module address_module(
  input [7:0] CI,CJ,CK,SI,SJ,SK,
  output [7:0] AA,AB,AD);

assign AA = (2+(SI*CJ)+(SJ+1)); //0,1,2 are allocated for CI,CJ,CK
assign AB= (2+(CI*CJ)+(SJ*CK)+SK+1);
assign AD= (2+ (CI*CJ)+(CJ*CK)+(SI*CK)+(SK+1));
endmodule