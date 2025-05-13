// tlv5618_driver.v
module tlv5618_driver (
    input clk,
    input rst_n,

    // to user
    input  [15:0] DAC_data,
    input         set_go,
    output        set_done,

    //to DAC
    output DAC_cs_n,
    output DAC_sclk,
    output DAC_din
);
    parameter CLOCK_FREQ = 50_000_000;
    parameter SRCLK_FREQ = 20_000_000;
    parameter MCNT_DIV = CLOCK_FREQ / (SRCLK_FREQ *2 ) -1;

endmodule
