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
/*
if (ID/EX.MemRead and
   ((ID/EX.RegisterRt = IF/ID.RegisterRs) or
        (ID/EX.RegisterRt = IF/ID.RegisterRt)))
          stall the pipeline
*/

module HazardDetection(Instruction,RD_EX,RT_ID,RS_ID,FlushID,FlushIF,stall,MemRead_EX); //also need ex stage mem control signals
    input [31:0] Instruction;
    input [4:0] RD_EX,RT_ID,RS_ID;
    input MemRead_EX;
    output reg FlushID;
    output reg FlushIF;
    output reg stall;
    initial begin
        FlushID <= 0 ;
        FlushIF <= 0;
        stall <= 0;
    end
    always@(*) begin
    FlushID <= 0 ;
    FlushIF <= 0;
    stall <= 0;
    if (MemRead_EX &&
       ((RD_EX == RS_ID) ||
            (RD_EX == RT_ID)) && (RD_EX != 0)) begin 
            stall <= 1;
            end
              
    end
    
endmodule
