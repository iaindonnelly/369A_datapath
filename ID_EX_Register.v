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

module ID_EX_Register( RegWrite_In, 
                       MemToReg_In,
                       MemRead_In, 
                       MemWrite_In, 
                       PCSrc_In, 
                       ALUSrc_In,
                       RegDst_In,
                       ALUOp_In,
                       ShiftOP_In,
                       Hi_Write_In,
                       Lo_Write_In,                     
                       ImUnsign_In,
                       PC_In,
                       RS_In,
                       RT_In,
                       Sign_Extend_In,
                       Zero_Extend_In,
                       RegDest1_In,
                       RegDest2_In,
                       branchSel_In,
                       DM_Sel_In,
                     //  Instruction_In,
                       //JSEl_In,
                       Zero_In,
                       Instruction_In,
                       Clk, 
                       RegWrite_Out, 
                       MemToReg_Out, 
                       MemRead_Out, 
                       MemWrite_Out, 
                       PCSrc_Out, 
                       ALUSrc_Out, 
                       RegDst_Out, 
                       ALUOp_Out,
                       ShiftOp_Out,
                       Hi_Write_Out,
                       Lo_Write_Out,                      
                       ImUnsign_Out,
                       PC_Out,
                       RS_Out,
                       RT_Out,
                       Sign_Extend_Out,
                       Zero_Extend_Out,
                       RegDest1_Out,
                       RegDest2_Out,
                       branchSel_Out,
                       DM_Sel_Out,
                    //   Instruction_Out,
                       Zero_Out,
                       Instruction_Out,
                       Flush);
        //               JSEl_Out);
       //WB Stage Signals                
       input RegWrite_In;                
       input MemToReg_In;
       input Flush;
       
       output reg RegWrite_Out; 
       output reg MemToReg_Out; 
       
       //Mem Stage Signals
       input MemRead_In; 
       input MemWrite_In; 
       input PCSrc_In; 
       
       output reg MemRead_Out;
       output reg MemWrite_Out; 
       output reg PCSrc_Out; 
       
       //EX Stage Signals
       input [31:0] Instruction_In;
       input ALUSrc_In;
       input RegDst_In;
       input ShiftOP_In;
       input Hi_Write_In;
       input Lo_Write_In;       
       input ImUnsign_In;
      //input [2:0] branchRes_In;
       input branchSel_In;
       input [1:0] DM_Sel_In;
    //   input [1:0] JSEl_In;
       input Zero_In; 
       
       input [4:0] ALUOp_In;
       
     //  output reg [1:0] JSEl_Out;
       output reg Zero_Out;
       output reg [31:0] Instruction_Out;
       output reg ALUSrc_Out; 
       output reg RegDst_Out; 
       output reg ShiftOp_Out;
       output reg Hi_Write_Out;
       output reg Lo_Write_Out;    
       output reg ImUnsign_Out;
      // output reg [2:0] branchRes_Out;
       output reg branchSel_Out;
       output reg [1:0] DM_Sel_Out;
       
       output reg [4:0] ALUOp_Out;
       
       input Clk; 
       
       //data lines
       input [31:0] PC_In;
       input [31:0]RS_In;
       input [31:0] RT_In;
       input [31:0] Sign_Extend_In;
       input [31:0] Zero_Extend_In;
       input [4:0] RegDest1_In;
       input [4:0] RegDest2_In;
       
       output reg [31:0] PC_Out;
       output reg [31:0] RS_Out;
       output reg [31:0] RT_Out;
       output reg [31:0] Sign_Extend_Out;
       output reg [31:0] Zero_Extend_Out;
       output reg [4:0] RegDest1_Out;
       output reg [4:0] RegDest2_Out;
   
   
  initial begin     
      Instruction_Out <= 0;
       ALUSrc_Out <= 0; 
       RegDst_Out <= 0; 
       ShiftOp_Out <= 0;
       Hi_Write_Out<= 0;
       Lo_Write_Out<= 0;    
       ImUnsign_Out<= 0;
       PC_Out <= 0;
       RS_Out<= 0;
       RT_Out<= 0;
       Sign_Extend_Out<= 0;
       Zero_Extend_Out<= 0;
       RegDest1_Out<= 0;
       RegDest2_Out<= 0;
       MemRead_Out <= 0;
       MemWrite_Out <= 0; 
       PCSrc_Out <= 0; 
       RegWrite_Out <= 0; 
       MemToReg_Out <= 0; 
       //branchRes_Out  <= 0;
       branchSel_Out <= 0;
       DM_Sel_Out <= 0;
       //JSEl_Out <= 0;
    end   
       
        
       always@(posedge Clk)begin
       if (Flush == 1) begin
       Instruction_Out <= 0;
          ALUSrc_Out <= 0; 
          RegDst_Out <= 0; 
          ShiftOp_Out <= 0;
          Hi_Write_Out<= 0;
          Lo_Write_Out<= 0;    
          ImUnsign_Out<= 0;
          PC_Out <= 0;
          RS_Out<= 0;
          RT_Out<= 0;
          Sign_Extend_Out<= 0;
          Zero_Extend_Out<= 0;
          RegDest1_Out<= 0;
          RegDest2_Out<= 0;
          MemRead_Out <= 0;
          MemWrite_Out <= 0; 
          PCSrc_Out <= 0; 
          RegWrite_Out <= 0; 
          MemToReg_Out <= 0; 
          branchSel_Out <= 0;
          DM_Sel_Out <= 0;
       end
       else begin
       Zero_Out <= Zero_In;
       Instruction_Out <= Instruction_In;
       //branchRes_Out  <= branchRes_In;
       branchSel_Out <=  branchSel_In;
       DM_Sel_Out <= DM_Sel_In;
       RegWrite_Out <= RegWrite_In;
       MemToReg_Out <= MemToReg_In;
       MemRead_Out <= MemRead_In;
       MemWrite_Out <= MemWrite_In;
       PCSrc_Out <= PCSrc_In;
       ALUSrc_Out <= ALUSrc_In;
       RegDst_Out <= RegDst_In;
       ALUOp_Out <= ALUOp_In;
       ShiftOp_Out <= ShiftOP_In;
       Hi_Write_Out <= Hi_Write_In;
       Lo_Write_Out <= Lo_Write_In;
       ImUnsign_Out <= ImUnsign_In;
       PC_Out <= PC_In;
       RS_Out <= RS_In;
       RT_Out <= RT_In;
       Sign_Extend_Out <= Sign_Extend_In;
       Zero_Extend_Out <= Zero_Extend_In;
       RegDest1_Out <= RegDest1_In;
       RegDest2_Out <= RegDest2_In;
       //JSEl_Out <= JSEl_In;
       end
       end

endmodule
