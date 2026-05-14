//`include "Alu_adder32(CLA).v"
//`include "Alu_subtr(_cla).v"
//`include "adder.v"
//`include "sub32.v"
`include "Alu_multi32_withcla.v"
`include "Alu_divis32_withcla.v"
`include "Alu_and32.v"
`include "Alu_or32.v"
`include "Alu_xor32.v"
`include "Alu_barrel_shifter.v" 
 `include "adder32.v"   
 `include "sub32.v"  
/*module mux_9_to1(ad_s,sb_s,mul_s,div_s,and_s,or_s,xr_s,rgt_s,lft_s,sel,outp) ;
input [63:0] ad_s,sb_s,mul_s,div_s,and_s,or_s,xr_s,rgt_s,lft_s ;
input [3:0] sel ;
output [63:0] outp ;

endmodule */
module mux_2to_1(in0,in1,sel,out);
input[63:0] in0,in1;
input sel;
output[63:0] out;
assign out=(sel==1'b1) ?in1 :in0;
endmodule

module mux_16to_1_64 (in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,sel,y);
input [63:0]in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15;
input [3:0] sel ;
output [63:0] y ;
wire [63:0] w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7;
wire [63:0] w2_0,w2_1,w2_2,w2_3;
wire [63:0]w3_0 ,w3_1 ;
mux_2to_1 l1 (.in0(in0),.in1(in1),.sel(sel[0]),.out(w1_0));   mux_2to_1    l2(.in0(in2),.in1(in3),.sel(sel[0]),.out(w1_1));
mux_2to_1 l3(.in0(in4),.in1(in5),.sel(sel[0]),.out(w1_2));  
mux_2to_1 l4(.in0(in6),.in1(in7),.sel(sel[0]),.out(w1_3)); 
mux_2to_1 r1(.in0(in8),.in1(in9),.sel(sel[0]),.out(w1_4)); 
mux_2to_1 r2(.in0(in10),.in1(in11),.sel(sel[0]),.out(w1_5)); 
mux_2to_1 r3(.in0(in12),.in1(in13),.sel(sel[0]),.out(w1_6)); 
mux_2to_1 r4(.in0(in14),.in1(in7),.sel(sel[0]),.out(w1_7)); 

 mux_2to_1 l5(.in0(w1_0),.in1(w1_1),.sel(sel[1]),.out(w2_0)); 
 mux_2to_1 l6(.in0(w1_2),.in1(w1_3),.sel(sel[1]),.out(w2_1));
 mux_2to_1 r5(.in0(w1_4),.in1(w1_5),.sel(sel[1]),.out(w2_2));  
 mux_2to_1 r6(.in0(w1_6),.in1(w1_7),.sel(sel[1]),.out(w2_3)); 
 
  mux_2to_1 l7(.in0(w2_0),.in1(w2_1),.sel(sel[2]),.out(w3_0));
  mux_2to_1 r7(.in0(w2_2),.in1(w2_3),.sel(sel[2]),.out(w3_1)); 

  mux_2to_1 l(.in0(w3_0),.in1(w3_1),.sel(sel[3]),.out(y)); 
endmodule

module alu_data(value1,value2,result,oper_sel,w_long,start,done,clk);
input [31:0] value1 ,value2 ;
input[3:0] oper_sel ; 
input start,clk;
 output wire done ;
 
output wire [63:0]result ;
wire carr_i ,gnd;
assign carr_i = 1'b0 ;
assign gnd = 1'b0 ;
wire clk2 ;
assign clk2=  ~clk ;
output wire w_long ;
wire [63:0] w_ad,w_su,w_mul,w_div,w_an,w_or,w_xo,w_s;
assign w_ad[63:33] = {31{gnd} };
assign w_su [63:33] = {31{gnd}} ;
assign w_an [63:32] ={32{gnd} };
assign w_or [63:32] = {32{gnd}} ;
assign w_xo[63:32] = {32{gnd}};
assign w_s[63:32]  ={32{gnd} } ;

wire w_f;
assign w_f= (~(oper_sel[3]) & ~(oper_sel[2]));
assign w_long = (w_f & oper_sel[1]);
CarryLookAhead_adder Addr (.A(value1),.B(value2),.sum(w_ad[31:0]),.carry_out(w_ad[32]),.carry_in(carr_i));
subtractor subb (.val1(value1),.val2(value2),.result(w_su[32:0]));

multipler multi (.clk(clk),.clk2(clk2),.start(start),.done(done),.by_mul(value2),.mul_to(value1),.resul(w_mul));
divider div (.clk(clk),.clk2(clk2),.start(start),.done(done),.div_to(value1),.div_by(value2),.dv_r(w_div));
And32 and3 (.a(value1),.b(value2),.c(w_an[31:0]));
or32 orr (.a(value1),.b(value2),.c(w_or[31:0]));
xor32 xr (.a(value1),.b(value2),.c(w_xo[31:0]));
barrel_shifter Bshift (.data_in(value1),.shift(value2[4:0]),.dir(oper_sel[0]),.data_out(w_s[31:0]));//
mux_16to_1_64 mux9_1 (.in0(w_ad),.in1(w_su),.in2(w_mul),.in3(w_div),.in4(w_an),.in5(w_or),.in6(w_xo),.in7(w_s),.in8(w_s),.in9({{32{gnd}},value1}),.in10({{32{gnd}},value2}),.in11({64{gnd}}),.in12({64{gnd}}),.in13({64{gnd}}),.in14({64{gnd}}),.in15({64{gnd}}),.sel(oper_sel),.y(result));

endmodule
module alu_con(start,done,w_long,done_by_dt,clk);
input start ,clk ,w_long,done_by_dt;
output reg done ;
reg [1:0] state;
parameter s0 =2'b00 ,s1=2'b01,s2=2'b10 ;
always @(posedge clk)
begin
  case(state)//no need can be give to dat 
  s0: begin 
    if(start)
  begin
  
  if(w_long) begin 
   state<=s1 ;
     done<=1'b0;/*else begin state<=s0; end*/
    end
  
  else begin
   state<=s1;
  done<= 1 ;
  end
  end
  
  else begin
  state<=s0;
  end
  end
  s1: begin
    if(w_long) begin 
   state<=s1 ;
     if(done_by_dt) begin
      state<=s2;
  done<=1'b1;
    end
    end
  if(done) 
  state<=s2;
  else
  state<=s1;
  end
s2:
if(start)
state<= s0;
else
state<=s2;

default:
state<=s0;
  endcase
end
endmodule

module alu_unit (val1,val2,oper_sel,result,start,clk,done);
input [31:0] val1 ,val2 ;
input [3:0]oper_sel ;
input start ,clk ;
output done ;
output [63:0] result ;
wire gnd ;
wire dd;
wire w_l;
alu_data Ad(.value1(val1),.value2(val2),.result(result),.oper_sel(oper_sel),.w_long(w_l),.start(start),.clk(clk),.done(dd));
alu_con Ac (.start(start),.done(done),.w_long(w_l),.done_by_dt(dd),.clk(clk));
    endmodule