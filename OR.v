`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 05:03:10 PM
// Design Name: 
// Module Name: OR
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


module OR(A,B,C);
    
    input A,B;
    output reg C; 
    always@(*) begin
        C <= A|B;
    end
endmodule
