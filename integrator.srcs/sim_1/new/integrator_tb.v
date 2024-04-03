`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 02:17:00 PM
// Design Name: 
// Module Name: integrator_tb
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


module integrator_tb;

    reg clk, enable;
    reg [7:0] x, y, z;
    reg [4:0] b; // Upper bound
    reg [4:0] a; // Lower bound,
    wire [15:0] result;
    parameter period = 10;

    
    integrator u0 (
        .clk(clk),
        .enable(enable),
        .x(x),.y(y),.z(z), .b(b), .a(a),   
        .result(result)
        );
    
    always #(period/2) clk = ~clk;
        
    initial
        begin 
        clk = 0; enable = 1; x= 0; y=0; z = 1; a=0; b =1;
        #2500  $finish;
        end
   
endmodule

        
  