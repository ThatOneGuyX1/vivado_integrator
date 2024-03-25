`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 01:50:32 PM
// Design Name: 
// Module Name: integrator
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


module integrator(
    input clk, enable,
    input [7:0] x, //x^2 coefficent
    input [7:0] y, //y  x coefficent
    input [7:0] z, //constant
    input [3:0] b, // Upper bound
    input [3:0] a, // Lower bound,
    output [15:0] result
    );
    
    
    initial begin
    upperbound = 0;
    lowerbound = 0;
    
    end
//    real i;
//    real r;
//    real dx = .001;
    reg[16:0] temp_result;
    reg[4:0] upperbound, lowerbound;
    //x*i^2 +y*i + z;
    wire step = 0.1;
    
    wire clke = clk & enable;
    
    wire calcdone = (lowerbound == b) ? 1:0; // If Lowerbound is equal to the upperbound then the calc is done.
    assign result = calcdone ? temp_result:16'h0000;
    
   
    always @(posedge clke) begin
     if(upperbound != b) begin
        upperbound <= b;
        lowerbound <= a;
        temp_result <= 0;
        end
     //x*i^2 +y*i + z;
     if (lowerbound < upperbound) begin
        temp_result <= temp_result + (((x * (lowerbound^2))+(y*lowerbound)+z)*step);
        lowerbound <= lowerbound + step;
        end
        
       
        
    
    end
    
endmodule

/*
so in fixed point numbers are like this
16 8 4 2 1. .5 .25 .125 .0625

so 5.8 the number in binary is
0 0 1 0 1. 1 1 0 0 1
https://projectf.io/posts/fixed-point-numbers-in-verilog/

so for a 16 bit number we need to have more than 16 bits.

*/

module fixed_point(
    input clk, enable,
    input [7:0] x, //x^2 coefficent
    input [7:0] y, //y  x coefficent
    input [7:0] z, //constant
    input [4:0] b, // Upper bound
    input [4:0] a, // Lower bound,
    output [15:0] result
    );
    
    reg[32:0] temp_result;
    reg[32:0] upperbound, lowerbound;
    
    initial begin
    upperbound = 0;
    lowerbound = 0;
    temp_result = 0;
    end

    parameter step = 32'h4000; //1/16
    
    wire clke = clk & enable;
    
    wire calcdone = (lowerbound[32:16] == b) ? 1:0; // If Lowerbound is equal to the upperbound then the calc is done.
    assign result = calcdone ? (temp_result >>16) : 16'h0000;
    
   
    always @(posedge clke) begin
     if(upperbound[32:16] != b) begin
        upperbound <= (b << 16);
        lowerbound <= (a << 16);
        temp_result <= 32'b0;   
        end
     //x*i^2 +y*i + z;
     if (lowerbound < (upperbound-1)) begin
        temp_result <= temp_result + ((((x<<16)* (lowerbound^2))+((y<<16)*lowerbound)+(z<<16))*step);
        lowerbound <= lowerbound + step;
        end     
        
       
        
    
    end
endmodule 



module fixed_point_pipelined(
    input clk, enable,
    input [7:0] x, //x^2 coefficent
    input [7:0] y, //y  x coefficent
    input [7:0] z, //constant
    input [4:0] b, // Upper bound
    input [4:0] a, // Lower bound,
    output [15:0] result
    );
    //Step value
    parameter step = 16'b0000_0000_0001_0000; //1/16 = .0625
    
    //Internal memory
    //reg[23:0] temp_result; // Holds the result
    reg[23:0] current_pos; // In regards to the bounds where we are 
    //Wires
    wire clke = (clk & enable); // Are writing?
    wire calc_done = (b == current_pos) ? 1:0; // Checks to see if we are the end of the bounds
    assign result = !calc_done ? 16'hZZZZ: (temp_x0+temp_x1 +temp_x2);
    //Fixes point values
    reg[16:0] x2,x1,x0;
    reg[16:0] upperbound, lowerbound;
    
    
    //Pipeline Registers
    reg[23:0] x2_p1,x2_p2,x1_p1,x1_p2,temp_x2,temp_x1,temp_x0;
    always @(posedge clke) begin
    //Find the values of f(x) for each part
        x2_p1 <= (current_pos *current_pos) * x2;
        x1_p1 <= (current_pos) *x1;
    // Find the area for dX
        x2_p2 <= x2_p1 * step;
        x1_p2 <= x1_p1 * step;
    // Increment the postion by x
        current_pos <= step + current_pos;
        temp_x2 <= temp_x2 + x2_p2;
        temp_x1 <= temp_x1 + x1_p2;
        
    end
    
    initial begin
        x2 = x<< 8;
        x1 = y<< 8;
        x0 = z<< 8;
        upperbound = b << 8;
        lowerbound = a << 8;
        current_pos = 0;
        temp_x0 = x0* (upperbound - lowerbound);
        
    end
endmodule 
