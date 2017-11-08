`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2017 02:50:45 PM
// Design Name: 
// Module Name: Mux32to5
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


module Mux32to5(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;
    
    always@(sel, inA, inB) begin
        if (sel == 0) begin//changed?
            out <= inA[4:0];
        end
        else begin
            out <= inB[4:0];
        end
    end 

endmodule
