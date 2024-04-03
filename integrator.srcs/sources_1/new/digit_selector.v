`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 02:13:34 PM
// Design Name: 
// Module Name: digit_selector
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


module digit_selector(
    input clk,
    input rst,
    input [15:0] sw,
    output reg [3:0] digit_sel,
    output reg [3:0] seg
    );
    reg [1:0] cntr;
    always @(posedge clk)
        begin
        if(rst)
            cntr <=0;
        else
            cntr <= cntr + 1;
        end
    
    always @(cntr)
        begin
         if(cntr == 0)
         begin
            digit_sel <= 4'b1110;
            seg <= sw[3:0];
         end
         else if(cntr == 1)
         begin
            digit_sel <= 4'b1101;
            seg <= sw[7:4];
         end
         else if(cntr == 2)
         begin
            digit_sel <= 4'b1011;
            seg <= sw[11:8];
         end
         else if(cntr == 3)
         begin
            digit_sel <= 4'b0111;
            seg <= sw[15:12];
         end
         end
         
         
         initial begin
         digit_sel = 0;
         seg = 0;
         cntr = 0;
         end
         
         
endmodule
