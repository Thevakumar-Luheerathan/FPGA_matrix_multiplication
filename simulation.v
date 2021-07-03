`timescale 10ps / 1ps
module simulation();
    parameter mem_write = 2'd1;
    parameter processing = 2'd2;
    parameter mem_read =2'd3 ;


    reg clk;
    reg[1:0] state;

    reg [1:0] status0, status1 ,status2, status3; //Turn on each core
    wire [15:0] dataout_file,dataout0,dataout1,dataout2,dataout3;//data from DM
    wire [7:0] instruction0, instruction1, instruction2, instruction3;// instruction from IM

    wire [3:0] end_process;
    wire [7:0] addr_data_0,addr_data_1,addr_data_2,addr_data_3;//DM address
    wire [7:0] addr_instruction_0,addr_instruction_1,addr_instruction_2,addr_instruction_3;//IM address
    wire [15:0] datain0, datain1, datain2,datain3;//data to DM
    wire write_data_en0 ,write_data_en1 ,write_data_en2 ,write_data_en3 ;// write enable signal for DM
    //wire [3:0] end_process;

    reg instr_wr_en_file;
    reg data_wr_en_file;
    reg [7:0] instr_addr_file=8'b11111111;
    reg [7:0] data_addr_file=8'b11111111;
    reg [15:0] data_file;
    reg [7:0] instr_file;
    reg [15:0] captured_data;
    reg [7:0] captured_ins;
    reg data_done=1'd0;
    reg ins_done=1'd0;
    reg [3:0] eof_core;

    integer data_txt_file;
    integer instr_txt_file;
    integer data_scan_file;
    integer instr_scan_file;

    //reg[8:0] data_file_name="data.txt";
    //reg[8:0] ins_file_name="ins4.txt";
    integer core_count=4;
    integer count=0;
    reg[7:0] c_i,c_j,c_k;

    always begin //clk defined
        #10 clk = !clk;
    end

    initial begin
        clk<=1'b0;
        state<=mem_write;
        data_txt_file = $fopen("data.txt", "r+");
        if (data_txt_file == 0) begin
            $display("data_file handle was NULL");
            $finish;
        end
        instr_txt_file=$fopen("ins4.txt", "r");
        if (instr_txt_file == 0) begin
            $display("instr_file handle was NULL");
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
    .dataout_file(dataout_file),
    .dataout0(dataout0),
    .dataout1(dataout1),
    .dataout2(dataout2),
    .dataout3(dataout3)
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
           data_scan_file = $fscanf(data_txt_file, "%d\n", captured_data);
           if (!$feof(data_txt_file) && data_done==1'd0) begin
               data_file<=captured_data;
               data_addr_file<=data_addr_file+1'd1;
               if(count==8'd0)begin
                   c_i<=captured_data;
                   count<=count+8'd1;
               end
               else if (count==8'd1)begin
                   c_j<=captured_data;
                   count<=count+8'd1;
               end
               else if (count==8'd2)begin
                   c_k<=captured_data;
                   count<=count+8'd1;
               end
           end
           else if(data_done==1'd0) begin
                data_file<=captured_data;
                data_addr_file<=data_addr_file+1'd1;
                data_done<=1'd1;  
           end
                
           instr_wr_en_file<=1'b1;
           instr_scan_file = $fscanf(instr_txt_file, "%d\n", captured_ins);
           if (!$feof(instr_txt_file) && ins_done==1'd0) begin
               instr_file<=captured_ins;
               instr_addr_file<=instr_addr_file+1'd1;
           end
           else if (ins_done==1'd0)begin
                instr_file<=captured_ins;
                instr_addr_file<=instr_addr_file+1'd1;
                ins_done<=1'd1;
           end
           if ((ins_done & data_done)==1'd1)begin
                state<=processing;
                data_wr_en_file<=1'b0;
                instr_wr_en_file<=1'b0;
                data_addr_file<=8'b0;
           end
       end
       if (state==processing)begin
           
           if (core_count==4)begin
                status0 <=2'b01;
                status1 <=2'b01;
                status2 <=2'b01;
                status3 <=2'b01;
                eof_core<=4'b1111;
           end
           if (core_count==3)begin
                status0 <=2'b01;
                status1 <=2'b01;
                status2 <=2'b01;
                status3 <=2'b00;
                eof_core<=4'b1110;
           end
           if (core_count==2)begin
                status0 <=2'b01;
                status1 <=2'b01;
                status2 <=2'b00;
                status3 <=2'b00;
                eof_core<=4'b1100;
           end
           if (core_count==1)begin
                status0 <=2'b01;
                status1 <=2'b00;
                status2 <=2'b00;
                status3 <=2'b00;
                eof_core<=4'b1000;
           end
           
       end
       if (end_process==eof_core && state==processing)begin
            state<= mem_read;           
           //storing data
       end
       if (state==mem_read)begin
           if(data_addr_file<c_i*c_j*c_k)begin
               $fdisplay(data_txt_file,dataout_file);
           end
           data_addr_file<=data_addr_file+1'd1;
       end
   end
endmodule