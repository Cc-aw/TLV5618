// tlv5618_driver_tb.v
`timescale 1ns/1ps
module tlv5618_driver_tb;
    reg clk = 1;
    reg rst_n;
    
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tlv5618_driver_tb);
    end

endmodule
