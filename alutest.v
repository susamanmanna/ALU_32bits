
`timescale 1ns/1ns
`include "ALU32___bits.v"
module alutest ;

  reg [31:0] val1,vaal2;//testbench dont have port
  reg [3:0] op_s ;
   reg clk ;
   reg start ;
  wire done;
  wire [63:0] re ;
 // reg [3:0] A,B;
 alu_unit Al (.val1(val1),.val2(vaal2),.oper_sel(op_s),.result(re),.start(start),.clk(clk),.done(done));
  //gcd G(.clk(clk),.clk2(clk2),.start(start),.done(done),.datapath_in(datapath_in),.clr(clr));
  initial 
  begin
    #1 clk =0;
    
    #1 start <=1;
#18 start <=0;
    //#1 clr=1;
   // #25 clr=0;
 #1300 $finish;
  end
  
  always #5 clk = ~clk;
  
  //always #5 clk2 = ~clk2;
  
  
  initial
    begin
      #1 val1 <= 32'd1119; #1 vaal2<= 32'd107 ; #1 op_s<= 4'b1000;
     
     //(default - :5 s0 )s1:20,s2:30 b take  value s7:40 c will be taken
      
    end
  
initial
    begin
      $dumpfile ("ALU32___bits.vcd");//file name to be storejavascript:void(0)
      $dumpvars(0,alutest);
    end
 always @(posedge clk) begin
  $display("Time=%0t : val1=%b,vaal2=%b, oper_s=%d,,done=%b, result=%b,s=%d,del=%d,start=%d,dd=%b", 
           $time,val1, vaal2,op_s,done, re,Al.Ac.state,Al.Ac.w_long,start,Al.Ad.done);
end

endmodule
