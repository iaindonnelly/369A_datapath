`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out);
/* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;   //using always @
    //output [31:0] out;   //using assign statement
    
    always @(in) begin
        if (in < 16'h8000) begin
            out <= 0;
            out <= in;
        end
        else begin
            out <= 32'hFFFF0000 + in;
        end
    end
    /* Fill in the implementation here ... */

endmodule
