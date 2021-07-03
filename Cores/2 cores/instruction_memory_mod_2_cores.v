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

ram[7]=EN1;
ram[8]=INCSI;
ram[9]=MVSIR;
ram[10]=MCIAC;
ram[11]=SUBTR;
ram[12]=END;

ram[13]=EN0;
ram[14]=MAAAR;
ram[15]=LODAC;
ram[16]=MVACR;
ram[17]=MABAR;
ram[18]=LODAC;

ram[19]=EN1;
ram[20]=MAAAR;
ram[21]=LODAC;
ram[22]=MVACR;
ram[23]=MABAR;
ram[24]=LODAC;

ram[25]=ENALL;
ram[26]=MULTI;
ram[27]=MTACR;
ram[28]=ADDIT;
ram[29]=MACTA;

ram[30]=INCSJ;
ram[31]=MVSJR;
ram[32]=MCJAC;
ram[33]=SUBTR;
ram[34]=JUMNZ;
ram[35]=8'd13;

ram[36]=MTACR;
ram[37]=MVRAC;
ram[38]=MADAR;
ram[39]=STOAC;

ram[40]=RSTAC;
ram[41]=MACTA;
ram[42]=INCSK;
ram[43]=RSTSJ;
ram[44]=MVSKR;
ram[45]=MCKAC;
ram[46]=SUBTR;
ram[47]=JUMNZ;
ram[48]=8'd13;

ram[49]=ENALL;
ram[50]=INCSI;
ram[51]=INCSI;
ram[52]=MVSIR;
ram[53]=MCIAC;
ram[54]=SUBTR;
ram[55]=END;

ram[56]=RSTSJ;
ram[57]=RSTSK;
ram[58]=JUMNZ;
ram[59]=8'd13;

end


always @(posedge clock) 
begin
        instruction0 <= ram[addr0];
        instruction1 <= ram[addr1];
        instruction2 <= ram[addr2];
        instruction3 <= ram[addr3];
end
endmodule