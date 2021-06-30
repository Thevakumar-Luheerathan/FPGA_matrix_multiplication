`timescale 10ps / 1ps
module simulation;
    parameter mem_write = 2'd1;
    parameter processing = 2'd2;
    parameter mem_read =2'd3 ;


    reg clk;
    reg[1:0] state;

    reg [1:0] status0, status1 ,status2, status3; //Turn on each core
    wire [15:0] dataout0,dataout1,dataout2,dataout3;//data from DM
    wire [7:0] instruction0, instruction1, instruction2, instruction3;// instruction from IM

    wire [7:0] addr_data_0,addr_data_1,addr_data_2,addr_data_3;//DM address
    wire [7:0] addr_instruction_0,addr_instruction_1,addr_instruction_2,addr_instruction_3;//IM address
    wire [15:0] datain0, datain1, datain2,datain3;//data to DM
    wire write_data_en0 ,write_data_en1 ,write_data_en2 ,write_data_en3 ;// write enable signal for DM
    wire [3:0] end_process;

    reg instr_wr_en_file;
    reg data_wr_en_file;
    reg [7:0] instr_addr_file=8'b0;
    reg [7:0] data_addr_file=8'b0;
    reg [15:0] data_file;
    reg [7:0] instr_file;

    integer data_txt_file;
    integer instr_txt_file;
    integer data_scan_file;
    integer instr_scan_file;

    always begin //clk defined
        #10 clk = !clk;
    end

    initial begin
        clk<=1'b0;
        state<=mem_write;
        data_file = $fopen("data_file.txt", "r");
        if (data_file == 0) begin
            $display("data_file handle was NULL");
            $finish;
        end
    end

    processor processor1 (
    .clk(clk),
    .status0(status0),
    .status1(status1),
    .status2(status2),
    .status3(status3),
    .dataout0(dataout0),
    .dataout1(dataout1),
    .dataout2(dataout2),
    .dataout3(dataout3),
    .instruction0(instruction0),
    .instruction1(instruction1),
    .instruction2(instruction2),
    .instruction3(instruction3),
    .addr_data_0(addr_data_0),
    .addr_data_1(addr_data_1),
    .addr_data_2(addr_data_2),
    .addr_data_3(addr_data_3),
    .addr_instruction_0(addr_instruction_0),
    .addr_instruction_1(addr_instruction_1),
    .addr_instruction_2(addr_instruction_2),
    .addr_instruction_3(addr_instruction_3),
    .datain0(datain0),
    .datain1(datain1),
    .datain2(datain2),
    .datain3(datain3),
    .write_en0 (write_data_en0),
    .write_en1 (write_data_en1),
    .write_en2 (write_data_en2),
    .write_en3 (write_data_en3),
    .end_process(end_process)
    );


    data_memory data_memory1 (
    .clock(clk),
    .write_en_file(data_wr_en_file),
    .data_file(data_file),
    .addr_file(data_addr_file),
    .write_en0(write_data_en0),
    .write_en1(write_data_en1),
    .write_en2(write_data_en2),
    .write_en3(write_data_en3),
    .addr0(addr_data_0),
    .addr1(addr_data_1),
    .addr2(addr_data_2),
    .addr3(addr_data_3),
    .datain0(datain0),
    .datain1(datain1),
    .datain2(datain2),
    .datain3(datain3),
    .dataout0(dataout0),
    .dataout1(dataout0),
    .dataout2(dataout0),
    .dataout3(dataout0)
    );

    instruction_memory instruction_memory1(
    .clock(clk),
    .write_en_file(instr_wr_en_file),
    .instr_file(instr_file),
    .addr_file(instr_addr_file),
    .addr0(addr_instruction_0),
    .addr1(addr_instruction_1),
    .addr2(addr_instruction_2),
    .addr3(addr_instruction_3),
    .instruction0(instruction0),
    .instruction1(instruction1),
    .instruction2(instruction2),
    .instruction3(instruction3)
    );
    
   always @(posedge clk) begin
       if (state==mem_write)begin
           data_wr_en_file<=1'b1;
           data_scan_file = $fscanf(data_file, "%d\n", data_file);
           if (!$feof(data_file)) begin
               
           end
       end
   end
endmodule