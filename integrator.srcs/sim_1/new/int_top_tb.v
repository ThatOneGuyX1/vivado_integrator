`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2024 12:40:14 PM
// Design Name: 
// Module Name: int_top_tb
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


module int_top_tb;
    reg clk;
    reg [15:0] sw;
    reg btnC;
    reg btnD;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    wire [15:0] led;
//    wire [7:0] x,y,z;
//    wire [3:0] a,b;
//    wire enable;
    parameter period = 10;
    
    int_top uut(.clk(clk),.sw(sw),.btnC(btnC),.btnD(btnD),.seg(seg),.an(an),.dp(dp),.led(led));
    
    //state_machine uut(.reset(btnD),.clk(clk),.ns(btnC),.x(x),.y(y),.z(z),.b(b),.a(a),.enable(enable),.led(led));
    
    always #(period/2) clk = ~clk;
//    always #(3*period) btnC = ~btnC;
    
    initial
        begin
        clk=0;
        btnC = 0;
        btnD = 1;
        sw = 16'b0000000000000000;
        #(5*period) btnD = 0;
        #(period) btnD = 1;
        #(period) btnD = 0;
        #(period) btnC = 0;
        #(period) btnC = 1;
        #(period) btnC = 0;
        # (5*period);
        sw[15:8] <= 1;
        sw[7:0] <= 1;
        #(period) btnC = 0;
        #(period) btnC = 1;
        #(period) btnC = 0;
        #(period) btnC = 0;
        #(period) btnC = 1;
        #(period) btnC = 0;
        # (period);
            sw = 16'b0010_0000_0000_0001;
        #(period*30);
        #(period);
        # (period*5);
        
        
        end
    
endmodule
