module CLK_ON_WIRE(clock);
    
    output reg clock;
    
    
    initial clock = 0;  
    always #5 clock = ~clock;  // 50 % duty Cycle clock

endmodule
