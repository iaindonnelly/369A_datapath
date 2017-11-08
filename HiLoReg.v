`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 04:43:40 PM
// Design Name: 
// Module Name: HiLoReg
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


module HiLoReg( WriteHi, WriteLo, Clk, ReadData1, ReadData2, WriteData1,WriteData2);
       input WriteHi;
       input WriteLo;
       input Clk;
       input [31:0] WriteData1;
       input [31:0] WriteData2;
       output reg [31:0] ReadData1;
       output reg [31:0] ReadData2;
       reg [31:0] Hi;
       reg [31:0] Lo;
       
       initial begin 
           Hi <= 0;
           Lo <= 0;
       end 
       always@(negedge Clk)begin
       if (WriteHi == 1) begin 
             Hi <= WriteData1;
       end
       if (WriteLo == 1 ) begin 
             Lo <= WriteData2;
       end  
       end 
       
       always@(posedge Clk)begin 
              ReadData1 <= Hi;
              ReadData2 <= Lo;
       end

endmodule
