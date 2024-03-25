`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 01:29:50 PM
// Design Name: 
// Module Name: integrator_top
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


module integrator_top(
    input [15:0] sw,
    input clk,
    input btnc,
    output [15:0] led
    
    );
    
    sseg_2x_top sseg1();
endmodule
