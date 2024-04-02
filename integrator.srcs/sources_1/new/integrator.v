`timescale 1ns / 1ps

module integrator(
    input clk, enable,
    input [7:0] x, //x^2 coefficent
    input [7:0] y, //y  x coefficent
    input [7:0] z, //constant
    input [4:0] b, // Upper bound
    input [4:0] a, // Lower bound,
    output [15:0] result,
    output calc_done
    );
    
    //Step value
    //                    integer  . fractional
    parameter step = 16'b0000_0000_0000_0001; //1/256 = .125 (or dx)
    parameter scalef = 8; // The amount of fractional bits
    
    //Fixes point values
    //These values hold the new fixed point values of the inputs
    reg[16:0] x2,x1,x0;
    reg[16:0] upperbound, lowerbound;
    
    
    //Pipeline Registers
    reg[63:0] x2_p1,x2_p2,x1_p1,x1_p2,temp_x2,temp_x1,temp_x0;
    
    // Internal Memory
    reg[23:0] current_pos; // Show the current value of X
    //Wires
    
    wire clke = (clk & enable); // Enable allows for the calcuation to be performed
    
    assign calc_done = (b == ((current_pos-4)>>(scalef))) ? 1:0; // Checks to see if we are the end of the bounds
    assign result = !calc_done ? 16'hZZZZ: ((temp_x0+temp_x1 +temp_x2) >> (scalef));
    
    always @(posedge clke) 
    begin
        if(calc_done | (0 == current_pos)) 
        begin 
        /*
        */
            x2 <= x<< (scalef);
            x1 <= y<< (scalef);
            upperbound <= b << (scalef/2); // Unsure why
            lowerbound <= a << (scalef);
            current_pos <= 0;
            temp_x0 <= (z* (b - a)) << (scalef);
            // Reset Values to zero
            temp_x2 <= 0;
            temp_x1 <= 0;
            x2_p1 <= 0;
            x1_p1 <= 0;
            x2_p2 <= 0;
            x1_p2 <= 0;
            
        end
        
        if(!calc_done) 
        begin
            /*
            This section performs the reimann sum
            */
            //Find the values of f(x) for each part
            x2_p1 <= (((current_pos *current_pos)) * x2)>>scalef;
            x1_p1 <= ((current_pos) *x1);
            // Find the area for dX
            x2_p2 <= (x2_p1[63:8] * step);
            x1_p2 <= (x1_p1[63:8] * step);
            // Increment the postion by x
            current_pos <= step + current_pos;
            temp_x2 <= temp_x2 + x2_p2[63:8];
            temp_x1 <= temp_x1 + x1_p2[63:8]    ;
        end
    end
    
    initial begin
        x2 = 0;
        x1 = 0;
        x0 = 0;
        upperbound = 0;
        lowerbound = 0;
        current_pos = 0;
        temp_x0 = 0;
        temp_x2 = 0;
        temp_x1 = 0;
        
        
    end
endmodule 