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
    input calc_done_flag,
    output [7:0] x, y, z,
    output reg [3:0] a, b,
    output reg enable,
    output reg [15:0] led
    );
    parameter display = 2'b00; // Set the parameters for the states we have
    parameter wait1 = 2'b01;
    parameter wait2 = 2'b10;
    parameter calc = 2'b11;
    
    reg [2:0] state_reg;
    
    reg[7:0] tempx, tempy,tempz;
    assign x = tempx;
    assign z = tempz;
    assign y = tempy;
        always @ (posedge clk) begin
        if (reset) begin
            state_reg <= display; // reset to the display and all values of 0
            tempx <= 8'b00000000;
            tempy <= 8'b00000000;
            tempz <= 8'b00000000;
            a <= 4'b0000;
            b <= 4'b0000;
        end
        
            case(state_reg)
                display: begin    
                    led <= 16'b0000000000000001;                  
                    if (ns)                         // when ns is pushed, go to next state
                        state_reg <= wait1;
                        enable <= 0;                // stop the integrator from running
                end
                wait1: begin
                    led <= 16'b0000000000000010;   
                    tempx <= sw[15:8];               // Set the second order coeffcient 
                    tempy <= sw[7:0];                // Set the first order coefficient
                    if (ns) begin                   // when ns is pushed, go to next state
                       state_reg <= wait2; 
                    end
                end
                wait2: begin
                    led <= 16'b0000000000000100;   
                    tempz <= sw[7:0];                // Set the constant
                    b <= sw[15:12];              // Set the upperbound
                    a <= sw[11:8];               // Set the lower bound
                    if (ns) begin                   // when ns is pushed, go to next state
                       state_reg <= calc; 
                    end
                end
                calc: begin
                    led <= 16'b0000000000001000;   
                    enable <= 1;                    // allow the integrator to run with the given parameters
                    if (calc_done_flag) begin
                        state_reg <= display;
                    end
                end
            endcase
    end
    
    
    initial begin
    tempx = 0;
    tempy =0;
    tempz =0;
    a = 0;
    b =0;
    enable = 0;
    led =0;
    state_reg = 0;
    end
    
    
endmodule
