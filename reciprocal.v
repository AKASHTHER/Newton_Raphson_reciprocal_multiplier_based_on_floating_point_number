`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2022 03:20:55 PM
// Design Name: 
// Module Name: reciprocal
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
module reciprocal(numerator,divisor,reciprocal1);
localparam size = 32;
localparam constant1 = 32'b01000000001101001011010010011010;//48/17;
localparam constant2 = 32'b10111111111100001111000011110001;//-32/17;
input [31:0] numerator;
input [31:0] divisor;
output [31:0] reciprocal1;
wire [31:0] D;
wire [31:0] numerator1;
wire [31:0] divisor1;
wire sign;
wire [31:0] x0;
wire [31:0] xi1;
wire [31:0] xi2;
wire [31:0] xi3;
wire [31:0] xi4;
wire [31:0] xi5;
wire [31:0] xi6;
wire [31:0] x0add;

assign sign = numerator[31] ^ divisor[31];
assign numerator[31] = 1'b0;
assign divisor[31] = 1'b0;
assign numerator1 [30:23]= numerator[30:23]-1-divisor[30:23]+127;
assign divisor1[30:23]=8'b1111110;//126 biased
assign numerator1[22:0]=numerator[22:0];
assign divisor1[22:0]=divisor[22:0];
assign D=divisor1; 

// calculate Xo through 48/17-32/17 *divisor1              
mul mulD(.flp_a(divisor1),.flp_b(constant2),.sign(x0[31]),.exponent(x0[30:23]),.prod(x0[22:0]));
     
add additionX0(.A_FP(constant1),.B_FP(x0),.out(x0add)); 

// calculate Xn from first 4 terms of  X = X * (2-D*X)              
XnCalculation firstterm(.D(D),.X(x0add),.Xn(xi1));

XnCalculation secondterm(.D(D),.X(xi1),.Xn(xi2));

XnCalculation thirdterm(.D(D),.X(xi2),.Xn(xi3)); 
  
XnCalculation forthterm(.D(D),.X(xi3),.Xn(xi4));  

//  calculate multiply of Numerator with Xn value                                                        
mul mulNumeratorDivisor(.flp_a(xi4),.flp_b(numerator1),.sign(reciprocal1[31]),.exponent(reciprocal1[30:23]),.prod(reciprocal1[22:0])); 
 
endmodule
