`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2017 09:01:09 AM
// Design Name: 
// Module Name: Mux3to1
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


module Mux3to1(out, inA, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    
    input [1:0] sel;
    
    always@(sel, inA) begin
        if (sel == 0) begin // changed
            out <= inA;
        end
        else if ( sel == 1) begin
            out <= {16'd0,inA[15:0]};
        end
        else if (sel == 2) begin
            out <= {24'd0,inA[7:0]};
        end
        else begin 
            out <= inA;
        end
    end 

endmodule
