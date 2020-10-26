`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 12:37:04 PM
// Design Name: 
// Module Name: FibonacciCounter
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


module FibonacciCounter(
        input BTN,
        input clk,
        output led,
        output [7:0] segs,
        output [3:0] an
    );
    
    wire [9:0] fib_up, res, reg2_wire, reg1_wire, fib_down, reg2_in, trans2, comp_in, trans1, reg1_in, down_wire, down_res;
    wire [5:0] cnt_wire;
    wire control, End, GT_in;
    
    wire clk_regs;
    wire clk_fsm;
    wire clk_cntr;
    wire clk_seg;
    
    wire [9:0] out;
    
    assign led = clk_regs;
    
/////////////////////////////////////////////////////////////REGISTERS//////////////////////////////////
    
          reg_nb #(10) MY_REG1 (
              .data_in  (reg1_in), 
              .ld       (1), 
              .clk      (clk_regs), 
              .clr      (0), 
              .data_out (reg1_wire)
              ); 
    
          reg_nb #(10) MY_REG2 (
              .data_in  (reg2_in), 
              .ld       (1), 
              .clk      (clk_regs), 
              .clr      (0), 
              .data_out (reg2_wire)
              ); 
 
 
 ///////////////////////////////////////////////////////////MUX/////////////////////////////////////////
    

    
      mux_2t1_nb  #(.n(10)) my_2t1_mux2  (
           .SEL   (BTN), 
           .D0    (res), 
           .D1    (10'b0000000001), 
           .D_OUT (reg1_in) ); 
    
      mux_2t1_nb  #(.n(10)) my_2t1_mux3  (
           .SEL   (control), 
           .D0    (reg1_wire), 
           .D1    (fib_down), 
           .D_OUT (trans2) ); 
    
      mux_2t1_nb  #(.n(10)) my_2t1_mux4  (
           .SEL   (BTN), 
           .D0    (trans2), 
           .D1    (10'b0000000000), 
           .D_OUT (reg2_in) ); 
    
      mux_2t1_nb  #(.n(10)) my_2t1_mux5  (
           .SEL   (control), 
           .D0    (fib_up), 
           .D1    (down_res), 
           .D_OUT (res) ); 
    
      mux_2t1_nb  #(.n(10)) my_2t1_mux6  (
           .SEL   (End), 
           .D0    (reg1_wire), 
           .D1    (10'b0000000000), 
           .D_OUT (out) ); 
  
  
  ///////////////////////////////////////////////////RCA///////////////////////////////////////////////
    
          rca_nb #(.n(10)) MY_RCA1 (
              .a (reg1_wire), 
              .b (reg2_wire), 
              .cin (0), 
              .sum (fib_up), 
              .co (0)
              );  
    
          rca_nb #(.n(10)) MY_RCA2 (
              .a (reg1_wire), 
              .b (comp_in), 
              .cin (0), 
              .sum (fib_down), 
              .co (0)
              );  
  
          rca_nb #(.n(10)) MY_RCA3 (
                  .a (reg1_wire), 
                  .b (down_wire), 
                  .cin (0), 
                  .sum (down_res), 
                  .co (0)
                  );   
  
  //////////////////////////////////////////////////COMPARATORS////////////////////////////////
    
          comp_nb #(.n(16)) MY_COMP1 (
              .a (cnt_wire), 
              .b (6'b001101), 
              .eq (0), 
              .gt (GT_in), 
              .lt (0)
              ); 
    
          comp_nb #(.n(16)) MY_COMP2 (
              .a (cnt_wire), 
              .b (6'b011111), 
              .eq (0), 
              .gt (End), 
              .lt (0)
              ); 
    
 ////////////////////////////////////////////////////////////////////MISC///////////////////////////////////////   
    
      nb_twos_comp #(.n(10)) my_sign_changer1 (
          .a (reg2_wire), 
          .a_min (comp_in)  
          ); 
     
           nb_twos_comp #(.n(10)) my_sign_changer2 (
              .a (fib_down), 
              .a_min (down_wire)  
              );
    
          cntr_up_clr_nb #(.n(6)) MY_CNTR (
              .clk   (clk_regs), 
              .clr   (BTN), 
              .up    (~End), 
              .ld    (0), 
              .D     (0), 
              .count (cnt_wire), 
              .rco   (0)   ); 
    
          my_fsm my_FSM(
               .clk (clk_regs),
               .x   (GT_in),
               .btn (BTN),
               .z   (control)    );
   
      univ_sseg my_univ_sseg (
                     .cnt1 (out), 
                     .cnt2 (0), 
                     .valid (1), 
                     .dp_en (0), 
                     .dp_sel (0), 
                     .mod_sel (10), 
                     .sign (0), 
                     .clk (clk), 
                     .ssegs (segs), 
                     .disp_en (an)    ); 
      
      
  ///////////////////////////////////////////////////CLOCK DIVIDERS/////////////////////////////////    
               
         clk_divider_nbit #(.n(25)) MY_DIV1 (
                         .clockin (clk), 
                         .clockout (clk_regs) 
                         ); 
               
         clk_divider_nbit #(.n(13)) MY_DIV2 (
                         .clockin (clk), 
                         .clockout (clk_fsm) 
                         ); 
               
        clk_divider_nbit #(.n(13)) MY_DIV3 (
                         .clockin (clk), 
                         .clockout (clk_seg) 
                         ); 
               
        clk_divider_nbit #(.n(13)) MY_DIV4 (
                         .clockin (clk), 
                         .clockout (clk_cntr) 
                         ); 
               
        
    
    
    
endmodule








