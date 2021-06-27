module processor (
    input clk,
    input [1:0] status0, status1 ,status2, status3, //Turn on each core
    input [15:0] dataout0,dataout1,dataout2,dataout3,//data from DM
    input [7:0] instruction0, instruction1, instruction2, instruction3,// instruction from IM

    output [7:0] addr_data_0,addr_data_1,addr_data_2,addr_data_3,//DM address
    output [7:0] addr_instruction_0,addr_instruction_1,addr_instruction_2,addr_instruction_3,//IM address
    output [15:0] datain0, datain1, datain2,datain3,//data to DM
    output write_en0 ,write_en1 ,write_en2 ,write_en3 ,// write enable signal for DM
    output [3:0] end_process// End of all process

    );

    core_0 core0
    (
        .clock(clk),                    
    	.write_en0(write_en0),               
        .addr_data_0(addr_data_0),
        .datain0(datain0),
        .dataout0(dataout0),
        .addr_instruction_0(addr_instruction_0),
        .instruction(instruction0),
        .end_process(end_process[3]),
        .status(status0)
    );

    core_1 core1
    (
        .clock(clk),                    
    	.write_en0(write_en1),               
        .addr_data_0(addr_data_1),
        .datain0(datain1),
        .dataout0(dataout1),
        .addr_instruction_0(addr_instruction_1),
        .instruction(instruction1),
        .end_process(end_process[2]),
        .status(status1)
    );

    core_2 core2
    (
        .clock(clk),                    
    	.write_en0(write_en2),               
        .addr_data_0(addr_data_2),
        .datain0(datain2),
        .dataout0(dataout2),
        .addr_instruction_0(addr_instruction_2),
        .instruction(instruction2),
        .end_process(end_process[1]),
        .status(status2)
    );

    core_3 core3
    (
        .clock(clk),                    
    	.write_en0(write_en3),               
        .addr_data_0(addr_data_3),
        .datain0(datain3),
        .dataout0(dataout3),
        .addr_instruction_0(addr_instruction_3),
        .instruction(instruction3),
        .end_process(end_process[0]),
        .status(status3)
    );
    

    
endmodule