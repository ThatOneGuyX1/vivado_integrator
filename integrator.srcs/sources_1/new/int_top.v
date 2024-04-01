`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 02:27:50 PM
// Design Name: 
// Module Name: int_top
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


module int_top(
    input clk,
    input [15:0] sw,
    input btnC,
    input btnD,
    output [7:0] seg,
    output dp,
    output [15:0] led
    );
    wire x, y, z, a, b, results,enable;     // Required wires
    wire an,JA;                             // Useless pins for this lab
    
    state_machine sm(.reset(btnD),.clk(clk),.ns(btnC),.sw(sw),.x(x),.y(y),.z(z),.b(b),.a(a),.enable(enable));
    sseg_x4_top sseg1(.sw(results),.btnC(btnD),.clk(clk),.seg(seg),.an(an),.dp(dp),.JA(JA));
    integrator int1(.clk(clk),.enable(enable),.x(x),.y(y),.z(z),.b(b),.a(a),.result(results));
    
    
    
    
    

endmodule
