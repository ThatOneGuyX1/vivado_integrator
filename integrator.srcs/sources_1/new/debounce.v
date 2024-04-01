`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 03:59:17 PM
// Design Name: 
// Module Name: debounce
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


module debounce(
input clk, btn_in,
output btn_out
    );
    reg t0, t1,t2;
    always @ (posedge clk) begin
        t0 <= btn_in;
        t1 <= t0;
        t2 <= t1;
        end
        
        assign btn_out = t2;
endmodule
