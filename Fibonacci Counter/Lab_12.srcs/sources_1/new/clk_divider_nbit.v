`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ratner Surf Designs
// Engineer: James Ratner
// 
// Create Date: 10/09/2018 07:53:15 PM
// Design Name: 
// Module Name: clk_divider_nbit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Parameterized 2^n clock divider
//
// Usage: 
//
//      clk_divider_nbit #(.n(16)) MY_DIV (
//          .clockin (my_clk_in), 
//          .clockout (my_clk_out) 
//          );  
// 
// Dependencies: 
// 
// Created: 10-09-2018
//
// Revision (11-02-2019) 1.01 - removed typos in module name
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module clk_divider_nbit(clockin, clockout); 
    input clockin; 
    output wire clockout; 

    parameter n = 13; 
    reg [n:0] count; 

    always@(posedge clockin) 
    begin 
        count <= count + 1; 
    end 

    assign clockout = count[n];
	
endmodule 