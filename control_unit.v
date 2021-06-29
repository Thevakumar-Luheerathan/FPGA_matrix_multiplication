module control_unit (
    input z,
    input [7:0] ins,
    input xc,
    input clk,
    input [1:0] status,
    output reg end_process,
    output reg [33:0] control_signal
);

reg [7:0] present=8'd44;
reg [7:0] next=8'd44;


parameter start1=8'd0;
parameter fetch1=8'd1;
parameter fetch2=8'd2;
parameter rstall1=8'd8;
parameter lodac1=8'd9;
parameter lodac2=8'd10;
parameter macci1=8'd11;
parameter maccj1=8'd12;
parameter macck1=8'd13;
parameter mvskr1=8'd14;
parameter mvsir1=8'd15;
parameter mvsjr1=8'd16;
parameter mciac1=8'd17;
parameter mcjac1=8'd18;
parameter mckac1=8'd19;
parameter maaar1=8'd20;
parameter mvacr1=8'd21;
parameter mabar1=8'd22;
parameter mtacr1=8'd23;
parameter macta1=8'd24;
parameter mvrac1=8'd25;
parameter madar1=8'd26;
parameter stoac1=8'd27;
parameter rstac1=8'd28;
parameter rstsj1=8'd29;
parameter rstsk1=8'd30;
parameter incsi1=8'd31;
parameter incsj1=8'd32;
parameter incsk1=8'd33;
parameter subtr1=8'd34;
parameter multi1=8'd35;
parameter addit1=8'd36;
parameter en01=8'd3;
parameter en11=8'd4;
parameter en21=8'd5;
parameter en31=8'd6;
parameter enall1=8'd7;
parameter nop1=8'd37;
parameter endy1=8'd38;
parameter endn1=8'd39;
parameter jumnzy1=8'd40;
parameter jumnzy2=8'd42;
parameter jumnzy3=8'd43;
parameter jumnzn1=8'd41;
parameter idle=8'd44;

parameter start1_cs = 34'b0000000000000000000000000000000010;
parameter fetch1_cs = 34'b1000000000000000000000000000010000;
parameter fetch2_cs = 34'b0000101000000000000000000000000100;
parameter rstall1_cs = 34'b0000000010000101010000000000000001;
parameter lodac1_cs = 34'b0000000000000000000100000110001000;
parameter lodac2_cs = 34'b0001000000000000000000000000000000;
parameter macci1_cs = 34'b0000000000100000000000000001000000;
parameter maccj1_cs = 34'b0000000000010000000000000001000000;
parameter macck1_cs = 34'b0000000000001000000000000001000000;
parameter mvskr1_cs = 34'b0000000001000000000000000000111100;
parameter mvsir1_cs = 34'b0000000001000000000000000000110100;
parameter mvsjr1_cs = 34'b0000000001000000000000000000111000;
parameter mciac1_cs = 34'b0000000000000000000100000110011100;
parameter mcjac1_cs = 34'b0000000000000000000100000110100000;
parameter mckac1_cs = 34'b0000000000000000000100000110100100;
parameter maaar1_cs = 34'b0010000000000000000000000000101000;
parameter mvacr1_cs = 34'b0000000001000000000000000001000000;
parameter mabar1_cs = 34'b0010000000000000000000000000101100;
parameter mtacr1_cs = 34'b0000000001000000000000000000010100;
parameter macta1_cs = 34'b0000000100000000000000000001000000;
parameter mvrac1_cs = 34'b0000000000000000000100000110011000;
parameter madar1_cs = 34'b0010000000000000000000000000110000;
parameter stoac1_cs = 34'b0100000000000000000000000001000000;
parameter rstac1_cs = 34'b0000000000000000000010000000000000;
parameter rstsj1_cs = 34'b0000000000000001000000000000000000;
parameter rstsk1_cs = 34'b0000000000000000010000000000000000;
parameter incsi1_cs = 34'b0000000000000010000000000000000000;
parameter incsj1_cs = 34'b0000000000000000100000000000000000;
parameter incsk1_cs = 34'b0000000000000000001000000000000000;
parameter subtr1_cs = 34'b0000000000000000000100000100011000;
parameter multi1_cs = 34'b0000000000000000000100000010011000;
parameter addit1_cs = 34'b0000000000000000000100000000011000;
parameter jumnzy1_cs = 34'b1000000000000000000000000000010000;
parameter jumnzy2_cs = 34'b0000100000000000000000000000000100;
parameter jumnzy3_cs = 34'b0000010000000000000000000000001100;
parameter jumnzn1_cs = 34'b0000001000000000000000000000000000;
parameter en01_cs = 34'b0000000000000000000001001000000000;
parameter en11_cs = 34'b0000000000000000000001010000000000;
parameter en21_cs = 34'b0000000000000000000001011000000000;
parameter en31_cs = 34'b0000000000000000000001100000000000;
parameter enall1_cs = 34'b0000000000000000000001111000000000;
parameter endy1_cs = 34'b0000000000000000000000000000000000;
parameter endn1_cs = 34'b0000000000000000000000000000000000;
parameter nop1_cs = 34'b0000000000000000000000000000000000;
parameter idle_cs=34'b0000000000000000000000000000000000;

always @(posedge clk)
begin
    present<=next;
end

always @(posedge clk)
begin
    if (present==endy1)
        end_process<=1'b1;
    else
        end_process<=1'b0;
end

always @(present or z or xc or status or ins) begin
    case(present)
    idle:begin
        control_signal<=idle_cs;

        if (status == 2'b01)
            next<=start1;
        else
            next<=idle;
    end

    start1:begin
        control_signal<=start1_cs;
        next<=fetch1;
    end

    fetch1:begin
        control_signal<=fetch1_cs;
        next<=fetch2;
    end

    fetch2:begin
        control_signal<= fetch2_cs;

        if (ins <= 8'd7)
            next<=ins;
        else if((ins > 8'd7) && (xc==1'b0) )
            next<=nop1;
        else if ((ins > 8'd7) && (ins< 8'd37) && (xc==1'b1))
            next<=ins;
        else if (((ins==8'd38) || (ins==8'd40)) && (xc==1'b1))
            next=ins+z;
    end

    rstall1:begin
        control_signal<=rstall1_cs;
        next<=fetch1;
    end

    lodac1:begin
        control_signal<=lodac1_cs;
        next<=lodac2;
    end

    lodac2:begin
        control_signal<=lodac2_cs;
        next<=fetch1;
    end

    macci1:begin
        control_signal<=macci1_cs;
        next<=fetch1;
    end

    maccj1:begin
        control_signal<=maccj1_cs;
        next<=fetch1;
    end

    macck1:begin
        control_signal<=macck1_cs;
        next<=fetch1;
    end

    mvskr1:begin
        control_signal<=mvskr1_cs;
        next<=fetch1;
    end

    mvsir1:begin
        control_signal<=mvsir1_cs;
        next<=fetch1;
    end

    mvsjr1:begin
        control_signal<=mvsjr1_cs;
        next<=fetch1;
    end

    mciac1:begin
        control_signal<=mciac1_cs;
        next<=fetch1;
    end


    mcjac1:begin
        control_signal<=mcjac1_cs;
        next<=fetch1;
    end

    mckac1:begin
        control_signal<=mckac1_cs;
        next<=fetch1;
    end

    maaar1:begin
        control_signal<=maaar1_cs;
        next<=fetch1;
    end
    mvacr1:begin
        control_signal<=mvacr1_cs;
        next<=fetch1;
    end
    mabar1:begin
        control_signal<=mabar1_cs;
        next<=fetch1;
    end
    mtacr1:begin
        control_signal<=mtacr1_cs;
        next<=fetch1;
    end
    macta1:begin
        control_signal<=macta1_cs;
        next<=fetch1;
    end
    mvrac1:begin
        control_signal<=mvrac1_cs;
        next<=fetch1;
    end
    madar1:begin
        control_signal<=madar1_cs;
        next<=fetch1;
    end
    stoac1:begin
        control_signal<=stoac1_cs;
        next<=fetch1;
    end
    rstac1:begin
        control_signal<=rstac1_cs;
        next<=fetch1;
    end
    rstsj1:begin
        control_signal<=rstsj1_cs;
        next<=fetch1;
    end
    rstsk1:begin
        control_signal<=rstsk1_cs;
        next<=fetch1;
    end
    incsi1:begin
        control_signal<=incsi1_cs;
        next<=fetch1;
    end
    incsj1:begin
        control_signal<=incsj1_cs;
        next<=fetch1;
    end
    incsk1:begin
        control_signal<=incsk1_cs;
        next<=fetch1;
    end
    subtr1:begin
        control_signal<=subtr1_cs;
        next<=fetch1;
    end
    multi1:begin
        control_signal<=multi1_cs;
        next<=fetch1;
    end
    addit1:begin
        control_signal<=addit1_cs;
        next<=fetch1;
    end
    en01:begin
        control_signal<=en01_cs;
        next<=fetch1;
    end
    en11:begin
        control_signal<=en11_cs;
        next<=fetch1;
    end
    en21:begin
        control_signal<=en21_cs;
        next<=fetch1;
    end
    en31:begin
        control_signal<=en31_cs;
        next<=fetch1;
    end
    enall1:begin
        control_signal<=enall1_cs;
        next<=fetch1;
    end
    nop1:begin
        control_signal<=nop1_cs;
        next<=fetch1;
    end
    endy1:begin
        control_signal<=endy1_cs;
    end
    endn1:begin
        control_signal<=endn1_cs;
        next<=fetch1;
    end
    jumnzy1:begin
        control_signal<=jumnzy1_cs;
        next<=jumnzy2;
    end
    jumnzy2:begin
        control_signal<=jumnzy2_cs;
        next<=jumnzy3;
    end
    jumnzy3:begin
        control_signal<=jumnzy3_cs;
        next<=fetch1;
    end
    jumnzn1:begin
        control_signal<=jumnzn1_cs;
        next<=fetch1;
    end
    default:begin
        control_signal=idle_cs;
        next<=idle;
    end

    endcase
    
end



    
endmodule