module core2 
    (
    input clock,                    // CLOCK

    output write_en2,               /* Data Memory */
    output [7:0] addr_data_2,
    output [15:0] datain2,
    input reg [15:0] dataout2,

    output [7:0] addr_instruction_2,/* Instruction Memory */
    input reg [7:0] instruction
    );

    // ##### Inner connections = Wires ##### //
    wire [15:0] alu_out;            // ALU => AC
    wire [15:0] alu_ac;             // AC, ALU => Bus = 2
    wire [15:0] busout;             // Bus=10 => ALU, CI, CJ, CK, TAC, R, PC, IR, DAR, AR
    wire [7:0] dataout_ci;          // CI => address_module & Bus
    wire [7:0] dataout_cj;          // CJ => address_module & Bus 
    wire [7:0] dataout_ck;          // CK => address_module & Bus 
    wire [7:0] dataout_si;          // SI => address_module & Bus
    wire [7:0] dataout_sj;          // SJ => address_module & Bus
    wire [7:0] dataout_sk;          // SK => address_module & Bus
    wire [7:0] datain_aa;           // address_module => AA 
    wire [7:0] datain_ab;           // address_module => AB
    wire [7:0] datain_ad;           // address_module => AD
    wire [7:0] dataout_aa;          // AA => Bus
    wire [7:0] dataout_ab;          // AB => Bus
    wire [7:0] dataout_ad;          // AD => Bus
    wire [15:0] dataout_tac;        // TAC => BUS
    wire [15:0] dataout_r;          // R => BUS
    wire [7:0] dataout_ir;          // IR => BUS
    wire [7:0] dataout_pc;          // PC => BUS
    
    /* AC  --* */
    AC ac 
    (
        .clock(clock),
        .LD(),                      // <= Control Unit
        .RST(),                     // <= Control Unit
        .alu_out(alu_out),          // <= ALU
        .dataout(alu_ac),           // => Bus
        .z()                        // => Bus *
    );

    /* address_module */
    address_module am
    (
        .CI(dataout_ci),            // <= CI
        .CJ(dataout_cj),            // <= CJ
        .CK(dataout_ck),            // <= CK
        .SI(dataout_si),            // <= SI
        .SJ(dataout_sj),            // <= SJ
        .SK(dataout_sk),            // <= SK
        .AA(datain_aa),             // => AA
        .AB(datain_ab),             // => AB
        .AD(datain_ad)              // => AD
    );
    
    /* ALU - */
    ALU alu 
    (
        .in1(alu_ac),               // <= AC
        .in2(busout),               // <= Bus
        .alu_op(),                  // <= Control Unit
        .alu_out(alu_out)           // => AC
    );
    
    /* BUS */
    BUS bus 
    (
        .clock(clock),
        .read(dataout2),             // <= DATA MEMORY {READ} .....
        .IM(instruction),            // <= INSTRUCTION MEMORY {INSTRUCTION} .....
        .DM(datain2),                // <= DATA MEMORY {WRITE} .....
        .IR(dataout_ir),             // <= IR
        .PC(dataout_pc),             // <= PC
        .TAC(dataout_tac),           // <= TAC
        .R(dataout_r),               // <= R
        .AA(dataout_aa),             // <= AA
        .AB(dataout_ab),             // <= AB
        .AD(dataout_ad),             // <= AD
        .ALU(alu_ac),                // => ALU
        //.AR(),
        //.DAR(),
        .CI(dataout_ci),             // <= CI
        .CJ(dataout_cj),             // <= CJ
        .CK(dataout_ck),             // <= CK
        .SI(dataout_si),             // <= SI
        .SJ(dataout_sj),             // <= SJ
        .SK(dataout_sk),             // <= SK
        .AC(alu_ac),                 // => AC
        .busout(busout)              // => ALU, CI, CJ, CK, TAC, R, PC, IR, DAR, AR
    );
    
    /* AR - */
    reg_1 ar 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(addr_instruction_2)    // => INSTRUCTION MEMORY {ADRESS} .....
    );
    
    /* DAR --- */
    reg_2 dar 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .INC(),                         // <= Control Unit
        .RST(),                         // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(addr_data_2)           // => DATA MEMORY {ADRESS} .....
    );
    
    /* IR - */
    reg_1 ir 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_ir)            // => Bus
    );
    
    /* PC --- */
    reg_2 pc 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .INC(),                         // <= Control Unit
        .RST(),                         // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_pc)            // => Bus
    );
    
    /* TAC -- */
    reg_4 tac 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .RST(),                         // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_tac)           // => Bus
    );
    
    /* R - */
    reg_3 r 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_r)             // => Bus
    );
    
    /* CI - */
    reg_1 ci 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_ci)            // => address_module, Bus
    );
    
    /* CJ - */
    reg_1 cj 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_cj)            // => address_module, Bus
    );
    
    /* CK - */
    reg_1 ck 
    (
        .clock(clock),
        .LD(),                          // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_ck)            // => address_module, Bus
    );
    
    /* AA */
    reg_6 aa 
    (
        .clock(clock),
        .datain(datain_aa),             // <= adress_module
        .dataout(dataout_aa)            // => Bus
    );
    
    /* AB */
    reg_6 ab 
    (
        .clock(clock),
        .datain(datain_ab),             // <= adress_module
        .dataout(dataout_ab)            // => Bus
    );
    
    /* AD */
    reg_6 ad 
    (
        .clock(clock),
        .datain(datain_ad),             // <= adress_module
        .dataout(dataout_ad)            // => Bus
    );
    
    /* SI -- */
    reg_5 si 
    (
        .clock(clock),
        .INC(),                         // <= Control Unit
        .RST(),                         // <= Control Unit
        .dataout(dataout_si)            // => address_module, Bus
    );
    
    /* SJ -- */
    reg_5 sj
    (
        .clock(clock),
        .INC(),                         // <= Control Unit
        .RST(),                         // <= Control Unit
        .dataout(dataout_sj)            // => address_module, Bus
    );
    
    /* SK -- */
    reg_5 sk 
    (
        .clock(clock),
        .INC(),                         // <= Control Unit
        .RST(),                         // <= Control Unit
        .dataout(dataout_sk)            // => address_module, Bus
    );

    // CU //

endmodule