`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2024 02:54:21 PM
// Design Name: 
// Module Name: clk_gen
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


module clk_gen(
    input clk,
    input rst,
    output clk_div
    );
    reg [25:0] cntr;
    always @(posedge clk)
        begin
        if(rst)
            cntr <= 0;
        else
            cntr <= cntr + 1;          
                        
        end
    assign clk_div = cntr[18];
endmodule