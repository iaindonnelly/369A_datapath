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

module IF_ID_Register(Instr_In, PC_In, Clk, PC_Out, Instr_Out,Flush,stall,Rst);//need control signal for hazard
       input [31:0]Instr_In;
       input [31:0]PC_In;
       input Flush,stall;
       input Clk,Rst;
       reg [31:0] Instr; 
       reg [31:0] Pc;
       output reg [31:0]Instr_Out;
       output reg [31:0]PC_Out;
      
   initial begin         
       Instr_Out <= 0;
        PC_Out <= 0;
        Instr <= 0;
        Pc <= 0;
      end
  
       always@(posedge Clk)begin 
              if(Flush == 1 || Rst == 1) begin
                  PC_Out <= 0;
                  Instr_Out <= 0;
                  Instr <= 0;
                  Pc <= 0;
              end
              else begin
                  if (stall == 1) begin
                   Instr_Out <= Instr;
                    PC_Out <= Pc;
                  
                  end
                  else begin
                  
                  Instr_Out <= Instr_In;
                  PC_Out <= PC_In;
                  Instr <= Instr_In;
                  Pc <= PC_In;
                  
                  end
               
                  
              end
            
       end
   
endmodule
