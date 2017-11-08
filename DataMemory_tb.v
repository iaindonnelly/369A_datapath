`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
	   Address <= 0;
	   WriteData <= 42;
	   #20
	   Address <= 1023;
	   WriteData <= 42;
	   #20
	   Address <= 0;
	   MemRead <=1;
       WriteData <= 42;
       #20
       MemRead <= 0;
       Address <= 0;
       MemWrite <=1;
       WriteData <= 42;
       #20
       MemWrite <= 0;
       Address <= 0;
       MemRead <=1;
       WriteData <= 42;
       #20
       Address <= 1023;
       MemRead <=1;
       WriteData <= 42;
       #20
       MemRead <= 0;
       Address <= 1023;
       MemWrite <=1;
       WriteData <= 42;
       #20
       MemWrite <= 0;
       Address <= 1023;
       MemRead <=1;
       WriteData <= 42;
    /* Please fill in the implementation here... */
	
	end

endmodule

