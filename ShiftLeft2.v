`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2017 05:49:06 PM
// Design Name: 
// Module Name: ShiftLeft2
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


module ShiftLeft2(A,ShiftOut);
    input [31:0] A;
   output reg [31:0] ShiftOut;
   
   always@(*) begin
    ShiftOut = A << 2;
   end
endmodule
