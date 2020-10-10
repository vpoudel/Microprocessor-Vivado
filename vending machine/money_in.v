`timescale 1ns / 1ps

module money_in(
    input clock,
    input enable,
    input coin_detect,
    input [2:0] check_value,
    input have_coins,
    input [2:0] select_drink,
    input [5:0] check_drink,
    output reg vend,
    output reg [7:0] change_back,
    output reg done,
    output reg pass,
    output reg [7:0] coin_count,
    output exact_change_only
    );
    
    wire sync_coin_detect,sync_have_coins;
    reg detect_old,detect_old_old,have_coins_old;
   
    initial begin
        {coin_count,change_back,done,pass}<=0;
        {detect_old,detect_old_old,have_coins_old,vend}<=0;
    end
    
    parameter nickel=1,dime=2,quarter=3,
              half_dollar=4,dollar=5;
    parameter none=0,dOne=1,dTwo=2,dThree=3,dFour=4,
              dFive=5,dSix=6;
              
    assign sync_coin_detect=coin_detect;
    assign sync_have_coins=have_coins_old;
    
    assign exact_change_only=sync_have_coins?0:1;
    
    always @(posedge clock)
    begin
        if (~enable)
            {coin_count,change_back,done,pass,vend,
            detect_old,detect_old_old,have_coins_old}<=0;
        else
        begin
            if (sync_coin_detect & coin_count<150)
                case(check_value)
                    none:        coin_count=coin_count;
                    nickel:      coin_count=coin_count+5;
                    dime:        coin_count=coin_count+10;
                    quarter:     coin_count=coin_count+25;
                    half_dollar: coin_count=coin_count+50;
                    dollar:      coin_count=coin_count+100;
                    default:     pass=1;
                endcase
            else if (coin_count>=150)
            begin
                pass=1;
                casez(select_drink)
                    none:   change_back=coin_count;
                    dOne:   vend=(check_drink[0]==1)?1:0;
                    dTwo:   vend=(check_drink[1]==1)?1:0;
                    dThree: vend=(check_drink[2]==1)?1:0;
                    dFour:  vend=(check_drink[3]==1)?1:0;
                    dFive:  vend=(check_drink[4]==1)?1:0;
                    dSix:   vend=(check_drink[5]==1)?1:0;
                    default: vend='b0;
                endcase
            end
            
            if (vend==1)
            begin 
                change_back=~exact_change_only?(coin_count-150):0;
                done=1;
            end
        end
    end
    always @(posedge clock)
    begin
        detect_old<=coin_detect;
        detect_old_old<=detect_old;
        have_coins_old<=have_coins;
    end
    
endmodule
