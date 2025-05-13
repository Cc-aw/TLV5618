// tlv5618_driver_tb.v
`timescale 1ns / 1ps
module tlv5618_driver_tb;
    reg         clk = 1;
    reg         rst_n;
    // to user
    reg  [15:0] set_data;
    reg         set_go;
    wire        set_done;

    //to DAC
    wire        DAC_cs_n;
    wire        DAC_sclk;
    wire        DAC_din;

    reg [15:0] data;

    always #10 clk = ~clk;

    initial begin
        rst_n<=0;
        set_go<=0;
        set_data<=0;
        #100;
        rst_n=1;
        #50;
        //第一次传输
        set_go=1;
        set_data= 16'b0101_0111_1101_0000;
        #20; 
        set_go=0;
        wait(~DAC_cs_n);
        @(negedge DAC_sclk);
        data[15]=DAC_din;
        @(negedge DAC_sclk);
        data[14]=DAC_din;
        @(negedge DAC_sclk);
        data[13]=DAC_din;
        @(negedge DAC_sclk);
        data[12]=DAC_din;
        @(negedge DAC_sclk);
        data[11]=DAC_din;
        @(negedge DAC_sclk);
        data[10]=DAC_din;
        @(negedge DAC_sclk);
        data[9]=DAC_din;
        @(negedge DAC_sclk);
        data[8]=DAC_din;
        @(negedge DAC_sclk);
        data[7]=DAC_din;
        @(negedge DAC_sclk);
        data[6]=DAC_din;
        @(negedge DAC_sclk);
        data[5]=DAC_din;
        @(negedge DAC_sclk);
        data[4]=DAC_din;
        @(negedge DAC_sclk);
        data[3]=DAC_din;
        @(negedge DAC_sclk);
        data[2]=DAC_din;
        @(negedge DAC_sclk);
        data[1]=DAC_din;
        @(negedge DAC_sclk);
        data[0]=DAC_din;
        #200;

        //第二次传输
        set_go=1;
        set_data= 16'b1100_0011_1110_1000;
        #20; 
        set_go=0;
        wait(~DAC_cs_n);
        @(negedge DAC_sclk);
        data[15]=DAC_din;
        @(negedge DAC_sclk);
        data[14]=DAC_din;
        @(negedge DAC_sclk);
        data[13]=DAC_din;
        @(negedge DAC_sclk);
        data[12]=DAC_din;
        @(negedge DAC_sclk);
        data[11]=DAC_din;
        @(negedge DAC_sclk);
        data[10]=DAC_din;
        @(negedge DAC_sclk);
        data[9]=DAC_din;
        @(negedge DAC_sclk);
        data[8]=DAC_din;
        @(negedge DAC_sclk);
        data[7]=DAC_din;
        @(negedge DAC_sclk);
        data[6]=DAC_din;
        @(negedge DAC_sclk);
        data[5]=DAC_din;
        @(negedge DAC_sclk);
        data[4]=DAC_din;
        @(negedge DAC_sclk);
        data[3]=DAC_din;
        @(negedge DAC_sclk);
        data[2]=DAC_din;
        @(negedge DAC_sclk);
        data[1]=DAC_din;
        @(negedge DAC_sclk);
        data[0]=DAC_din;
        #200;

        $finish;
    end

    tlv5618_driver u_tlv5618_driver (
        .clk     (clk),
        .rst_n   (rst_n),
        .set_data(set_data),
        .set_go  (set_go),
        .set_done(set_done),
        .DAC_cs_n(DAC_cs_n),
        .DAC_sclk(DAC_sclk),
        .DAC_din (DAC_din)
    );


    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tlv5618_driver_tb);
    end

endmodule
