`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2017 05:25:37 PM
// Design Name: 
// Module Name: BranchComp
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


module BranchComp(
   CompCont,
   RS,
   RT,
   ZeroFlag 
    
    );
    
    input [2:0] CompCont;
    input [31:0] RS;
    input [31:0] RT;
    output reg ZeroFlag;
    
    initial begin
    
    ZeroFlag <=0 ;
    
    end
    
    always @(*)begin
        
        ZeroFlag <=0;
        
        if(CompCont == 3'b000)begin //BGEZ
            ZeroFlag <= ($signed(RS)>=0);
        end
        else if(CompCont == 3'b001) begin //BEQ
            ZeroFlag <= ($signed(RS)==$signed(RT));
        end
        else if(CompCont == 3'b010) begin // BNE
            ZeroFlag <= ($signed(RS)!=$signed(RT));
        end
        else if(CompCont == 3'b011) begin // BGTZ
            ZeroFlag <= ($signed(RS) > 0);
        end
        else if(CompCont == 3'b100) begin // BLEZ
            ZeroFlag <= (0>=$signed(RS));
        end
        else if(CompCont == 3'b101) begin // BLTZ
            ZeroFlag <= ($signed(RS)<0);
        end
        else if(CompCont == 3'b110) begin // J, JR, JAL
            ZeroFlag <= 1;
        end
    end
    
    
endmodule
