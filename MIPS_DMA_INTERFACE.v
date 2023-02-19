module registerfile(Read1,Read2,WriteReg, 
WriteData, RegWrite, Data1,Data2,Clock);
input [4:0] Read1,Read2,WriteReg; 
input [31:0] WriteData;
input RegWrite, Clock;
output[31:0] Data1, Data2;
reg[ 31:0] RF [31:0];
assign Data1 = RF[Read1];
assign Data2 = RF[Read2];
always @(posedge Clock)
if(RegWrite) RF[WriteReg] = WriteData;
initial begin
    /* for the testbench initial values assumption in memory */
    RF[0] = 5;
    RF[1] = 3;
    

end
endmodule
// Next Module is CPU where we use also register file
module CPU (clock,DB,CB,AB,HLDA,HLDR);
input clock;
inout [7:0] DB;
inout [7:0] AB;
inout [3:0] CB;
input HLDR ;
output reg HLDA;

reg[31:0] PC, Regs[0:31], IMemory[0:1023],DMemory[0:1023], IR,ALUOut;
wire [4:0] rs, rt;
wire [31:0] Ain, Bin;
wire [5:0] op;
assign rs = IR[25:21];
assign rt = IR[20:16];
assign rd = IR[15:11];
assign shift = IR[10:6];
assign op = IR[31:26];
assign DB = ((IR[31:26]===32))? (Bin[7:0]) : 8'bzzzzzzzz;
assign AB = ((IR[31:26]===32))? (Ain[7:0] + IR[7:0]) : 8'bzzzzzzzz;
assign CB = ((IR[31:26]===32))? (4'b1001) : 4'bzzzz;
registerfile rf(rs,rt,rd,ALUout,1,Ain,Bin,clock); // make an object of registerFile

initial begin
PC = 0;


IMemory[0] = 32'd2149580860;
IMemory[1] = 32'd69664;
IMemory[2]= 32'd69668;
IMemory[3]= 32'd69666;
IMemory[4]= 32'd69669;
            
end
always @ (posedge clock)
begin
    if(!(IR[31:26]===32)&&(HLDR===1)) begin /* check no memory operation is using the bus to write to the memory */
        HLDA<=1;
    end
IR <= IMemory[PC>>2];
   
PC <= PC + 4; 




case( IR[31:26] )  // Check for Format 0 For R format
0: 
case (IR[5:0])
0  : ALUOut <= Ain<<shift; 
2 :  ALUOut <= Ain >> shift;
32 : ALUOut <= Ain + Bin; 
37 : ALUOut <= Ain | Bin; 
34 : ALUOut <= Ain - Bin;
38 : ALUOut <= Ain ^ Bin;
36 : ALUOut <= Ain & Bin;
39 : ALUOut <= ~(Ain |Bin);



endcase     // the following are non R format as immediates and loads and jumps
8 :  ALUOut <= Bin+ IR[15:0];
12 : ALUOut <= Bin&IR[15:0];
13 : ALUOut <= Bin | IR[15:0];
14 :  ALUOut <= Bin ^ IR[15:0];	
35 : IR[20:16] <= DMemory [ IR[25:21] +  IR[15:0] ]; // Load word
43 : DMemory [ IR[25:21] +  IR[15:0] ] <= IR[20:16]; // Store word


endcase


end
endmodule





