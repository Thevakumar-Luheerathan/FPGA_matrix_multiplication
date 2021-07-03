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

ram[20]=EN0;
ram[21]=MAAAR;
ram[22]=LODAC;
ram[23]=MVACR;
ram[24]=MABAR;
ram[25]=LODAC;

ram[26]=EN1;
ram[27]=MAAAR;
ram[28]=LODAC;
ram[29]=MVACR;
ram[30]=MABAR;
ram[31]=LODAC;

ram[32]=EN2;
ram[33]=MAAAR;
ram[34]=LODAC;
ram[35]=MVACR;
ram[36]=MABAR;
ram[37]=LODAC;

ram[38]=ENALL;
ram[39]=MULTI;
ram[40]=MTACR;
ram[41]=ADDIT;
ram[42]=MACTA;

ram[43]=INCSJ;
ram[44]=MVSJR;
ram[45]=MCJAC;
ram[46]=SUBTR;
ram[47]=JUMNZ;
ram[48]=8'd20;

ram[49]=MTACR;
ram[50]=MVRAC;
ram[51]=MADAR;
ram[52]=STOAC;

ram[53]=RSTAC;
ram[54]=MACTA;
ram[55]=INCSK;
ram[56]=RSTSJ;
ram[57]=MVSKR;
ram[58]=MCKAC;
ram[59]=SUBTR;
ram[60]=JUMNZ;
ram[61]=8'd20;

ram[62]=ENALL;
ram[63]=INCSI;
ram[64]=INCSI;
ram[65]=INCSI;
ram[66]=MVSIR;
ram[67]=MCIAC;
ram[68]=SUBTR;
ram[69]=END;

ram[70]=RSTSJ;
ram[71]=RSTSK;
ram[72]=JUMNZ;
ram[73]=8'd20;

end


always @(posedge clock) 
begin
        instruction0 <= ram[addr0];
        instruction1 <= ram[addr1];
        instruction2 <= ram[addr2];
        instruction3 <= ram[addr3];
end
endmodule