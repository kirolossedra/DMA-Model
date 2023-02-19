module memory (
    AB,
    DB,
    CB,
    CLK
);
inout [7:0] DB;
inout [7:0] AB;
inout [3:0] CB;
reg [7:0] MEMORY[254:0];

input CLK;

initial begin
MEMORY[0] = 8'b11111111;
MEMORY[1] = 8'b01110000;
MEMORY[2] = 8'b11100001;
MEMORY[3] = 8'b11110000;

end

assign CB = 4'bzzzz;
assign AB = 8'bzzzzzzz;
//IOR | IOW | MEMR | MEMW
assign DB = (CB[1])?MEMORY[AB]:8'bzzzzzzzz;
always @ (posedge CLK) begin
    if(CB[0]&!CB[1])begin
        MEMORY[AB]<= DB;
    end
end
endmodule
