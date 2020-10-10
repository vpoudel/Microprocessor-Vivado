`timescale 1ns / 1ps

module top(
    input clock,
    input enable_money_in,
    input coin_detect,
    input [2:0] check_value,
    input have_coins_enuh,
    input [2:0] select_drink,
    input [5:0] check_drink,
    input [3:0] is_there_coin,
    output [7:0] change_back,
    output done_money_in,
    output pass,
    output [7:0] coin_in_total,
    output exact_change_only,
    output [3:0] half_dollar,quarter,dime,nickel,
    output done_changing
    );

    money_in uut1(
        .clock(clock),
        .enable(enable_money_in),
        .coin_detect(coin_detect),
        .check_value(check_value),
        .have_coins(have_coins_enuh),
        .select_drink(select_drink),
        .check_drink(check_drink),
        .vend(vend),
        .change_back(change_back),
        .done(done_money_in),
        .pass(pass),
        .coin_count(coin_in_total),
        .exact_change_only(exact_change_only)
        );
        
change_out uut2(
    .clock(clock),
    .done_money_in(done_money_in),
    .change_back(change_back),
    .is_there_coin(is_there_coin),
    .half_dollar(half_dollar),
    .quarter(quarter),
    .dime(dime),
    .nickel(nickel),
    .done_changing(done_changing)
    );
    
    //select_drink_part
    //change state after selecting
endmodule
