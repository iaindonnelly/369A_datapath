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

module HazardDetection(RD_EX,Branch,RegWrite_EX,MemRead_Mem,RT_ID,RS_ID,FlushID,FlushIF,stall,MemRead_EX,RD_MEM,MemWrite_ID,MemRead_ID); //also need ex stage mem control signals
    input [4:0] RD_EX,RT_ID,RS_ID;
    input MemRead_EX;
    input MemRead_Mem;
    input Branch;
    input RegWrite_EX;
    input MemWrite_ID;
    input MemRead_ID;
    input [4:0] RD_MEM;
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
    
    if (MemRead_EX && //load word followed by dependent instruction
       ((RD_EX == RS_ID) ||
        (RD_EX == RT_ID)) && 
        (RD_EX != 0) && ~MemWrite_ID && ~MemRead_ID) begin 
            stall <= 1;
            FlushID <= 1;
            end
    else if (MemRead_EX && //load word followed by dependent instruction
       (RD_EX == RS_ID)  &&  
        (RD_EX != 0) && ~MemWrite_ID && MemRead_ID ) begin 
            stall <= 1;
            FlushID <= 1;
            end
    else if (MemRead_EX && //load word followed by dependent sw
       (RD_EX == RS_ID) && 
        (RD_EX != 0) && MemWrite_ID) begin 
            stall <= 1;
            FlushID <= 1;
            end
    if (RegWrite_EX && Branch && // any instruction which writes to a register followed by dependent branch
       ((RD_EX == RS_ID) ||
         (RD_EX == RT_ID)) &&
         (RD_EX !=0)) begin
         stall<=1;
         FlushID <= 1;
         end
     if (MemRead_Mem  && // load word followed by dependent branch 2nd stall // this is triggering 
         ((RD_MEM == RS_ID) ||
          (RD_MEM == RT_ID)) &&
          (RD_MEM !=0) && Branch) begin
           stall<=1;
           FlushID <= 1;
           end   
        /*
     if (MemRead_Mem  && // load word followed by dependent branch 2nd stall // this is triggering 
        ((RD_EX == RS_ID) ||
         (RD_EX == RT_ID)) &&
         (RD_EX !=0)) begin
          stall<=1;
          FlushID <= 1;
          end   
    */
              
    end
    
endmodule