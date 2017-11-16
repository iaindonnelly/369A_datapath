`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2017 01:44:16 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(Instruction,RT_EX,FlushID,FlushIF,FlushEX); //also need ex stage mem control signals
    input [31:0] Instruction;
    input [4:0] RT_EX;
    output reg FlushID;
    output reg FlushIF;
    output reg FlushEX;
endmodule
