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

module EX_MEM_Register( RegWrite_In, 
                       MemToReg_In,
                       MemRead_In, 
                       MemWrite_In, 
                     //  PCSrc_In, 
                     //  AddResult_In,
                       ALUResult_In,
                    //   Zero_In,
                       RT_In,
                       RegDest_In,
                       branchSel_In,
                       DM_Sel_In,
                       Clk, 
                       RegWrite_Out, 
                       MemToReg_Out, 
                       MemRead_Out, 
                       MemWrite_Out, 
                     //  PCSrc_Out, 
                     //  AddResult_Out,
                       ALUResult_Out,
                      // Zero_Out,
                       RT_Out,
                       RegDest_Out,
                       branchSel_Out,
                       DM_Sel_Out);
       //WB Stage Signals                
       input RegWrite_In;                
       input MemToReg_In;
       input branchSel_In;
       
       output reg RegWrite_Out; 
       output reg MemToReg_Out; 
       output reg branchSel_Out;
       //Mem Stage Signals
       input MemRead_In; 
       input MemWrite_In; 
       input [1:0] DM_Sel_In;
       
       output reg [1:0] DM_Sel_Out;
       output reg MemRead_Out;
       output reg MemWrite_Out; 
   
       
       input Clk; 
       
       //data lines
       //input [31:0] AddResult_In;
       input [31:0] ALUResult_In;
       input [31:0] RT_In;
       input [4:0] RegDest_In;

       output reg [31:0] ALUResult_Out;
       output reg [31:0] RT_Out;
       output reg [4:0] RegDest_Out;
      // output reg Zero_Out;
    initial begin      
       
       MemRead_Out <= 0;
       MemWrite_Out <= 0; 
       ALUResult_Out <= 0;
       RT_Out<=0;
       RegDest_Out<=0;
       RegWrite_Out <=0; 
       MemToReg_Out <=0; 
       branchSel_Out <= 0;
       DM_Sel_Out <= 0;
       end     
       
        
   always@(posedge Clk)begin

        DM_Sel_Out = DM_Sel_In;
        branchSel_Out = branchSel_In;
        RegWrite_Out = RegWrite_In;
         MemToReg_Out = MemToReg_In;
         MemRead_Out = MemRead_In;
         MemWrite_Out = MemWrite_In;
         ALUResult_Out = ALUResult_In;
         RT_Out = RT_In;
         RegDest_Out = RegDest_In;
    end

endmodule
