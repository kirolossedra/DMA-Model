module DMA (
    CLK,
    HLDA,
    DREQ,
    DB,
    AB,
    HRQ,
    DACK,CB
);
input  CLK,HLDA;
input  [3:0] DREQ;
inout [7:0] DB;
inout [7:0] AB;
inout [3:0] CB;
output reg [3:0] DACK;
output reg HRQ;
reg [7:0] TC;
reg [3:0] CR;


reg [7:0]COMMAND_R ;

assign AB = (HLDA===1)?(0+TC):8'bzzzzzzzz;
assign CB = (HLDA===1)?(CR):4'bzzzz;


/* REMAINING TO DEFINE :
nIOW
nIORnEOP
ASTDB
DB
 */



initial begin
/*  |
    | 
    | 0 for controller enable 
    | 0 for normal timing 
    | 0 for fixed Priority
    |
    |  0 DREQ ACTIVE High
    |  1 so we use DACK active high

 */    COMMAND_R= 8'b10000000; 
    

    /* INITIALLY NO SERVICE IS REQUESTING THE BUS */
    HRQ = 0; 
	TC=0;


    /* SENSE IS OBTAINED FROM BIT 7 OF COMMAND REGISTER */
    DACK = (COMMAND_R[7])? 4'b0000 : 4'b1111;
    CR = 4'b0110;


end

always @(posedge CLK)
begin      /* for fixed priority  DREQ0 has highest Priority and as you increase
index priority Decreases */
	if(DREQ)begin
	HRQ<=1;

end

    if(HLDA)
	 begin  
      
	
        
    
    if((DREQ[0]===1)&&!DACK)begin
        DACK <= 4'b0001;
        CR<=4'b0110;
        
    end
    if(!(DREQ[0]===1) && (DREQ[1]===1) &&!DACK)begin
        DACK <=4'b0010;
        CR<=4'b1001;
        
    end
    if(!(DREQ[0]===1)&&!(DREQ[1]===1) && (DREQ[2]===1) &&!DACK)begin
        DACK <=4'b0100;
    end
    if (!(DREQ[0]===1)&&!(DREQ[1]===1) && !(DREQ[0]===1) && DREQ[3]===1 &&!DACK) begin
        DACK <= 4'b1000;
        
    end
  end

if(DACK[0])begin
if(TC!=4) begin
TC<=TC+1;
end
if(TC===4)begin
TC<=25;
CR<=4'b1001;
end
if(TC===29)begin
DACK<=0;
TC<=0;
end
end

if(DACK[1]===1)begin
TC<=48;
CR<=4'b1001;


end






end

    
endmodule
