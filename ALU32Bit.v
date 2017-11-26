`timescale 1ns / 1ps
//Iain Donnelly , Josue Ortiz
// Effort 50-50
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero,shamt,Hi,Hi_in,Lo_in); //lo,offset

	input [4:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
    input [4:0] shamt;
    input [31:0] Hi_in;
    input [31:0] Lo_in;
	 output reg [31:0] ALUResult;// answer
	 output reg [31:0] Hi;
	
	
	output reg Zero;	 
	reg [63:0] C;
    initial begin
    
        ALUResult <= 0;
     
	end
    always @(*) begin //might need get rid hi lo in
        //Zero <= 0;
        ALUResult = 0;
        Hi = 0;
        C = 0;
        
        if(ALUControl == 5'b00000) begin 
            ALUResult = A + B;
          
        end
        else if(ALUControl == 5'b00001) begin 
            ALUResult = A - B;
            
        end
        else if(ALUControl == 5'b00010) begin 
              C = $signed(A)*$signed(B); //why does vivado hate this?????? //inferring latch
              Hi = C[63:32]; //inferring latch
              ALUResult = C[31:0]; 
              
        end
        else if(ALUControl == 5'b00011) begin 
              ALUResult = A&B; 
             
        end
        else if(ALUControl == 5'b00100) begin 
              ALUResult = A|B;
              
        end
        else if(ALUControl == 5'b00101) begin 
              ALUResult = A^B;
               
        end
        else if(ALUControl == 5'b00110) begin 
              ALUResult = ~(A | B);
              
        end
        else if(ALUControl == 5'b00111) begin 
              ALUResult = B >> shamt;
              
        end
        else if(ALUControl == 5'b01000) begin 
               ALUResult = B  << shamt;
               
        end
        else if(ALUControl == 5'b01001) begin //unsigned
               ALUResult = ($signed(A) < $signed(B));
               //Zero <= ALUResult;
        end
        else if(ALUControl == 5'b01010) begin 
              ALUResult =  $signed(B) >>> shamt;
              
        end
        else if(ALUControl == 5'b01011) begin 
               if(B!=0) begin ALUResult = A;  end//Zero = A >= B;
             
        end
        else if(ALUControl == 5'b01100) begin 
                ALUResult = ($signed(A) <= $signed(B));
              //  Zero <= ALUResult;;
        end
        else if(ALUControl == 5'b01101) begin //rotr need to look at instructions
                 ALUResult = ((B >> shamt) | (B << (32-shamt)));
              
        end
        else if(ALUControl == 5'b01110) begin 
               C = $signed(A)*$signed(B); 
               C = {Hi_in,Lo_in} - C ;
               Hi = C[63:32];
               ALUResult = C[31:0];
              
        end
        else if(ALUControl == 5'b01111) begin //maybe need division
               C = $signed(A)*$signed(B); 
               C = C + {Hi_in,Lo_in};
               Hi = C[63:32];
               ALUResult = C[31:0];
                   
        end //need two more operations movz and seb , seh
        else if(ALUControl == 5'b10000) begin //movz
               if(B==0) begin ALUResult = A;  end
               
                    
        end
        else if(ALUControl == 5'b10001) begin //se
           if(shamt == 5'b11000) begin //seh
                if(B[15] == 0) begin ALUResult = {16'b0000000000000000,B[15:0]}; end
                else begin ALUResult = {16'b1111111111111111,B[15:0]};  end
           end
           else if(shamt == 5'b10000) begin//seb
                if(B[7] == 0) begin ALUResult = {24'b000000000000000000000000,B[7:0]}; end//might need to add zero flag statemnet under these
                else begin ALUResult = {24'b111111111111111111111111,B[7:0]};  end
           end
        end
        else if(ALUControl == 5'b10010) begin //mthi
                Hi = A;
                     
        end
        else if(ALUControl == 5'b10011) begin //mtlo //could use addition
               ALUResult = A;
                   
        end
        else if(ALUControl == 5'b10100) begin //mfhi
               ALUResult = Hi_in; 
                  
        end
        else if(ALUControl == 5'b10101) begin //mflo
               ALUResult = Lo_in; 
                   
        end
        else if(ALUControl == 5'b10110) begin //ltu
                 ALUResult = (A < B);
                                   
        end
        else if(ALUControl == 5'b10111) begin //ltequ
                ALUResult = (A <= B);
                           
        end
         else if(ALUControl == 5'b11000) begin 
                     C = A*B; 
                     Hi = C[63:32]; 
                     ALUResult = C[31:0]; 
                     
         end
         else if(ALUControl == 5'b11001) begin //lui
                    ALUResult = (B << 16);           
                    //might need to use zeros
        end
    end
    always@(*) begin 
        if(ALUResult == 0) begin Zero = 1; end
        else begin Zero = 0; end
    end

endmodule

