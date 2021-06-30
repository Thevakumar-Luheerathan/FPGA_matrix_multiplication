module core0_test(output wire end_process);
reg clock;
wire write_en0;               
wire [7:0] addr_data_0;
wire [15:0] datain0;
wire [15:0] dataout0;
wire [7:0] addr_instruction_0;
wire [7:0] instruction;
reg [1:0] status;

core_0 core(
	.clock(clock),
	.write_en0(write_en0),               
	.addr_data_0(addr_data_0),
	.datain0(datain0),
	.dataout0(dataout0),
	.addr_instruction_0(addr_instruction_0),
	.instruction(instruction),

	.end_process(end_process),
	.status(status)
);


data_memory_mod dm(
	.clock(clock),
	.write_en0(write_en0),
	.addr0(addr_data_0),
	.datain0(datain0),
	.dataout0(dataout0)
);

instruction_memory_mod im(

	.clock(clock),
	.addr0(addr_instruction_0),
	.instruction0(instruction)
);


always @(end_process)
begin
  $display("Sazni End");
end

initial 
begin 
	clock = 0; 
	status=2'b01;
end 

always 
#5  clock =  ! clock; 
  
endmodule 