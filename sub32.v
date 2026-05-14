//`include "Alu_adder32(CLA).v"
`ifndef sub32_V
`define sub32_V
`include "adder32.v"
module inverter_s (a,y);
  input a;
  output wire y ;
  assign y = ~a ;
endmodule 
module twOs_compleme (a,c);
  input [31:0]a ;
  output wire [32:0] c;
  wire [32:0] inv;
  wire [32:0] flow ;
  assign flow[0] =1'b1;
  wire extra_bit;
 assign  extra_bit =1'b0 ;
  genvar i;
  generate for(i=0;i<32;i=i+1)
    begin
      inverter_s inver  (.a(a[i]),.y(inv[i])) ;
    end 
  endgenerate
  genvar n;
  generate for(n=0;n<32;n=n+1)
    begin 
      And_Or_stage1 ad (.a(inv[n]),.b(flow[n]),.c(flow[n+1]),.d(c[n]));
    end
  endgenerate
  And_Or_stage1 adddeee (.a(inv[32]),.b(flow[32]),.d(c[32]),.c());
  inverter_s invert  (.a(extra_bit),.y(inv[32])) ;
endmodule 

module sum(a,b,C_in,sum) ;
  input a, b ,C_in ;
  output wire sum ;
  wire x ;
  xor x1(x,a,b);
  xor x2(sum , x,C_in);
 endmodule

module subtractor(val1,val2,result);
  input [31:0] val1,val2 ;
  output [32:0] result ;
  wire [32:0] twoco ;
 wire internal_carry ;
  wire carryin ;
  assign carryin = 1'b0 ;// can be explicitly given from exxternallty 
  wire val1_msb;
  assign val1_msb =1'b0;
  CarryLookAhead_adder AA (.A(val1),.B(twoco[31:0]),.sum(result[31:0]),.carry_out(internal_carry),.carry_in(carryin));
  twOs_compleme twCOM (.a(val2),.c(twoco));
  sum S(.a(val1_msb),.b(twoco[32]),.C_in(internal_carry),.sum(result[32]));
endmodule
   `endif