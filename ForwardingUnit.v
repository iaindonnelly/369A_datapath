`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2017 01:39:39 PM
// Design Name: 
// Module Name: ForwardingUnit
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
// 
//////////////////////////////////////////////////////////////////////////////////

/*
    1a. EX/MEM.RegisterRd = ID/EX.RegisterRs
    1b. EX/MEM.RegisterRd = ID/EX.RegisterRt
    2a. MEM/WB.RegisterRd = ID/EX.RegisterRs
    2b. MEM/WB.RegisterRd = ID/EX.RegisterRt
    
    //EX
    
    if (EX/MEM.RegWrite
    and (EX/MEM.RegisterRd ? 0)
    and (EX/MEM.RegisterRd = ID/EX.RegisterRs)) ForwardA = 10
     
    if (EX/MEM.RegWrite
    and (EX/MEM.RegisterRd ? 0)
    and (EX/MEM.RegisterRd = ID/EX.RegisterRt)) ForwardB = 10

    //MEM
    
    if (MEM/WB.RegWrite
    and (MEM/WB.RegisterRd =?  0)
    and (MEM/WB.RegisterRd = ID/EX.RegisterRs)) ForwardA = 01
     
    if (MEM/WB.RegWrite
    and (MEM/WB.RegisterRd =?  0)
    and (MEM/WB.RegisterRd = ID/EX.RegisterRt)) ForwardB = 01


*/
module ForwardingUnitEX(RD_MEM,RS_EX,RD_WB,RT_EX,RegWrite_EX,RegWrite_WB,ForwardA,ForwardB,RegWrite_MEM,ForwardA_ID,ForwardB_ID,RT_ID,RS_ID,MemWrite_MEM,Forward_MEM,branch,ALUSrc,MemWrite_EX);//,Clk);

        input [4:0] RD_MEM;
        input [4:0] RS_EX;
        input [4:0] RD_WB;
        input [4:0] RT_EX;
        input RegWrite_EX;
        input RegWrite_WB;
        input RegWrite_MEM;
        input [4:0] RT_ID;
        input [4:0] RS_ID;
        input MemWrite_MEM;
        input branch;
        input ALUSrc;
        input MemWrite_EX;
       // input Clk;
        output reg [1:0] ForwardA;
        output reg [1:0] ForwardB;
        output reg ForwardA_ID;
        output reg ForwardB_ID;
        output reg Forward_MEM;
        
        initial begin
                    ForwardA <= 2'b00;
                    ForwardB <= 2'b00;
                    ForwardA_ID <= 0;
                    ForwardB_ID <= 0;
                    Forward_MEM <= 0;
        end
        
        
  
     
        
    always @(*) begin 
                         ForwardA <= 2'b00; //if rd_mem == rt_ex
                        ForwardB <= 2'b00;
                        ForwardA_ID <= 0;
                        ForwardB_ID <= 0;
                        Forward_MEM <= 0;
                        
          if (RegWrite_MEM
          && (RD_MEM != 0)
          && (RD_MEM == RS_EX)) begin 
            ForwardA <= 2'b10;
          end
          
          else if (RegWrite_WB //wb -> ex
                   && (RD_WB !=  0)
                   && (RD_WB == RS_EX))begin //&& ~(RegWrite_MEM || (RD_MEM != 0) || (RD_MEM != RS_EX))) begin 
                     ForwardA <= 2'b01;
           end
           
           
          if ((RegWrite_MEM == 1) && (RD_MEM != 0) && (RD_MEM == RT_EX) && ~ALUSrc) begin
            ForwardB <= 2'b10;
          end
           
          else if (RegWrite_WB
          && (RD_WB !=  0) && ~ALUSrc
          && (RD_WB == RT_EX)) begin//&& (~(RegWrite_MEM && (RD_MEM != 0) && (RD_MEM != RT_EX)))) begin 
            ForwardB <= 2'b01;
          end
          
          else if (RegWrite_WB
            && (RD_WB !=  0) && ALUSrc && MemWrite_EX 
            && (RD_WB == RT_EX)) begin//&& (~(RegWrite_MEM && (RD_MEM != 0) && (RD_MEM != RT_EX)))) begin 
              ForwardB <= 2'b01;
            end
            
          if ((RD_MEM == RS_ID) && (RegWrite_MEM)//might need additional logic
          && (RD_MEM != 0) && branch ) begin
          ForwardA_ID <= 1;
          end
          
          else if ((RD_MEM == RT_ID) && (RegWrite_MEM)
           && (RD_MEM != 0) && branch ) begin
           ForwardB_ID <= 1;
           end
           
           if ((RD_WB == RD_MEM) && (MemWrite_MEM == 1)
           && (RD_WB != 0) && RegWrite_WB ) begin
           Forward_MEM <= 1;
           end
          
          end

endmodule
