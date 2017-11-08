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
                       PCSrc_In, 
                       AddResult_In,
                       ALUResult_In,
                       Zero_In,
                       RT_In,
                       RegDest_In,
                       branchSel_In,
                       DM_Sel_In,
                       Clk, 
                       RegWrite_Out, 
                       MemToReg_Out, 
                       MemRead_Out, 
                       MemWrite_Out, 
                       PCSrc_Out, 
                       AddResult_Out,
                       ALUResult_Out,
                       Zero_Out,
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
       input PCSrc_In; 
       input [1:0] DM_Sel_In;
       
       output reg [1:0] DM_Sel_Out;
       output reg MemRead_Out;
       output reg MemWrite_Out; 
       output reg PCSrc_Out; 
       
       input Clk; 
       
       //data lines
       input [31:0] AddResult_In;
       input [31:0] ALUResult_In;
       input [31:0] RT_In;
       input [4:0] RegDest_In;
       input Zero_In;
       
       output reg [31:0] AddResult_Out;
       output reg [31:0] ALUResult_Out;
       output reg [31:0] RT_Out;
       output reg [4:0] RegDest_Out;
       output reg Zero_Out;
               reg RegWrite; 
              reg MemToReg; 
              reg MemRead; 
              reg MemWrite; 
              reg PCSrc; 
              reg ALUSrc; 
              reg RegDst; 
              reg ALUOp;
              reg ShiftOp;
              reg Hi_Write ;
              reg Lo_Write;
              reg ImUnsign;
              reg [31:0] AddResult;
              reg [31:0] ALUResult;
              reg [31:0] Hi_Lo;
              reg [31:0] RT;
              reg [4:0] RegDest;
              reg Zero;
              reg [1:0] DM_Sel;
              reg branchSel;
              
    initial begin      
       RegWrite <= 0; 
       MemToReg <= 0; 
       MemRead <= 0; 
       MemWrite <= 0; 
       PCSrc <= 0; 
       ALUSrc <= 0; 
       RegDst <= 0; 
       ALUOp <= 0;
       ShiftOp <= 0;
       Hi_Write <= 0;
       Lo_Write <= 0;
       ImUnsign <= 0;
       AddResult <= 0;
       ALUResult <= 0;
       Hi_Lo <= 0;
       RT <= 0;
       RegDest <= 0;
       Zero <= 0;
       MemRead_Out <= 0;
       MemWrite_Out <= 0; 
       PCSrc_Out <= 0; 
       AddResult_Out <=0;
       ALUResult_Out <= 0;
       RT_Out<=0;
       RegDest_Out<=0;
       Zero_Out<=0;
       RegWrite_Out <=0; 
       MemToReg_Out <=0; 
       branchSel_Out <= 0;
       DM_Sel_Out <= 0;
       branchSel <= 0;
       DM_Sel <= 0;
       end     
       
        
   always@(posedge Clk)begin
       DM_Sel <= DM_Sel_In;
       branchSel <= branchSel_In;
       RegWrite <= RegWrite_In;
       MemToReg <= MemToReg_In;
       MemRead <= MemRead_In;
       MemWrite <= MemWrite_In;
       PCSrc <= PCSrc_In;
       AddResult <= AddResult_In;
       ALUResult <= ALUResult_In;
       RT <= RT_In;
       RegDest <= RegDest_In;
       Zero <= Zero_In;
       
        DM_Sel_Out = DM_Sel;
        branchSel_Out = branchSel;
        RegWrite_Out = RegWrite;
         MemToReg_Out = MemToReg;
         MemRead_Out = MemRead;
         MemWrite_Out = MemWrite;
         PCSrc_Out = PCSrc;
         AddResult_Out = AddResult;
         ALUResult_Out = ALUResult;
         RT_Out = RT;
         RegDest_Out = RegDest;
         Zero_Out = Zero;
    end

endmodule
