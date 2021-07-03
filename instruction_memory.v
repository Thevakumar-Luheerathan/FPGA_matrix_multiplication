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