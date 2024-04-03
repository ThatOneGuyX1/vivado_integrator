`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 02:03:24 PM
// Design Name: 
// Module Name: segment_display
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


module segment_display(
    input [3:0] sw,
    output reg [6:0] seg,
    output dp
    );
    
    assign dp = 1'b1;
    
    always @ (sw)
        case(sw)
            4'b0000: seg = 7'b1000000; // 1111110 - 0 - 1000000
            4'b0001: seg = 7'b1111001; // 0110000 - 1 - 1111001
            4'b0010: seg = 7'b0100100; // 1101101 - 2 - 0100100
            4'b0011: seg = 7'b0110000; // 1111001 - 3 - 0110000
            4'b0100: seg = 7'b0011001; // 0110011 - 4 - 0011001
            4'b0101: seg = 7'b0010010; // 1011011 - 5 - 0010010
            4'b0110: seg = 7'b0000010; // 1011111 - 6 - 0000010
            4'b0111: seg = 7'b1111000; // 1110000 - 7 - 1111000
            4'b1000: seg = 7'b0000000; // 1111111 - 8 - 0000000
            4'b1001: seg = 7'b0011000; // 1110011 - 9 - 0011000
            4'b1010: seg = 7'b0001000; // 1110111 - A - 0001000
            4'b1011: seg = 7'b0000011; // 0011111 - B - 0000011
            4'b1100: seg = 7'b0100111; // 0001101 - C - 0100111
            4'b1101: seg = 7'b0100001; // 0111101 - D - 0100001
            4'b1110: seg = 7'b0000110; // 1001111 - E - 0000110
            4'b1111: seg = 7'b0001110; // 1000111 - F - 0001110
        endcase
endmodule