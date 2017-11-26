`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: FILL IN YOUR INFO HERE!
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module MEM_WB_Register( RegWrite_In, 
                       MemToReg_In,
                       DataMem_In,
                       ALUResult_In,
                       RegDest_In,
                       branchSel_In,
                       Clk, 
                       RegWrite_Out, 
                       MemToReg_Out, 
                       DataMem_Out,
                       ALUResult_Out,
                       RegDest_Out,
                       branchSel_Out,
                       Rst
                       );
                       
       //WB Stage Signals 
       input Rst;               
       input RegWrite_In;                
       input MemToReg_In;
      input branchSel_In;
       
       output reg branchSel_Out;
       output reg RegWrite_Out; 
       output reg MemToReg_Out; 
       
       input Clk; 
       
       //data lines
       input [31:0] DataMem_In;
       input [31:0] ALUResult_In;
       input [4:0] RegDest_In;
       
       output reg [31:0] DataMem_Out;
       output reg [31:0] ALUResult_Out;
       output reg [4:0] RegDest_Out;
       
       
   initial begin    
       DataMem_Out <= 0 ;
       ALUResult_Out <= 0;
       RegDest_Out <= 0;
       RegWrite_Out <= 0; 
       MemToReg_Out <= 0; 
       branchSel_Out <= 0;
     end  
       
       
       always@(posedge Clk)begin
       if(Rst) begin
       DataMem_Out <= 0 ;
       ALUResult_Out <= 0;
       RegDest_Out <= 0;
       RegWrite_Out <= 0; 
       MemToReg_Out <= 0; 
       branchSel_Out <= 0;
           end
       else begin
       
       branchSel_Out <= branchSel_In;
       RegWrite_Out <= RegWrite_In;
       MemToReg_Out <= MemToReg_In;
       DataMem_Out <= DataMem_In;
       ALUResult_Out <= ALUResult_In;
       RegDest_Out <= RegDest_In;
       end    
       end

endmodule
