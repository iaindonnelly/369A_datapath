`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg unsigned [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs
    reg [4:0] shamt;
    reg [31:0] Hi_in;
    reg [31:0] Lo_in;
    wire [31:0] Hi;
	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(ALUControl, A, B, ALUResult, Zero,shamt,Hi,Hi_in,Lo_in);

	initial begin
	#20
	ALUControl <= 0;
	A <= 5;
	B <= 5;
	#20
	ALUControl <= 1;
	ALUControl <= 1;
    A <= 5;
    B <= 6;
    #20
    ALUControl <= 2;
    A <= 5;
    B <= 6;
    #20
    ALUControl <= 3;
    A <= 5'b10000;
    B <= 5'b10001;
    #20
    ALUControl <= 4;
    A <= 5'b10000;
    B <= 5'b10001;
    #20
     ALUControl <= 5;
    A <= 5'b10000;
    B <= 5'b10001;
    #20
    ALUControl <= 6;
    A <= 5'b10000;
    B <= 5'b10001; //should do 01110 or 14
    #20
    ALUControl <= 7; //problem?
    shamt <= 4;
    A <= 5'b10000;
    B <= 5'b10001;
     //should be 1 
    #20
    ALUControl <= 8;
    shamt <= 2;
    A <= 5'b10000;
    B <= 5'b10001;
     //should be 64 
    #20
     ALUControl <= 9;
    A <= 5'b10000;
    B <= 5'b10001;
     //should be 0 
    #20
    ALUControl <= 10;
      A <= 5'b10000;
      B <= 5'b10001;
     #20
    ALUControl <= 11;
    A <= 5'b10000;
    B <= 5'b10001;
    #20
     ALUControl <= 12;
      A <= 5'b10000;
      B <= 5'b10001;
      #20
      ALUControl <= 13;
      A <= 32'b10000000000000000000000000100010;
      //B <= 32'b10001;
      shamt <= 5;
      #20
      ALUControl <= 14;
      A <= 100;
      Hi_in <= 6;
      Lo_in <= 5;
      #20
      ALUControl <= 15;
        A <= 100;
        Hi_in <= 6;
        Lo_in <= 5;
  
	end

endmodule

