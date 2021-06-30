module processor_test(output wire [3:0] end_process);
reg clock;
reg [1:0] status;
wire [15:0] dataout0,dataout1,dataout2,dataout3;
wire [7:0] instruction0, instruction1, instruction2, instruction3;
wire [7:0] addr_data_0,addr_data_1,addr_data_2,addr_data_3;
wire [7:0] addr_instruction_0,addr_instruction_1,addr_instruction_2,addr_instruction_3;
wire [15:0] datain0, datain1, datain2,datain3;
wire write_en0 ,write_en1 ,write_en2 ,write_en3;

processor processorTest(
	.clk(clock),
	.status0(status),
	.status1(status),
	.status2(status),
	.status3(status),
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
	.write_en0(write_en0),
	.write_en1(write_en1),
	.write_en2(write_en2),
	.write_en3(write_en3),
	.end_process(end_process)
);


data_memory_mod dm(
	.clock(clock),
	.write_en0(write_en0),
	.write_en1(write_en1),
	.write_en2(write_en2),
	.write_en3(write_en3),
	.addr0(addr_data_0),
	.addr1(addr_data_1),
	.addr2(addr_data_2),
	.addr3(addr_data_3),
	.datain0(datain0),
	.datain1(datain1),
	.datain2(datain2),
	.datain3(datain3),
	.dataout0(dataout0),
	.dataout1(dataout1),
	.dataout2(dataout2),
	.dataout3(dataout3)
);

instruction_memory_mod im(

	.clock(clock),
	.addr0(addr_instruction_0),
	.addr1(addr_instruction_1),
	.addr2(addr_instruction_2),
	.addr3(addr_instruction_3),
	.instruction0(instruction0),
	.instruction1(instruction1),
	.instruction2(instruction2),
	.instruction3(instruction3) 
);


always @(end_process)
begin
  $display("Sazni End");
  $display(end_process);
end

initial 
begin 
	clock = 0; 
	status=2'b01;
end 

always 
#5  clock =  ! clock; 
  
endmodule 