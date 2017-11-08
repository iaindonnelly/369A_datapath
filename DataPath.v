`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
module DataPath(Rst, Clk,writeData,PCResultO);
    
    
    input Rst, Clk;
    output reg [31:0] PCResultO;
    wire [31:0] WriteData;
    
      
   
   //need to make all shit  
          output reg [31:0] writeData;
          wire [31:0] Address;
          wire  RegWrite; 
          wire MemtoReg;
          wire MemRead; 
          wire MemWrite; 
          wire  Branch; 
          wire ALUSrc;
          wire RegDst;
          wire [4:0] ALUOp;
          wire ShiftOp;
          wire Hi_Write;
          wire Lo_Write;                     
          wire immUnsign;
          wire [31:0] PCAddResultOut;
          wire [31:0] RS;
          wire [31:0] RT;
          wire [31:0] SignOut;
          wire [31:0] ZeroextOut;
          wire [31:0] InstructionOut; 
          wire RegWrite_Out; 
          wire MemToReg_Out;
          wire MemRead_Out; 
          wire MemWrite_Out; 
          wire PCSrc_Out; 
          wire ALUSrc_Out; 
          wire RegDst_Out; 
          wire [4:0] ALUOp_Out;
          wire ShiftOp_Out;
          wire Hi_Write_Out;
          wire Lo_Write_Out;                      
          wire ImUnsign_Out;
          wire [31:0] PC_Out; //what bit#
          wire [31:0] RS_Out;
          wire [31:0] RT_Out;
          wire [31:0] Sign_Extend_Out;
          wire [31:0] Zero_Extend_Out;
          wire [4:0] RegDest1_Out;
          wire [4:0] RegDest2_Out;
          wire AndOut;   
          wire [31:0] AdderOut;
          wire [31:0] ALUResult;
          wire [4:0] REGDST;
          wire Zero; 
          wire RegWrite_MEM; 
          wire MemToReg_MEM; 
          wire MemRead_MEM; 
          wire MemWrite_MEM; 
          wire PCSrc_MEM; 
          wire [31:0] AddResult_MEM;
          wire [31:0] ALUResult_MEM;
          wire [31:0] RT_MEM;
          wire [4:0] RegDest_MEM;
          wire ZeroOut;
          wire [31:0] PCAddResult;
          wire [31:0] PCResult;
          wire [31:0] Instruction;
          wire RegWrite_WB; 
          wire MemToReg_WB; 
          wire [31:0]DataMem_WB;
          wire [31:0] ALUResult_WB;
          wire [4:0] RegDest_WB;
          wire [31:0] ALUIMM;
          wire [31:0] ALUB;
          wire [4:0] ALUShamt;
          wire [31:0] ShiftOut; //32bits?????????????????
          wire [31:0] Lo_in;
          wire [31:0] Hi_in;
          wire [31:0] Hi;
          wire [31:0] ReadData_MEM;
          wire [2:0] branchRes;
          wire branchSel;
          wire [1:0] DM_Sel_In;
          wire [2:0] branchRes_Out;
          wire branchSel_Out;
          wire [1:0] DM_Sel_Out;
          wire [1:0] DM_Sel_MEM;
          wire ZeroFlag;
          wire branchSel_MEM;
          wire [31:0] WriteDataMout;
          wire [4:0] JALMout;
          wire [31:0] DMWout;
          wire [31:0] DMRout;
          wire [31:0] InstructionEX;
          wire [27:0] macaroni1out;
          wire [31:0] MMOut;
          wire [31:0] JALAOut;
          wire branchSel_WB;
          wire [1:0] JSEl;
          wire [1:0] JSEl_Out;
  //  ClkDiv ClkDiv1(Clkin, 0, Clk);
  //IF
  
  
   Mux32Bit2To1 PCSRC(Address, PCAddResult, AddResult_MEM, AndOut);   
  
   ProgramCounter PC(Address, PCResult, Rst, Clk); 
   
  InstructionMemory IS(PCResult[11:2], Instruction);   
  
  PCAdder PCA(PCResult, PCAddResult);
  
  IF_ID_Register IF_ID(Instruction, PCAddResult, Clk, PCAddResultOut, InstructionOut);
  //Decode
  PCAdder JALADD(PCAddResultOut,JALAOut); 
  //need to route select signal thorugh mem_wb                    bran
  Mux32Bit2To1 WriteDataM(WriteDataMout, WriteData , JALAOut , branchSel_WB);
    
  Mux5Bit2To1 JALM(JALMout, RegDest_WB, 5'd31, branchSel_WB);
  
  RegisterFile Regs(InstructionOut[25:21], InstructionOut[20:16], JALMout, WriteDataMout, RegWrite_WB, Clk, RS, RT); //regwrite
  
  SignExtension SE(InstructionOut[15:0], SignOut);
 
  ZeroExtension ZE(InstructionOut[15:0], ZeroextOut); //why is vivado autistic?
  
  Controller Cont(InstructionOut[31:26],InstructionOut[5:0],ALUSrc,RegDst,RegWrite,ALUOp,MemRead,MemWrite,MemtoReg,Branch, ShiftOp,InstructionOut[21],InstructionOut[6],Hi_Write,Lo_Write,immUnsign,InstructionOut[20:16],branchRes,branchSel,DM_Sel_In,JSEl);
  
   ID_EX_Register ID_EX( RegWrite, 
                        MemtoReg,
                        MemRead, 
                        MemWrite, 
                        Branch, 
                        ALUSrc,
                        RegDst,
                        ALUOp,
                        ShiftOp,
                        Hi_Write,
                        Lo_Write,                     
                        immUnsign,
                        PCAddResultOut,
                        RS,
                        RT,
                        SignOut,
                        ZeroextOut,
                        InstructionOut[20:16],
                        InstructionOut[15:11],
                        branchRes,
                        branchSel,
                        DM_Sel_In,
                        InstructionOut,
                        JSEl,
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
                        branchRes_Out,
                        branchSel_Out,
                        DM_Sel_Out,
                        InstructionEX,
                        JSEl_Out
                        );
                        
                       
   //EX
   Mux5Bit2To1 RegDestination(REGDST, RegDest1_Out, RegDest2_Out, RegDst_Out);//excellent signal names, also should be 5bit 2 to 1,also broken?
   
   Mux32Bit2To1 ALUsource(ALUB, RT_Out, ALUIMM, ALUSrc_Out);   
   
   Mux32Bit2To1 signed_unsigned(ALUIMM, Sign_Extend_Out, Zero_Extend_Out, ImUnsign_Out);
   
   Mux32to5 shamt_sel(ALUShamt, ALUIMM[10:6], RS_Out[4:0], ShiftOp_Out); 
   
   ShiftLeft2 SHL2(ALUIMM,ShiftOut);
   
   Adder BranchADD(PC_Out,ShiftOut,AdderOut); 
   
   HiLoReg HILO( Hi_Write_Out, Lo_Write_Out, Clk, Hi_in, Lo_in, Hi,ALUResult); 
   
   ALU32Bit ALU(ALUOp_Out, RS_Out, ALUB, ALUResult, Zero,ALUShamt,Hi,Hi_in,Lo_in);                 
   
   SL2J SL22(InstructionEX[25:0],macaroni1out);
   //concatenate with most pc + 4[31:28],
   macaroniMux macaroniMux1(MMOut, AdderOut, macaroni1out, RS_Out , JSEl_Out,PC_Out[31:28]);//need to send in rs
   
   BranchComp BranchRes(
      branchRes_Out,
      RS_Out,
      ALUB,
      ZeroFlag 
       
       );
   EX_MEM_Register EX_MEM( RegWrite_Out, //missing zeroflag
                          MemToReg_Out,
                          MemRead_Out, 
                          MemWrite_Out, 
                          PCSrc_Out, 
                          MMOut,
                          ALUResult,
                          ZeroFlag,
                          RT_Out,
                          REGDST,
                          branchSel_Out,
                          DM_Sel_Out,
                          Clk, 
                          RegWrite_MEM, 
                          MemToReg_MEM, 
                          MemRead_MEM, 
                          MemWrite_MEM, 
                          PCSrc_MEM, 
                          AddResult_MEM,
                          ALUResult_MEM,
                          ZeroOut,
                          RT_MEM,
                          RegDest_MEM,
                          branchSel_MEM,
                          DM_Sel_MEM
                          );
 
//MEM 
    //need to add 3 to 1 mux 
    Mux3to1 DATAMEMW(DMWout, RT_MEM, DM_Sel_MEM);
    
    DataMemory DATAMem(ALUResult_MEM[11:2], DMWout, Clk, MemWrite_MEM, MemRead_MEM, ReadData_MEM); 
    
    Mux3to1signed DATAMEMR(DMRout,ReadData_MEM , DM_Sel_MEM);
   //need to have signext after?
    AndGate BranchAnd(PCSrc_MEM,ZeroOut,AndOut);  
    
MEM_WB_Register MEM_WB(       RegWrite_MEM,  
                           MemToReg_MEM,
                           DMRout,
                           ALUResult_MEM,//
                           RegDest_MEM,
                           branchSel_MEM,
                           Clk, 
                           RegWrite_WB, 
                           MemToReg_WB, 
                           DataMem_WB,
                           ALUResult_WB,
                           RegDest_WB,
                           branchSel_WB
                           );

    Mux32Bit2To1 memtoReg(WriteData, DataMem_WB, ALUResult_WB, MemToReg_WB);
    always@(*)begin
    writeData <= WriteData;
    PCResultO <= PCAddResult;
    end
endmodule