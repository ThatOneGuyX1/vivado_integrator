module btn_debounce(
    input clk,
    input btn_in,
    output wire btn_status
    );
    reg [19:0] btn_shift;
        
    always @ (posedge clk)
        btn_shift <= {btn_shift[18:0], btn_in};
    
    assign btn_status = &btn_shift;
    
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2016 01:36:54 PM
// Design Name: 
// Module Name: debounce_div
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


module debounce_div(
    input clk,
    output clk_deb
    );
    reg [15:0] cnt;

    
    assign clk_deb = cnt[15];
    
    initial cnt = 0;
    always @(posedge clk)
        cnt <= cnt + 1;
        
endmodule
