`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2017 10:09:11 PM
// Design Name: 
// Module Name: SL2J
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


module SL2J(A,ShiftOut);
    input [25:0] A;
   output reg [27:0] ShiftOut;
   
   always@(*) begin
    ShiftOut = A << 2;
   end
endmodule
