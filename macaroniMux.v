`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2017 05:50:46 PM
// Design Name: 
// Module Name: macaroniMux
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


module macaroniMux(out, inA, inB,inC, sel,INSstr);

    output reg [31:0] out;
    input [31:0] INSstr;
    input [31:0] inC;
    input [31:0] inA;
    input [27:0] inB;
    input [1:0]  sel;
    
    always@(sel, inA, inB) begin
        if(sel == 0) begin 
         out <= inA;
        end
        else if (sel == 1) begin // changed
            out <= {INSstr[31:28],inB};
        end
        else if(sel == 2) begin
            out <= inC;
        end
        else begin
            out <= inA;
        end
    end 

endmodule
