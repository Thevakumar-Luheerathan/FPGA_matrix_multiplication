module instruction_memory(
input clock,
input write_en_file,
input [7:0] instr_file,
input [7:0] addr_file,
input [7:0] addr0,addr1,addr2,addr3,
output reg [7:0] instruction0,instruction1,instruction2,instruction3
);

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

ram[51]=ENALL;
ram[52]=MULTI;
ram[53]=MTACR;
ram[54]=ADDIT;
ram[55]=MACTA;

ram[56]=INCSJ;
ram[57]=MVSJR;
ram[58]=MCJAC;
ram[59]=SUBTR;
ram[60]=JUMNZ;
ram[61]=8'd28;

ram[62]=MTACR;
ram[63]=MVRAC;
ram[64]=MADAR;
ram[65]=STOAC;

ram[66]=RSTAC;
ram[67]=MACTA;
ram[68]=INCSK;
ram[69]=RSTSJ;
ram[70]=MVSKR;
ram[71]=MCKAC;
ram[72]=SUBTR;
ram[73]=JUMNZ;
ram[74]=8'd28;

ram[75]=ENALL;
ram[76]=INCSI;
ram[77]=MVSIR;
ram[78]=MCIAC;
ram[79]=SUBTR;
ram[80]=END;

ram[81]=INCSI;
ram[82]=MVSIR;
ram[83]=MCIAC;
ram[84]=SUBTR;
ram[85]=END;
ram[86]=INCSI;
ram[87]=MVSIR;
ram[88]=MCIAC;
ram[89]=SUBTR;
ram[90]=END;
ram[91]=RSTSJ;
ram[92]=RSTSK;
ram[93]=JUMNZ;
ram[94]=8'd28;

end


always @(posedge clock) 
begin
    if (write_en_file==1)
        ram[addr_file]<=instr_file;
    else
     begin
        instruction0 <= ram[addr0];
        instruction1 <= ram[addr1];
        instruction2 <= ram[addr2];
        instruction3 <= ram[addr3];
    end
end
endmodule