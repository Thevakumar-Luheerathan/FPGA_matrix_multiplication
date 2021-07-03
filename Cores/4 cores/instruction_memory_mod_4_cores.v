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

ram[13]=EN2;
ram[14]=INCSI;
ram[15]=INCSI;
ram[16]=MVSIR;
ram[17]=MCIAC;
ram[18]=SUBTR;
ram[19]=END;

ram[20]=EN3;
ram[21]=INCSI;
ram[22]=INCSI;
ram[23]=INCSI;
ram[24]=MVSIR;
ram[25]=MCIAC;
ram[26]=SUBTR;
ram[27]=END;

ram[28]=EN0;
ram[29]=MAAAR;
ram[30]=LODAC;
ram[31]=MVACR;
ram[32]=MABAR;
ram[33]=LODAC;

ram[34]=EN1;
ram[35]=MAAAR;
ram[36]=LODAC;
ram[37]=MVACR;
ram[38]=MABAR;
ram[39]=LODAC;

ram[40]=EN2;
ram[41]=MAAAR;
ram[42]=LODAC;
ram[43]=MVACR;
ram[44]=MABAR;
ram[45]=LODAC;

ram[46]=EN3;
ram[47]=MAAAR;
ram[48]=LODAC;
ram[49]=MVACR;
ram[50]=MABAR;
ram[51]=LODAC;

ram[52]=ENALL;
ram[53]=MULTI;
ram[54]=MTACR;
ram[55]=ADDIT;
ram[56]=MACTA;

ram[57]=INCSJ;
ram[58]=MVSJR;
ram[59]=MCJAC;
ram[60]=SUBTR;
ram[61]=JUMNZ;
ram[62]=8'd28;

ram[63]=MTACR;
ram[64]=MVRAC;
ram[65]=MADAR;
ram[66]=STOAC;

ram[67]=RSTAC;
ram[68]=MACTA;
ram[69]=INCSK;
ram[70]=RSTSJ;
ram[71]=MVSKR;
ram[72]=MCKAC;
ram[73]=SUBTR;
ram[74]=JUMNZ;
ram[75]=8'd28;

ram[76]=ENALL;
ram[77]=INCSI;
ram[78]=INCSI;
ram[79]=INCSI;
ram[80]=INCSI;
ram[81]=MVSIR;
ram[82]=MCIAC;
ram[83]=SUBTR;
ram[84]=END;

ram[85]=RSTSJ;
ram[86]=RSTSK;
ram[87]=JUMNZ;
ram[88]=8'd28;

end


always @(posedge clock) 
begin
        instruction0 <= ram[addr0];
        instruction1 <= ram[addr1];
        instruction2 <= ram[addr2];
        instruction3 <= ram[addr3];
end
endmodule