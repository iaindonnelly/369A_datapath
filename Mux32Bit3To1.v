`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2017 11:25:13 AM
// Design Name: 
// Module Name: Mux32Bit3To1
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


module Mux32Bit3To1(inA,inB,inC,out, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] sel;
    
    always@(sel, inA, inB) begin
        if (sel == 2'b00) begin // changed
            out <= inA;
        end
        else if (sel == 2'b01) begin
            out <= inB;
        end
        else if(sel == 2'b10) begin
            out <= inC;
        end
    end 

endmodule
