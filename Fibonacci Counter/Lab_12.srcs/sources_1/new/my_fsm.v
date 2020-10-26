`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 12:24:34 PM
// Design Name: 
// Module Name: my_fsm
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


module my_fsm(
        input clk,
        input x,
        input btn,
        output reg z
    );
    
    reg PS,NS;
    
    parameter st_A = 0, st_B = 1;
    
    always @ (posedge clk)
    begin
        PS<= NS;
    end
        
    always @ (x, PS)
    begin
        z = 0;
        case (PS)
            st_A:
            begin
                if(x == 0)
                begin
                    NS = st_A;
                end
                else
                begin
                    NS = st_B;
                end     
            end
            
            st_B:
            begin
                z = 1;
                if (btn == 0)
                begin
                    NS = st_B;
                end
                else
                begin
                    NS = st_A;
                end
            
            end
       endcase
    end
    
    
    
endmodule
