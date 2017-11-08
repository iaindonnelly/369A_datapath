`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2017 01:22:23 PM
// Design Name: 
// Module Name: Mux3to1signed
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


module Mux3to1signed(out, inA, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    
    input [1:0] sel;
    
    always@(sel, inA) begin
        if (sel == 0) begin // changed
            out <= inA;
        end
        else if ( sel == 1) begin
            if(inA[15] == 0) begin 
                out <= {16'd0,inA[15:0]};
            end
            else begin 
                out <= {16'b1111111111111111,inA[15:0]};
            end
            
        end
        else if (sel == 2) begin //not working 
           if(inA[7] == 0) begin 
              out <= {24'd0,inA[7:0]};
           end
           else begin
              out <= {24'b111111111111111111111111,inA[7:0]};
           end
        end
        else begin 
            out <= inA;
        end
    end 

endmodule

