`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2017 01:29:47 PM
// Design Name: 
// Module Name: AndGate
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


module AndGate(A,B,AndOut);
  input  A;
  input  B;
 output reg AndOut;
 
 always@(*) begin
  AndOut = A & B;
 end

endmodule
