`include "IO.v"
`include "memory.v"
`include "DMA.v"
`include "CLK_ON_WIRE.v"
`include "MINI_CPU.v"
`include "keypad.v"
`include "MIPS_DMA_INTERFACE.v"


module DMAtb();
wire CLK;
CLK_ON_WIRE obj(CLK);
wire [7:0] DB;
wire [3:0] CB;
wire [7:0] AB;
wire [3:0] DREQ;
reg IO0_ENABLE;
reg I1_ENABLE;
wire HLDA,HRQ;
wire [3:0] DACK;
reg [7:0] key;
IO disk(IO0_ENABLE,DB,AB,CB,DREQ[0],DACK[0],CLK);
memory DATAMEM(AB,DB,CB,CLK);
//MINI_CPU acc(HRQ,HLDA);
DMA t_DMA(CLK,HLDA,DREQ,DB,AB,HRQ,DACK,CB);
keypad keys(DB,CB,AB,key,CLK,DACK[1],DREQ[1],I1_ENABLE);
CPU mips(CLK,DB,CB,AB,HLDA,HRQ);



initial begin

#10

IO0_ENABLE<=0;
key<=8;
I1_ENABLE<=0;


#10
IO0_ENABLE<=1;
#110
IO0_ENABLE<=0;
I1_ENABLE<=1;




end







endmodule