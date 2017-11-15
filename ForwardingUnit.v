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
module ForwardingUnit(RD_MEM,RS_EX,RD_WB,RT_EX,RegWrite_EX,RegWrite_WB,ForwardA,ForwardB);

        input [4:0] RD_MEM;
        input [4:0] RS_EX;
        input [4:0] RD_WB;
        input [4:0] RT_EX;
        input RegWrite_EX;
        input RegWrite_WB;
        output reg [1:0] ForwardA;
        output reg [1:0] ForwardB;
        
    always @(*) begin 
            ForwardA <= 2'b00;
            ForwardB <= 2'b00;
          if (RegWrite_EX && (RD_MEM != 0)
          && (RD_MEM == RS_EX)) begin 
            ForwardA = 2'b10;
          end
       
          if (RegWrite_EX
          && (RD_MEM != 0)
          && (RD_MEM == RT_EX)) begin
            ForwardB = 2'b10;
          
          if (RegWrite_WB
          && (RD_WB !=  0)
          && (RD_WB == RS_EX)) begin 
            ForwardA = 2'b01;
          end
           
          if (RegWrite_WB
          && (RD_WB !=  0)
          && (RD_WB == RT_EX)) begin 
            ForwardB = 2'b01;
          end
          
          
          end
    end

endmodule
