module datamemory (
input clock,
input write_en0 ,write_en1 ,write_en2 ,write_en3 ,
input [7:0] addr0,addr1,addr2,addr3,
input [15:0] datain0,datain1,datain2,datain3,
output reg [15:0] dataout0,dataout1,dataout2,dataout3);

reg [15:0] ram [255:0];

always @(posedge clock)
begin
    if (write_en0 == 1)
        ram[addr0] <= datain0;
    else 
        dataout0<=ram[addr0];

    if (write_en1 == 1)
        ram[addr1] <= datain1;
    else 
        dataout1<=ram[addr1];

    if (write_en2 == 1)
        ram[addr2] <= datain2;
    else 
        dataout2<=ram[addr2];

    if (write_en3 == 1)
        ram[addr3] <= datain3;
    else 
        dataout3<=ram[addr3];
end
endmodule