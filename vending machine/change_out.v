`timescale 1ns / 1ps

module change_out(
    input clock,
    input done_money_in,
    input [7:0] change_back,
    input [3:0] is_there_coin,
    output reg [3:0] half_dollar,
    output reg [3:0] quarter,
    output reg [3:0] dime,
    output reg [3:0] nickel,
    output reg done_changing
    );
    reg start_count;
    integer change_left;
    reg [3:0] count_half_dollar,count_quarter,count_dime,count_nickel;
    initial begin
        {half_dollar,quarter,dime,nickel,done_changing,start_count}<=0;
        {count_half_dollar,count_quarter,count_dime,count_nickel}<=0;
    end
    
    always @(posedge clock)
    begin
        if (~done_money_in)
        begin
            {half_dollar,quarter,dime,nickel,done_changing,start_count}<=0;
            {count_half_dollar,count_quarter,count_dime,count_nickel}<=0;
        end
        else
        begin
            if (~start_count)
            begin
                change_left<=change_back;
                start_count<=1;  
            end
            else if (change_left>=50 & is_there_coin[3] & start_count)
            begin
                change_left<=change_left-50;
                count_half_dollar<=count_half_dollar+1;
            end
            else if (change_left>=25 & is_there_coin[2] & start_count)
            begin
                change_left<=change_left-25;
                count_quarter<=count_quarter+1;
            end
            else if (change_left>=10 & is_there_coin[1] & start_count)
            begin
                change_left<=change_left-10;
                count_dime<=count_dime+1;
            end
            else if (change_left>=5 & is_there_coin[0] & start_count)
            begin
                change_left<=change_left-5;
                count_nickel<=count_nickel+1;
            end
            else if (change_left==0)
            begin
                nickel<=count_nickel;
                dime<=count_dime;
                quarter<=count_quarter;
                half_dollar<=count_half_dollar;  
                done_changing=1;      
            end
            else done_changing='bz;
        end
    end  
endmodule
