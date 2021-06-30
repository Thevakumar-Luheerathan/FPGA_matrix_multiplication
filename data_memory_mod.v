module data_memory_mod (
input clock,
input write_en0 ,write_en1 ,write_en2 ,write_en3 ,
input [7:0] addr0,addr1,addr2,addr3,
input [15:0] datain0,datain1,datain2,datain3,
output reg [15:0] dataout0,dataout1,dataout2,dataout3);

reg [15:0] ram [255:0];

initial begin
ram[0]=16'd2;
ram[1]=16'd4;
ram[2]=16'd2;
ram[3]=16'd1;
ram[4]=16'd2;
ram[5]=16'd3;
ram[6]=16'd4;
ram[7]=16'd5;
ram[8]=16'd6;
ram[9]=16'd7;
ram[10]=16'd8;
ram[11]=16'd9;
ram[12]=16'd10;
ram[13]=16'd11;
ram[14]=16'd12;
ram[15]=16'd13;
ram[16]=16'd14;
ram[17]=16'd15;
ram[18]=16'd16;

end


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