`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2017 03:58:56 PM
// Design Name: 
// Module Name: Controller
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
//////////////////////////////////////////////////////////////////////////////////


module Controller(OpCode,func,ALUSrc,RegDst,RegWrite,ALUOp,MemRead,MemWrite,MemtoReg,Branch, ShiftOp,Instr,InstrV,Hi_write,Lo_write,immUnsign,branchRT,branchRes,branchSel,DM_Sel,JSEl); 
    input Instr;//21st bit
    input InstrV;//7th bit
    input [5:0] OpCode;
    input [5:0] func;
    input [4:0] branchRT;
    output reg ALUSrc;
    output reg RegDst;
    output reg RegWrite;
    output reg [4:0] ALUOp;
    output reg MemRead;
    output reg MemWrite; 
    output reg MemtoReg;
    output reg Branch;
    output reg ShiftOp; //may need to modify sign extension to support more operations
    output reg Hi_write;
    output reg Lo_write;
    output reg immUnsign;
    output reg [2:0] branchRes;
    output reg branchSel;
    output reg [1:0] DM_Sel;
    output reg [1:0] JSEl;
    
    initial begin 
    
        ALUSrc <=0;
        RegDst<=0;
        RegWrite<=0;
        ALUOp<=0;
        MemRead<=0;
        MemWrite<=0; 
        MemtoReg<=0;
        Branch<=0;
        ShiftOp<=0; 
        Hi_write<=0;
        Lo_write<=0;
        immUnsign<=0;
        branchRes <= 0; 
        branchSel <= 0;
        DM_Sel <= 0;
        JSEl <= 0;
    end 
    //unsigned
    always@(*) begin //broken
    
                 ALUSrc <= 0;
                 RegDst <= 0;
                 RegWrite <= 0;
                 ALUOp <= 0;
                 MemRead <= 0; 
                 MemWrite <= 0;
                 MemtoReg <= 0;
                 Branch <= 0;
                 ShiftOp <= 0;
                 Hi_write <= 0;
                 Lo_write <= 0;
                 immUnsign <= 0;
                 branchRes <= 0; 
                 branchSel <= 0;
                 DM_Sel <= 0;
                 JSEl <= 0;
        if (OpCode == 0 && func == 6'b100000) begin //add
            ALUOp <= 5'b00000;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b100010) begin //sub 
            
            ALUOp <= 5'b00001;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b011000) begin //mult
           
            ALUOp <= 5'b00010;
            Hi_write <= 1;
            Lo_write <= 1;
        end 
        else if (OpCode == 0 && func == 6'b100100) begin //and
            
            ALUOp <= 5'b00011;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b100101) begin ///or
            ;
            ALUOp <= 5'b00100;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b100110) begin //xor
            
            ALUOp <= 5'b00101;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b100111) begin //nor
           
            ALUOp <= 5'b00110;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end 
        else if (OpCode == 0 && func == 6'b000010 && Instr == 0) begin //srl
            
            ALUOp <= 5'b00111;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end
        else if (OpCode == 0 && func == 6'b000000) begin //sll 
            
            ALUOp <= 5'b01000;
             RegWrite <= 1;
             MemtoReg <= 1;
             RegDst <= 1;
        end
        else if (OpCode == 0 && func == 6'b101010) begin  //slt
            
            ALUOp <= 5'b01001;
            RegWrite <= 1;
            MemtoReg <= 1; 
            RegDst <= 1;
        end  
         else if (OpCode == 0 && func == 6'b100001) begin //addu
           
           ALUOp <= 5'b00000;
           RegWrite <= 1;
           MemtoReg <= 1;
           RegDst <= 1;
           
       end  
       else if (OpCode == 0 && func == 6'b000010 && Instr == 1) begin //need to distinguish between SRL , ROTR
            
            ALUOp <= 5'b01101;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
            
        end 
        else if (OpCode == 6'b011100 && func == 6'b000100) begin //msub
            
            ALUOp <= 5'b01110;
            Hi_write <= 1;
            Lo_write <= 1;
            
        end 
        else if (OpCode == 6'b011100 && func == 6'b000000) begin //madd
            
            ALUOp <= 5'b01111;
           Hi_write <= 1;
           Lo_write <= 1;
           
        end                                                             
      else if (OpCode == 6'b001001) begin //addiu
          
          ALUOp <= 5'b00000;
          //signextop <= unsigned 
          RegWrite <= 1;
          MemtoReg <= 1;
          ALUSrc <= 1;
          //immUnsign <= 1;
      end 
     else if (OpCode == 6'b001000) begin //addi
        
        ALUOp <= 5'b00000;
        RegWrite <= 1;
        MemtoReg <= 1;
        ALUSrc <= 1;
        end 
        
    else if (OpCode == 6'b011100 && func == 6'b000010) begin //mul
        
        ALUOp <= 5'b00010;
        RegWrite <= 1;
        MemtoReg <= 1;
        RegDst <= 1;
       
       
        
    end 
    else if (OpCode == 6'b000000 && func == 6'b011001) begin //multu
        
        ALUOp <= 5'b11000;//
        Hi_write <= 1;
        Lo_write <= 1;
        
     end 
     else if (OpCode == 6'b001100) begin //andi
         
          ALUOp <= 5'b00011;
          RegWrite <= 1;
          MemtoReg <= 1;
          ALUSrc <= 1;
          immUnsign <= 1;
     
      end
      else if (OpCode == 6'b001101) begin //ori
       
        ALUOp <= 5'b00100;
        RegWrite <= 1;
        MemtoReg <= 1;
        ALUSrc <= 1;
        immUnsign <= 1;
    end 
    else if (OpCode == 6'b001110) begin //xori
          
          ALUOp <= 5'b00101;
         RegWrite <= 1;
         MemtoReg <= 1;
         ALUSrc <= 1;
         immUnsign <= 1;
      end
      else if (OpCode == 6'b011111 && func == 6'b100000) begin //sign extend halfword
        
        ALUOp <= 5'b10001; 
        RegWrite <= 1;
        MemtoReg <= 1;
        RegDst <= 1;
        
    end 
    else if (OpCode == 6'b000000 && func == 6'b000100) begin //sllv
        
        ALUOp <= 5'b01000;
        RegWrite <= 1;
        MemtoReg <= 1;
        RegDst <= 1;
        ShiftOp <= 1;
        
    end   
     else if (OpCode == 6'b000000 && func == 6'b000110 && InstrV == 0) begin //srlv 
        RegWrite <= 1;
        MemtoReg <= 1;
        RegDst <= 1;
        ALUOp <= 5'b00111;
        ShiftOp <= 1;
    end
    else if (OpCode == 6'b001010) begin //slti
        
        ALUOp <= 5'b01001;
         RegWrite <= 1;
         MemtoReg <= 1;
         ALUSrc <= 1;
     end  
     else if (OpCode == 6'b000000 && func == 6'b001011) begin //movn,may need to create new alu operation
        
         ALUOp <= 5'b01011;
         RegWrite <= 1;
         MemtoReg <= 1;
         RegDst <= 1;
      end
      else if (OpCode == 6'b000000 && func == 6'b001010) begin //movz,may need to create new alu operation
         
           ALUOp <= 5'b10000;
           RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
      end  
      else if (OpCode == 6'b000000 && func == 6'b000110 && InstrV == 1) begin //rotr, need additional condtn
           
           ALUOp <= 5'b01101;
           RegDst <= 1;
           RegWrite <= 1;
           MemtoReg <= 1;
           ShiftOp <= 1;          
        end
        else if (OpCode == 6'b000000 && func == 6'b000011) begin //sra, may need additional alu op to deal with 
           
           ALUOp <= 5'b01010;
           RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
      end  
      else if (OpCode == 6'b000000 && func == 6'b000111) begin //srav,may need to create new alu operation
             
             ALUOp <= 5'b01010;
             RegWrite <= 1;
             MemtoReg <= 1;
             RegDst <= 1;
            // ShiftOp <= 1;
        end   
        else if (OpCode == 6'b001011) begin //sltiu
             
             ALUOp <= 5'b10110;
             ALUSrc <=1;
             RegWrite <= 1;
             MemtoReg <= 1;
             immUnsign <= 1;  
                        
        end 
        else if (OpCode == 6'b000000 && func == 6'b101011) begin //sltu
             
             ALUOp <= 5'b10110;
            RegWrite <= 1;
            MemtoReg <= 1;
            RegDst <= 1;
        end  //need to also support mfhi mflo mthi mtlo
         else if (OpCode == 6'b000000 && func == 6'b010001) begin //mthi
                    
            ALUOp <= 5'b10010;
            Hi_write <= 1;
       end
       else if (OpCode == 6'b000000 && func == 6'b010011) begin //mtlo
                           
           ALUOp <= 5'b10011;
           Lo_write <= 1;
      end
      else if (OpCode == 6'b000000 && func == 6'b010000) begin //mfhi
                          
          ALUOp <= 5'b10100;
          RegWrite <= 1;
          MemtoReg <= 1;
          RegDst <= 1;
      end
      else if (OpCode == 6'b000000 && func == 6'b010010) begin //mflo
                          
          ALUOp <= 5'b10101;
          RegWrite <= 1;
          MemtoReg <= 1;
          RegDst <= 1;
     end
     else if (OpCode == 6'b100011) begin //lw
                               
           ALUOp <= 5'b00000;
           RegWrite <= 1;
           ALUSrc <= 1;
           MemRead <= 1;
           DM_Sel <= 0;
      end
      else if (OpCode == 6'b101011) begin //sw
                                         
             ALUOp <= 5'b00000;
             ALUSrc <= 1;
             MemWrite <= 1;
              DM_Sel <= 0;
        end
       else if (OpCode == 6'b101000) begin //sb might need new aluop
                                                
            ALUOp <= 5'b00000;
            ALUSrc <= 1;
            MemWrite <= 1;
            DM_Sel <= 2;
       end 
        else if (OpCode == 6'b100001) begin //lh might need new aluop
                                               
                              
            ALUOp <= 5'b00000;
            RegWrite <= 1;
            ALUSrc <= 1;
            MemRead <= 1;
             DM_Sel <= 1;
           
      end
      else if (OpCode == 6'b100000) begin //lb might need new aluop
                                                     
                                    
              ALUOp <= 5'b00000;
              RegWrite <= 1;
              ALUSrc <= 1;
              MemRead <= 1;
              DM_Sel <= 2;
        end
        else if (OpCode == 6'b101001) begin //sh might need new aluop
                                                        
            ALUOp <= 5'b00000;
            ALUSrc <= 1;
            MemWrite <= 1;
            DM_Sel <= 1;
       end 
       else if (OpCode == 6'b001111) begin //lui wont work
                                                               
               ALUOp <= 5'b11001; //new op
               ALUSrc <= 1;
               MemtoReg <=1;
               RegWrite <= 1;
               //MemRead <= 1;
               //DM_Sel <= 3;
                   
       end   //here
       else if (OpCode == 6'b000001 && branchRT == 5'b00001) begin //bgez 
                    
            branchRes <= 3'b000;
            Branch <= 1;
           
       end 
       else if (OpCode == 6'b000100) begin //beq 
                           
           branchRes <= 3'b001;
           Branch <= 1;
          
      end   
      else if (OpCode == 6'b000101) begin //bne //might need to have mux for inverse zeroflag
                                 
             branchRes <= 3'b010;
             Branch <= 1;
            
        end 
      else if (OpCode == 6'b000111) begin //bgtz //might need to have mux for inverse zeroflag
                                          
             branchRes <= 3'b011;
             Branch <= 1;
            
        end 
       else if (OpCode == 6'b000110) begin //blez //might need to have mux for inverse zeroflag
                                                 
             branchRes <= 3'b100;
             Branch <= 1;
            
        end 
        else if (OpCode == 6'b000001 && branchRT == 5'b00000) begin //bltz //might need to have mux for inverse zeroflag
                                                         
             branchRes <= 3'b101;
             Branch <= 1;
            
        end 
         else if (OpCode == 6'b000010) begin //J /
                                                                
            branchRes <= 3'b110;
            Branch <= 1;
           JSEl <= 1;
           
        end
        else if (OpCode == 6'b000011) begin //JAL /
                                                                        
            branchRes <= 3'b110;
            Branch <= 1;
            RegWrite <= 1;
            branchSel <= 1;
            JSEl <= 1;
            
            //need to write to register 31
        end  
         else if (OpCode == 6'b000000 && func == 6'b001000) begin //JR /
                                                                               
           branchRes <= 3'b110;
           Branch <= 1;
           JSEl <= 2;
 
           //branchSel <= 1;
          
       end  
        else begin //default 
             ALUSrc <= 0;
             RegDst <= 0;
             RegWrite <= 0;
             ALUOp <= 0;
             MemRead <= 0; 
             MemWrite <= 0;
             MemtoReg <= 0;
             Branch <= 0;
             ShiftOp <= 0; 
            
             end 
        end 
endmodule
