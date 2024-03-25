`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2024 02:51:13 PM
// Design Name: 
// Module Name: sseg_x4_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sseg_x4_top(
    input [15:0] sw,
    input btnC,
    input clk,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output [4:0] JA
    );
    wire clkd;
    wire [3:0] an1;
    wire [3:0] hex_num;
    
    assign JA[4] = clkd;
    assign JA[3:0] = an;
    
    clk_gen clock1(.clk(clk),.rst(btnC),.clk_div(clkd));
    digit_selector selector1(.clk(clkd), .rst(btnC), .sw(sw), .digit_sel(an), .seg(hex_num));
    segment_display display1(.sw(hex_num), .seg(seg), .an(an1), .dp(dp));
    
    
endmodule