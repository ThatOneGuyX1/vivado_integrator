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
    parameter display = 2'b00;
    parameter wait1 = 2'b01;
    parameter wait2 = 2'b10;
    parameter calc = 2'b00;
    
    reg second_order;
    reg first_order;
    reg zero_order;
    reg upper_bound;
    reg lower_bound;
    
    reg [2:0] state_reg;
    
        always @ (posedge clk) begin
        if (reset) begin
            state_reg <= display;
        end
        else
            case(state_reg)
                display: begin
                    if (ns)
                        state_reg <= wait1;
                        enable <= 0;
                end
                wait1: begin
                    if (ns) begin
                       x <= sw[15:8];
                       y <= sw[7:0];
                       state_reg <= wait2; 
                    end
                end
                wait2: begin
                    if (ns) begin
                       z <= sw[7:0];
                       b <= sw[15:12];
                       a <= sw[11:8];
                       state_reg <= calc; 
                    end
                end
                calc: begin
                    state_reg <= display;
                    enable <= 1;
                end
            endcase
    end
endmodule
