`timescale 1ns / 1ps

module change_maker(
    input clock,
    input enable,
    input done_money_in,
    input [7:0] change_back,
    input [3:0] is_there_coin,
    output reg [3:0] half_dollar,
    output reg [3:0] quarter,
    output reg [3:0] dime,
    output reg [3:0] nickel,
    output reg [7:0] change_left,
    output reg done_change_maker
    );
    
    reg [7:0] count;
    reg start_counting_down;
    reg [3:0] count_half_dollar,count_quarter,count_dime,count_nickel;
    initial begin
        {half_dollar,quarter,dime,nickel,count,
        start_counting_down,done_change_maker,change_left}<=0;
        {count_half_dollar,count_quarter,count_dime,count_nickel}<=0;
    end
    
    
    always @(posedge clock) 
    begin
        if (enable)
            {half_dollar,quarter,dime,nickel,count,start_counting_down,
            done_change_maker,count_half_dollar,count_quarter,count_dime,
            count_nickel}<=0;
        else if (done_money_in)
            begin
                change_left<=change_back;
                start_counting_down<=1;
                done_change_maker<=0;
                {count_half_dollar,count_quarter,count_dime,count_nickel}<=0;
                {half_dollar,quarter,dime,nickel}<=0;
                if(is_there_coin[3] & change_left>=50 & start_counting_down)
                    begin
                        change_left<=change_left-50;
                        count_half_dollar<=count_half_dollar+1;
                    end
                else if(is_there_coin[2] & change_left>=25 & start_counting_down)
                    begin
                        change_left<=change_left-25;
                        count_quarter<=count_quarter+1;
                    end
                else if(is_there_coin[1] & change_left>=10 & start_counting_down)
                    begin
                        change_left<=change_left-10;
                        count_dime<=count_dime+1;
                    end
                else if(is_there_coin[0] & change_left>=5 & start_counting_down)
                    begin
                        change_left<=change_left-5;
                        count_nickel<=count_nickel+1;
                    end
                else if (change_left==0 & start_counting_down)
                begin 
                    half_dollar<=count_half_dollar;
                    quarter<=count_quarter;
                    dime<=count_dime;
                    nickel<=count_nickel;
                    done_change_maker<=1;
                    start_counting_down<=0;
                    change_left<=0;
                end
            end
    end
endmodule
