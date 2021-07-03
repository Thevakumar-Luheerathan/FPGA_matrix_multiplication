module instruction_memory_mod(
input clock,
input [7:0] addr0,addr1,addr2,addr3,
output reg [7:0] instruction0,instruction1,instruction2,instruction3 );

reg [7:0] ram [255:0];

parameter EN0 =8'd3;
parameter EN1 =8'd4;
parameter EN2 =8'd5;
parameter EN3 =8'd6;
parameter ENALL =8'd7;
parameter RSTALL =8'd8;
parameter LODAC =8'd9;
parameter MACCI =8'd11;
parameter MACCJ =8'd12;
parameter MACCK =8'd13;
parameter MVSKR =8'd14;
parameter MVSIR =8'd15;
parameter MVSJR =8'd16;
parameter MCIAC =8'd17;
parameter MCJAC =8'd18;
parameter MCKAC =8'd19;
parameter MAAAR =8'd20;
parameter MVACR =8'd21;
parameter MABAR =8'd22;
parameter MTACR =8'd23;
parameter MACTA =8'd24;
parameter MVRAC =8'd25;
parameter MADAR =8'd26;
parameter STOAC =8'd27;
parameter RSTAC =8'd28;
parameter RSTSJ =8'd29;
parameter RSTSK =8'd30;
parameter INCSI =8'd31;
parameter INCSJ =8'd32;
parameter INCSK =8'd33;
parameter SUBTR =8'd34;
parameter MULTI =8'd35;
parameter ADDIT =8'd36;
parameter END =8'd38;
parameter JUMNZ =8'd40;

initial begin
ram[0]=RSTALL;
ram[1]=LODAC;
ram[2]=MACCI;
ram[3]=LODAC;
ram[4]=MACCJ;
ram[5]=LODAC;
ram[6]=MACCK;

ram[7]=EN0;
ram[8]=MAAAR;
ram[9]=LODAC;
ram[10]=MVACR;
ram[11]=MABAR;
ram[12]=LODAC;

ram[13]=ENALL;
ram[14]=MULTI;
ram[15]=MTACR;
ram[16]=ADDIT;
ram[17]=MACTA;

ram[18]=INCSJ;
ram[19]=MVSJR;
ram[20]=MCJAC;
ram[21]=SUBTR;
ram[22]=JUMNZ;
ram[23]=8'd7;

ram[24]=MTACR;
ram[25]=MVRAC;
ram[26]=MADAR;
ram[27]=STOAC;

ram[28]=RSTAC;
ram[29]=MACTA;
ram[30]=INCSK;
ram[31]=RSTSJ;
ram[32]=MVSKR;
ram[33]=MCKAC;
ram[34]=SUBTR;
ram[35]=JUMNZ;
ram[36]=8'd7;

ram[37]=ENALL;
ram[38]=INCSI;
ram[39]=MVSIR;
ram[40]=MCIAC;
ram[41]=SUBTR;
ram[42]=END;

ram[43]=RSTSJ;
ram[44]=RSTSK;
ram[45]=JUMNZ;
ram[46]=8'd7;

end


always @(posedge clock) 
begin
        instruction0 <= ram[addr0];
        instruction1 <= ram[addr1];
        instruction2 <= ram[addr2];
        instruction3 <= ram[addr3];
end
endmodule