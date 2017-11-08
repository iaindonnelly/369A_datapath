`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 04:01:27 PM
// Design Name: 
// Module Name: DataPath_tb
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


module DataPath_tb();
reg Clk,Rst; 
wire [31:0] writedata;
wire [31:0] PCResult;
 DataPath dp(Rst, Clk,writedata,PCResult);

    initial begin
            Clk <= 1'b0;
            forever #250 Clk <= ~Clk;
    end
    initial begin
    Rst <= 1;
    #500
    Rst <= 0;
    end
endmodule
