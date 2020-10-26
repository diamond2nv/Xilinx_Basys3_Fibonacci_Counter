`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ratner Engineering
// Engineer: James Ratner
// 
// Create Date: 10/17/2019 02:13:56 PM
// Design Name: 
// Module Name: nb_twos_comp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//
//   Usage (instantiation) example for 16-bit 2's comp module  
//          (model defaults to 8-bit)
//
//  nb_twos_comp #(.n(16)) my_sign_changer (
//      .a (my_a), 
//      .a_min (my_a_min)  
//      );  
// 
// Dependencies: 
// 
// Revision:
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module nb_twos_comp(
    input [n-1:0] a,
    output reg [n-1:0] a_min
    );
	
    parameter n = 8;
    
    always @(a)
    begin
       a_min = ~a + 1;    
    end
    
endmodule