`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//By: Basant Loay Abdalla
//////////////////////////////////////////////////////////////////////////////////
module reciprocal_tb();
wire [31:0] out2; 
reg clk;
reg[31:0] data1;
reg [31:0] one;
initial
    begin 
        $monitor ("outputReciporical = %b ",out2);
    end    
always#5 one=32'b00111111100000000000000000000000; // numerator is 1
always#5
  //data1=32'b01000000000000000000000000000000;
    data1=32'b01000001000000000000000000000000;
always#5 clk = ~clk;

initial 
   begin   
        clk=0;
        #200 $finish;     
   end
    
reciprocal r1(.numerator(one),.divisor(data1),.reciprocal1(out2));                                    
 
endmodule
