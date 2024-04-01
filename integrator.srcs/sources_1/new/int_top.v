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
    output [6:0] seg,
    output dp,
    output [15:0] led
    );
    wire [7:0] x, y, z;
    wire [3:0] a, b;
    wire [15:0]results;
    wire enable, ns, rst, rst_pulse, ns_pulse, calc_done_flag;     // Required wires
    wire an,JA;                             // Useless pins for this lab
    
    sseg_x4_top sseg1(.sw(results),.btnC(rst_pulse),.clk(clk),.seg(seg),.an(an),.dp(dp),.JA(JA));
    integrator int1(.clk(clk),.enable(enable),.x(x),.y(y),.z(z),.b(b),.a(a),.result(results),.calc_done(calc_done_flag));
    debounce dbC(clk, btnC, ns);
    debounce dbD(clk,btnD,rst);
    create_pulse_from_step ns_pulse1(.clk(clk),.step(ns),.pulse(ns_pulse));
    create_pulse_from_step rst_pulse1(.clk(clk),.step(rst),.pulse(rst_pulse));
    state_machine sm(.reset(rst_pulse),.clk(clk),.ns(ns_pulse),.sw(sw),.calc_done_flag(calc_done_flag),.x(x),.y(y),.z(z),.b(b),.a(a),.enable(enable),.led(led));

    
    
    
    

endmodule
