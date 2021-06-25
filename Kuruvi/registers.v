module reg_1 ( //AR,IR,CI,CJ,CK
input clock,
input LD,
input [7:0] datain,
output reg [7:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        dataout<= datain;   
end
endmodule




module reg_2 (//DAR,PC
input clock,
input LD,
input INC,
input RST,
input [7:0] datain,
output reg [7:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        dataout<= datain;
    if (INC==1)
        dataout<= dataout + 8'd1; 
    if (RST==1)
        dataout<=8'd0;  
end
endmodule




module reg_3 (//R
input clock,
input LD,
input [15:0] datain,
output reg [15:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        dataout<= datain;   
end 
endmodule





module reg_4 (//TAC
input clock,
input LD,
input RST,
input [15:0] datain,
output reg [15:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        dataout<= datain;
    if (RST==1)
        dataout<= 16'd0;   
end   
endmodule

module reg_5 (//SI,SJ,SK
input clock,
input INC,
input RST,
output reg [7:0] dataout
);

always @(posedge clock) 
begin
if (INC==1)
    dataout<= dataout + 8'd1;
if (RST==1)
    dataout<= 8'd0;   
end
    
endmodule


module reg_6 (//AA,AB,AD
input clock,
input [7:0] datain,
output reg [7:0] dataout
);

always @(posedge clock) 
begin
    dataout<= datain;   
end   
endmodule

module reg_7 (//X
input clock,
input LD,
input [2:0] EN,
output reg [3:0] dataout
);

always @(posedge clock) 
begin
    if (LD==1)
        case (EN)
        3'b001:dataout<=4'b1000;
        3'b010:dataout<=4'b0100;
        3'b011:dataout<=4'b0010;
        3'b100:dataout<=4'b0001;
        3'b111:dataout<=4'b1111;
        endcase
end
    
endmodule


