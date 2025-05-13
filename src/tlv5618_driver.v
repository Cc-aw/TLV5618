// tlv5618_driver.v
module tlv5618_driver (
    input clk,
    input rst_n,

    // to user
    input      [15:0] set_data,
    input             set_go,
    output reg        set_done,

    //to DAC
    output reg DAC_cs_n,
    output reg DAC_sclk,
    output reg DAC_din
);
    parameter CLOCK_FREQ = 50_000_000;
    parameter SRCLK_FREQ = 12_500_000;
    parameter MCNT_DIV = CLOCK_FREQ / (SRCLK_FREQ * 2) - 1;

    //计数器
    reg [ 7:0] div_cnt;
    reg [ 5:0] seq_cnt;
    reg        en_div_cnt;

    //暂存数据 
    reg        r_set_go;
    reg [15:0] r_set_data;

    //暂存set_go
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            r_set_go <= 0;
        end
        else begin
            r_set_go <= set_go;
        end
    end

    //暂存set_data
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            r_set_data <= 16'd0;
        end
        else begin
            r_set_data <= set_data;
        end
    end

    //分频计数器，实现12.5Mhz下的最小时间单位40ns
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            div_cnt <= 0;
        end
        else if (en_div_cnt) begin
            if (div_cnt == MCNT_DIV) begin
                div_cnt <= 0;
            end
            else begin
                div_cnt <= div_cnt + 1;
            end
        end
        else begin
            div_cnt <= 0;
        end
    end

    //序列计数器
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            seq_cnt <= 0;
        end
        else if (seq_cnt == 33) begin
            seq_cnt <= 0;
        end
        else begin
            seq_cnt <= seq_cnt + 1;
        end
    end

    // en_div_cnt 生成信号
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            en_div_cnt <= 0;
        end
        else if (set_go) begin
            en_div_cnt <= 1;
        end
        else if ((div_cnt == MCNT_DIV) && (seq_cnt == 33)) begin
            en_div_cnt <= 0;
        end
        else begin
            en_div_cnt <= en_div_cnt;
        end
    end

    //set_done
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            set_done <= 0;
        end
        else if ((div_cnt == MCNT_DIV) && (seq_cnt == 33)) begin
            set_done <= 1;
        end
        else begin
            set_done <= 0;
        end
    end
    //序列机实现
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            DAC_sclk <= 1;
            DAC_din  <= 0;
            DAC_cs_n <= 1;
        end
        else if (div_cnt == MCNT_DIV) begin
            case (seq_cnt)
                0: begin
                    DAC_cs_n <= 0;
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[15];
                end
                1:  DAC_sclk <= 0;
                2: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[14];
                end
                3:  DAC_sclk <= 0;
                4: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[13];
                end
                5:  DAC_sclk <= 0;
                6: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[12];
                end
                7:  DAC_sclk <= 0;
                8: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[11];
                end
                9:  DAC_sclk <= 0;
                10: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[10];
                end
                11: DAC_sclk <= 0;
                12: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[9];
                end
                13: DAC_sclk <= 0;
                14: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[8];
                end
                15: DAC_sclk <= 0;
                16: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[7];
                end
                17: DAC_sclk <= 0;
                18: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[6];
                end
                19: DAC_sclk <= 0;
                20: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[5];
                end
                21: DAC_sclk <= 0;
                22: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[4];
                end
                23: DAC_sclk <= 0;
                24: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[3];
                end
                25: DAC_sclk <= 0;
                26: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[2];
                end
                27: DAC_sclk <= 0;
                28: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[1];
                end
                29: DAC_sclk <= 0;
                30: begin
                    DAC_sclk <= 1;
                    DAC_din  <= r_set_data[0];
                end
                31: DAC_sclk <= 0;
                32: begin
                    DAC_sclk <= 1;
                    DAC_din  <= 0;
                end
                33: begin
                    DAC_sclk <= 1;
                    DAC_cs_n <= 1;
                end
                default: begin
                    DAC_sclk <= DAC_sclk;
                    DAC_din  <= DAC_din;
                    DAC_cs_n <= DAC_cs_n;
                end
            endcase
        end
        else begin
            DAC_sclk <= DAC_sclk;
            DAC_din  <= DAC_din;
            DAC_cs_n <= DAC_cs_n;
        end
    end


endmodule
