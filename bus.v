module Bus (
input clock,
input [4:0] read,
input [7:0] IM,
input [15:0] DM,
input [7:0]  IR,
input [7:0]  PC,
input [15:0] TAC,
input [15:0] R,
input [7:0] AA,
input [7:0] AB,
input [7:0] AD,
input [7:0] ALU,
input [7:0] AR,
input [7:0] DAR,
input [7:0] CI,
input [7:0] CJ,
input [7:0] CK,
input [7:0] SI,
input [7:0] SJ,
input [7:0] SK,
input [15:0] AC,
output reg [15:0] busout
);

always @(read or IM or DM or IR or PC or TAC or R or AA or AB or AD or AR or DAR or CI or CJ or CK or SI or SJ or SK or AC ) 
begin
    case (read) 
    5'd1: busout <= IM + 16'd0;
    5'd2: busout <= DM + 16'd0;
    5'd3: busout <= IR + 16'd0;
    5'd4: busout <= PC + 16'd0;
    5'd5: busout <= TAC;
    5'd6: busout <= R;
    5'd7: busout <= CI + 16'd0;
    5'd8: busout <= CJ + 16'd0;
    5'd9: busout <= CK + 16'd0;
    5'd10: busout <= AA + 16'd0;
    5'd11: busout <= AB + 16'd0;
    5'd12: busout <= AD + 16'd0;
    5'd13: busout <= ALU + 16'd0;
    5'd14: busout <= SI + 16'd0;
    5'd15: busout <= SJ + 16'd0; 
    5'd16: busout <= SK + 16'd0;
    5'd17: busout <= AC; 
    default: busout <= 16'd0;
    endcase  
end
    
endmodule