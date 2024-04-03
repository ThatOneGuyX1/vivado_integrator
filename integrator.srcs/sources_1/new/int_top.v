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
    output [3:0] an,
    output dp,
    output [15:0] led
    );
    wire [7:0] x, y, z;
    wire [3:0] a, b;
    wire [15:0]result;
    reg [15:0] result_val;
    wire enable, ns, rst, rst_pulse, ns_pulse, calc_done_flag;     // Required wire
    wire [4:0] JA;                             // Useless pins for this lab
    
    sseg_x4_top sseg1(.sw(result_val),.btnC(rst_pulse),.clk(clk),.seg(seg),.an(an),.dp(dp),.JA(JA));
    integrator int1(.clk(clk),.enable(enable),.x(x),.y(y),.z(z),.b(b),.a(a),.result(result),.calc_done(calc_done_flag));
    debounce dbC(clk, btnC, ns);
    debounce dbD(clk,btnD,rst);
    create_pulse_from_step ns_pulse1(.clk(clk),.step(ns),.pulse(ns_pulse));
    create_pulse_from_step rst_pulse1(.clk(clk),.step(rst),.pulse(rst_pulse));
    state_machine sm(.reset(rst_pulse),.clk(clk),.ns(ns_pulse),.sw(sw),.calc_done_flag(calc_done_flag),.x(x),.y(y),.z(z),.b(b),.a(a),.enable(enable),.led(led));
    
    always@(posedge clk,posedge rst_pulse)
    begin
    if(calc_done_flag)
        result_val <= result;
    if(rst_pulse)
        result_val <= 0;
    end
    
    
   
    

endmodule
