`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
module DataPath(Rst, Clk,writeData,PCResultO);
    
    
    input Rst, Clk;
    output reg [31:0] PCResultO;
    wire [31:0] WriteData;
    
      
   
   
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
          wire [1:0] ForwardA;
          wire [1:0] ForwardB;
          wire [31:0] AluAin;
          wire [31:0] AluBin;
          wire [31:0] Instruction_EX;
          wire FlushID;
          wire FlushIF;
          wire ContFlush;
          wire IDFlush;
          wire stall;
          wire ForwardA_ID;
          wire ForwardB_ID;
          wire Forward_MEM;
          wire [31:0] RS_F;
          wire [31:0] RT_F;
          wire [31:0] RT_MEM_F;
          
   Mux32Bit2To1 PCSRC(Address, PCAddResult, PC_Out, AndOut);   
  
   ProgramCounter PC(Address, PCResult, Rst, Clk,stall); 
   
  InstructionMemory IS(PCResult[11:2], Instruction);   
  //need to stall pcadder
  PCAdder PCA(PCResult, PCAddResult);
  
  IF_ID_Register IF_ID(Instruction, PCAddResult, Clk, PCAddResultOut, InstructionOut,ContFlush,stall);
  //Decode
  PCAdder JALADD(PCAddResultOut,JALAOut);
  //need to route select signal thorugh mem_wb                    bran
  Mux32Bit2To1 WriteDataM(WriteDataMout, WriteData , JALAOut , branchSel_WB);
    
  Mux5Bit2To1 JALM(JALMout, RegDest_WB, 5'd31, branchSel_WB);
  
  RegisterFile Regs(InstructionOut[25:21], InstructionOut[20:16], JALMout, WriteDataMout, RegWrite_WB, Clk, RS, RT); //regwrite
  
  SignExtension SE(InstructionOut[15:0], SignOut);
  
  ZeroExtension ZE(InstructionOut[15:0], ZeroextOut); 
  
  Controller Cont(InstructionOut[31:26],InstructionOut[5:0],ALUSrc,RegDst,RegWrite,ALUOp,MemRead,MemWrite,MemtoReg,Branch, ShiftOp,InstructionOut[21],InstructionOut[6],Hi_Write,Lo_Write,immUnsign,InstructionOut[20:16],branchRes,branchSel,DM_Sel_In,JSEl,ContFlush);
  // HazardDetection(Instruction,RD_EX,RT_ID,RS_ID,FlushID,FlushIF,stall,MemRead_EX)
  HazardDetection HazardUnit(InstructionOut,REGDST,InstructionOut[25:21], InstructionOut[20:16],FlushID,FlushIF,stall,MemRead_Out); //need to fill in correct values;
  
  ShiftLeft2 SHL2(SignOut,ShiftOut);
     
  Adder BranchADD(PCAddResultOut,ShiftOut,AdderOut); 
  
  SL2J SL22(InstructionOut[25:0],macaroni1out);

  macaroniMux macaroniMux1(MMOut, AdderOut, macaroni1out, RS_Out , JSEl,PCAddResultOut[31:28]);//need to send in rs
    
  Mux32Bit2To1 FORWARDIDA(RS_F, RS, RT_MEM, ForwardA_ID);
  
  Mux32Bit2To1 FORWARDIDB(RT_F, RT, RT_MEM, ForwardB_ID);
    
  BranchComp BranchRes(
       branchRes,
       RS_F,
       RT_F,
       ZeroFlag 
        );
        
     OR FLUSHOR(FlushID,ContFlush,IDFlush);
  
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
                        MMOut,
                        RS,
                        RT,
                        SignOut,
                        ZeroextOut,
                        InstructionOut[20:16],
                        InstructionOut[15:11],
                        branchSel,
                        DM_Sel_In,
                        ZeroFlag,
                        InstructionOut,
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
                        ZeroOut,
                        Instruction_EX,
                        IDFlush
                        );
                        
                       
   //EX                             
   //ForwardingUnitEX(RD_MEM,RS_EX,RD_WB,RT_EX,RegWrite_EX,RegWrite_WB,ForwardA,ForwardB,RegWrite_MEM,ForwardA_ID,ForwardB_ID,RT_ID,RS_ID,MemWrite_MEM,Forward_MEM)
   ForwardingUnitEX FU(RegDest_MEM,Instruction_EX[25:21],RegDest_WB,Instruction_EX[20:16],RegWrite_Out,RegWrite_WB,ForwardA,ForwardB,RegWrite_MEM,ForwardA_ID,ForwardB_ID,InstructionOut[20:16],InstructionOut[25:21],MemWrite_MEM,Forward_MEM); //might need to split up so not slow
   
   Mux5Bit2To1 RegDestination(REGDST, RegDest1_Out, RegDest2_Out, RegDst_Out);
   
   Mux32Bit3To1 ALUBmux(RT_Out,ALUResult_MEM,WriteData,AluBin, ForwardB);//
   
   Mux32Bit2To1 ALUsource(ALUB, AluBin, ALUIMM, ALUSrc_Out);   //
   
   Mux32Bit2To1 signed_unsigned(ALUIMM, Sign_Extend_Out, Zero_Extend_Out, ImUnsign_Out);
   
   Mux32to5 shamt_sel(ALUShamt, ALUIMM[10:6], RS_Out[4:0], ShiftOp_Out); 
 
   HiLoReg HILO( Hi_Write_Out, Lo_Write_Out, Clk, Hi_in, Lo_in, Hi,ALUResult);
    
   Mux32Bit3To1 ALUAmux(RS_Out,WriteData,ALUResult_MEM,AluAin, ForwardA); //forwarding muxes
    
   ALU32Bit ALU(ALUOp_Out, AluAin, ALUB, ALUResult, Zero,ALUShamt,Hi,Hi_in,Lo_in);  //change inputs            
   
   AndGate BranchAnd(PCSrc_Out,ZeroOut,AndOut);     


   EX_MEM_Register EX_MEM( RegWrite_Out, //missing zeroflag
                          MemToReg_Out,
                          MemRead_Out, 
                          MemWrite_Out, 
                          ALUResult,
                          AluBin, //dis RT_Out need different mux to determine B, alubmux needs to be input a to alusrc mux
                          REGDST,
                          branchSel_Out,
                          DM_Sel_Out,
                          Clk, 
                          RegWrite_MEM, 
                          MemToReg_MEM, 
                          MemRead_MEM, 
                          MemWrite_MEM, 
                          ALUResult_MEM,
                          RT_MEM,
                          RegDest_MEM,
                          branchSel_MEM,
                          DM_Sel_MEM
                          );
 
//MEM 
    //need to add 3 to 1 mux 
    Mux32Bit2To1 FORWARD_MEM(RT_MEM_F, RT_MEM, WriteData, Forward_MEM);
    // Mux3to1(out, inA, sel)
    Mux3to1 DATAMEMW(DMWout, RT_MEM_F, DM_Sel_MEM);
          //DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData,DM_SEL)
    DataMemory DATAMem(ALUResult_MEM[11:0], DMWout, Clk, MemWrite_MEM, MemRead_MEM, ReadData_MEM,DM_Sel_MEM); 
    
    Mux3to1signed DATAMEMR(DMRout,ReadData_MEM , DM_Sel_MEM);
 
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
