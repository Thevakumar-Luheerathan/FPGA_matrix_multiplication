module core0 
    (
    input clock,                    // CLOCK

    output write_en1,               /* Data Memory */
    output [7:0] addr_data_1,
    output [15:0] datain1,
    input reg [15:0] dataout1,

    output [7:0] addr_instruction_1,/* Instruction Memory */
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
    wire [0] Z;                     // AC => Z => Control Unit
    wire [33:0] control_signal;     // Control Unit => Bus
    wire [3:0] x_xc;                // X => Control Unit
    
    /* AC */
    AC ac 
    (
        .clock(clock),
        .LD(control_signal),        // <= Control Unit
        .RST(control_signal),       // <= Control Unit
        .alu_out(alu_out),          // <= ALU
        .dataout(alu_ac),           // => Bus
        .z(Z)                       // z => Control Unit
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
    
    /* ALU */
    ALU alu 
    (
        .in1(alu_ac),               // <= AC
        .in2(busout),               // <= Bus
        .alu_op(control_signal),    // <= Control Unit
        .alu_out(alu_out)           // => AC
    );
    
    /* BUS */
    BUS bus 
    (
        .clock(clock),
        .read(control_signal),       // <= Control Unit
        .IM(instruction),            // <= INSTRUCTION MEMORY {INSTRUCTION}
        .DM(dataout1),               // <= DATA MEMORY {READ}
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
        assign datain1 = busout      // => DATA MEMORY {WRITE}
    );
    
    /* AR */
    reg_1 ar 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(addr_instruction_1)    // => INSTRUCTION MEMORY {ADRESS}
    );
    
    /* DAR */
    reg_2 dar 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .INC(control_signal),           // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(addr_data_1)           // => DATA MEMORY {ADRESS}
    );
    
    /* IR */
    reg_1 ir 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_ir)            // => Bus
    );
    
    /* PC */
    reg_2 pc 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .INC(control_signal),           // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_pc)            // => Bus
    );
    
    /* TAC */
    reg_4 tac 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_tac)           // => Bus
    );
    
    /* R */
    reg_3 r 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_r)             // => Bus
    );
    
    /* CI */
    reg_1 ci 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_ci)            // => address_module, Bus
    );
    
    /* CJ */
    reg_1 cj 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .datain(busout),                // <= Bus
        .dataout(dataout_cj)            // => address_module, Bus
    );
    
    /* CK */
    reg_1 ck 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
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
    
    /* SI */
    reg_5 si 
    (
        .clock(clock),
        .INC(control_signal),           // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .dataout(dataout_si)            // => address_module, Bus
    );
    
    /* SJ */
    reg_5 sj
    (
        .clock(clock),
        .INC(control_signal),           // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .dataout(dataout_sj)            // => address_module, Bus
    );
    
    /* SK */
    reg_5 sk 
    (
        .clock(clock),
        .INC(control_signal),           // <= Control Unit
        .RST(control_signal),           // <= Control Unit
        .dataout(dataout_sk)            // => address_module, Bus
    );

    /* X */
    reg_7 x 
    (
        .clock(clock),
        .LD(control_signal),            // <= Control Unit
        .EN(control_signal),            // <= Bus
        .dataout(x_xc)                  // => Control Unit
    );

    /* CU ? */
    control_unit cu
    (
        .clk(clock),
        .z(Z),                          // <= z <= AC
        .ins(instruction),              // <= INSTRUCTION MEMORY {INSTRUCTION}
        .xc(x_xc),                      // <= X
        .status(),                      // <= ???????????????????????????????????????????????????????
        .end_process(write_en1),        // => DATA MEMORY {ENABLING_WRITE}
        .control_signal(control_signal) // => Bus
    );

endmodule