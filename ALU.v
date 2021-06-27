module ALU (
input [15:0] in1,
input [15:0] in2,
input [1:0] alu_op,
output reg [15:0] alu_out
);

always @(*) 
begin
    case (alu_op)
    2'd0: alu_out <= in1+in2;
    2'd1: alu_out <= in1*in2;
    2'd2: alu_out <= in1-in2;
    2'd3: alu_out <= in2;
    endcase 
end
    
endmodule