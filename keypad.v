module keypad ( 
DB,
CB,
AB,
key,
CLK,
DACK,
DREQ,
IO_EN

);
inout [7:0] DB;
inout [3:0] CB;
inout [7:0] AB;
input [7:0] key;
input IO_EN;
input CLK;
input DACK;
output reg DREQ;
reg [4:0] buff;
assign CB = 8'bzzzzzzzz;
assign AB = 8'bzzzzzzzz;
assign DB = (CB[3]&&(DACK===1)&&(IO_EN===1))?(buff):8'bzzzzzzzz;

always @(IO_EN)
begin
DREQ<=IO_EN;
end


always @(posedge CLK)
begin
    case(key)
    8'b00000001 : buff<=1;
    8'b00000010 : buff<=2;
    8'b00000100 : buff<=3;
    8'b00001000 : buff<=4;
    8'b00010000 : buff<=5;
    8'b00100000 : buff<=6;
    8'b01000000 : buff<=7;
    8'b10000000 : buff<=8;
    default     : buff<=0;

endcase

end   


endmodule