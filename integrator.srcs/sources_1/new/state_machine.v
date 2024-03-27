`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 03:11:54 PM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input reset, clk, ns,
    input [15:0] sw,
    output reg [7:0] x, y, z,
    output reg [4:0] a, b,
    output reg enable
    );
    parameter display = 2'b00; // Set the parameters for the states we have
    parameter wait1 = 2'b01;
    parameter wait2 = 2'b10;
    parameter calc = 2'b11;
    
    reg [2:0] state_reg;
    
        always @ (posedge clk) begin
        if (reset) begin
            state_reg <= display; // reset to the display and all values of 0
                        x <= 8'b00000000;
                        y <= 8'b00000000;
                        z <= 8'b00000000;
                        a <= 4'b0000;
                        b <= 4'b0000;
        end
        else
            case(state_reg)
                display: begin                      
                    if (ns)                         // when ns is pushed, go to next state
                        state_reg <= wait1;
                        enable <= 0;                // stop the integrator from running
                end
                wait1: begin
                    if (ns) begin                   // when ns is pushed, go to next state
                       x <= sw[15:8];               // Set the second order coeffcient 
                       y <= sw[7:0];                // Set the first order coefficient
                       state_reg <= wait2; 
                    end
                end
                wait2: begin
                    if (ns) begin                   // when ns is pushed, go to next state
                       z <= sw[7:0];                // Set the constant
                       b <= sw[15:12];              // Set the upperbound
                       a <= sw[11:8];               // Set the lower bound
                       state_reg <= calc; 
                    end
                end
                calc: begin
                    state_reg <= display;
                    enable <= 1;                    // allow the integrator to run with the given parameters
                end
            endcase
    end
endmodule
