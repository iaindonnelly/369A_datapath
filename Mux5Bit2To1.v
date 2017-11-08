`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2017 11:00:29 AM
// Design Name: 
// Module Name: Mux5Bit2To1
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


module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;
    
    always@(sel, inA, inB) begin
        if (sel == 0) begin // changed
            out <= inA;
        end
        else begin
            out <= inB;
        end
    end 

endmodule


