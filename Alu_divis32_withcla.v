 //`include "Alu_adder32(CLA).v"
 //`include "Alu_subtr(_cla).v"
`include "adder32.v"
`include "sub32.v"

/*module adder_div(a,b,Carry_in,Carry_out,sum1);
  input a,b,Carry_in;
  output wire Carry_out,sum1;
  wire ci_abi,ci_bci,ci_aci,ci_o;
  wire ab_x;
  and a1(ci_abi,a,b);
  and a2(ci_bci,b,Carry_in);
  and a3(ci_aci,a,Carry_in);
  or o1(ci_o,ci_abi,ci_bci);
  or o2(Carry_out,ci_o,ci_aci);
  xor x1(ab_x,a,b);
  xor x2(sum1,ab_x,Carry_in);
endmodule

module And_Or_stage1_div(a,b,c,d);
input a,b;
  output c,d;
  assign c=a & b;
  assign d =a^b;
endmodule

module and_ooo(d,c,b,a);//2nd stage operator
  input a,b,c;
  output wire d;
  wire t1;
  and A1(t1,a,b);
  or O1(d,t1,c);
endmodule

module generate_propagate_div (g_in_upper,g_in_lower,p_in_upper,p_in_lower,G_out,P_out) ;
  input p_in_lower,g_in_upper,g_in_lower,p_in_upper;
  output wire G_out,P_out;
  wire t1;
  and A1 (t1,p_in_upper,g_in_lower);
  or O1(G_out,g_in_upper,t1);
  and A2(P_out,p_in_lower,p_in_upper);
endmodule
module CarryLookAhead_adder_div(A,B,sum,carry_out,carry_in);
  input [31:0] A,B;
  input carry_in;
  output wire [31:0] sum;
  output wire carry_out;
  wire [62:0]Gi ,Pi;//Gi_u,Gi_l,Pi_u,Pi_l;__ wire [2*31:0]Gi ,Pi;
  wire[15:0] agn;
  wire [15:0] carry_flow;
  wire t2,t4,t6,t9,t11,t13,t15,t18,t20,t22,t24;//many exta wires are taken that will be deleted later
  genvar n,a;
  generate for(n=0;n<31;n=n+1)
    begin 
      generate_propagate_div  gp (.G_out(Gi[n+32]),.P_out(Pi[n+32]),.g_in_lower(Gi[2*n]),.p_in_upper(Pi[2*n+1]),.p_in_lower(Pi[2*n]),.g_in_upper(Gi[2*n+1]));// gp not advised to give 
   //.G_out(Gi[n+32]),.P_out(Pi[n+32]),
    end
  endgenerate
  
  generate for(a=0;a<32;a=a+1)//2nd stage adder
    begin : gens_adder
      
        
      if(a%2==0)
      adder_div adding (.a(A[a]),.b(B[a]),.Carry_in(agn[a/2]),.sum1(sum[a]),.Carry_out(carry_flow[a/2]));
   else
     
     adder_div adding (.a(A[a]),.b(B[a]),.Carry_in(carry_flow[(a-1)/2]),.sum1(sum[a]),.Carry_out());
    end
  endgenerate
  //2nd stage cal
  and_ooo AO1(t2,Gi[58],Gi[60],Pi[58]);
  and_ooo AO2(t4,Gi[52],Gi[60],Pi[52]);
  and_ooo AO3(t6,Gi[40],Gi[60],Pi[40]);//after reading notes i analysis then move from again stage 1 adder to here to fix this
  and_ooo AO4(t9,Gi[50],Gi[56],Pi[50]);
  and_ooo AO5(t11,Gi[36],Gi[56],Pi[36]);
  and_ooo AO6(t13,Gi[54],t2,Pi[54]);
  and_ooo AO7(t15,Gi[44],t2,Pi[44]);
  and_ooo AO8(t18,Gi[34],Gi[48],Pi[34]);
  and_ooo AO9(t20,Gi[38],t9,Pi[38]);
  and_ooo A10(t22,Gi[42],t4,Pi[42]);
  and_ooo A11(t24,Gi[46],t13,Pi[46]);
  
 
  adder_div A0 (A[0],B[0],carry_in,Gi[0],Pi[0]); // 1st adder
  genvar i;
  generate//remaing 1st stage adder 2input
    for( i=1;i<32;i=i+1)
    begin
      
        
      And_Or_stage1_div ao(A[i],B[i],Gi[i],Pi[i]);// t help ordering which by mistake not 
    end
  endgenerate
  
  assign agn[0]= carry_in;
  assign agn[1]= Gi[32];
  assign agn[2]= Gi[48];
  assign agn[3]=  t18;
  assign agn[4]= Gi[56];
  assign agn[5]=  t11;
  assign agn[6]= t9 ;
  assign agn[7]= t20 ;
  assign agn[8]= Gi[60] ;
  assign agn[9]= t6 ;
  assign agn[10]= t4;
  assign agn[11]= t22;
  assign agn[12]=t2 ;
  assign agn[13]=t15 ;
  assign agn[14]=t13 ;
  assign agn[15]=t24 ;
 assign  carry_out =Gi[62];
  
  endmodule 
  // LINE 74
// CODE END
module inverter_div (a,y);
  input a;
  output wire y ;
  assign y = ~a ;
endmodule 
module twOs_compleme_div (a,c);
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
      inverter_div inver  (.a(a[i]),.y(inv[i])) ;
    end 
  endgenerate
  genvar n;
  generate for(n=0;n<32;n=n+1)
    begin 
      And_Or_stage1_div ad (.a(inv[n]),.b(flow[n]),.c(flow[n+1]),.d(c[n]));
    end
  endgenerate
  And_Or_stage1_div adddeee (.a(inv[32]),.b(flow[32]),.d(c[32]),.c());
  inverter_div invert  (.a(extra_bit),.y(inv[32])) ;
endmodule 

module sub(A,B,C) ;
  input [31:0] A;
  input [32:0]B;
  output [32:0] C;
  assign C=B-A;
endmodule */

      
  module mux(in1,in2,out,sel);
    input [31:0] in1,in2;
  input sel;
    output [31:0] out;
  assign out=sel ? in2 :in1;
endmodule
 
module mux1(in1,in2,out,sel);
    input in1,in2;
  input sel;
    output  out;
  assign out=sel ? in2 :in1;
endmodule

module register_op (clr,clk,ld,shft,div_to,v1,N0,enter,A);
   parameter N=4;
 
  input clk,clr,ld,shft,enter;
  input[N-1:0] div_to;
  output reg[N-1:0] A;
  output wire v1;//output reg v1 ;
 input N0; // quosent entry value
 
 assign v1 = A[N-1];  // 
  //v1<=A[N-1];//[  ]</--\[]
  always @(posedge clk)
    begin
      if(clr)
        A<= 0;
      else if(ld)
        A<=div_to;
      else if(shft)
        begin
          // A<={A[N-2:0],}; //  A <= {A[N-1], A[N-1:1]};
          A<=A<<1;
        end
      else if(enter) 
        begin
          A[0]<=N0;// shifting 
        //end
      //else if(enter) A[0] <= N0 ;// entering QUOSIENT 
        end
    end
endmodule
module register_op_MSB (clr,clk,ld,shft,data_in,A,Div_shft,sign);
   parameter N=5;
 
  input clk,clr,ld,shft;
  input[N-1:0] data_in;
  output reg[N-1:0] A;
 input wire Div_shft;
 output wire sign ;
  
  assign sign = A[N-1];
  
  always @(posedge clk)
    begin
      if(clr)
        A<=0;
      else if(ld)
        
        A<=data_in;
      else if(shft)
        begin
          A <= A<<1;
        end
      if (shft)
        A[0]<=Div_shft;
    end
  
endmodule
      
module register (clr,clk,ld,div_by,A);
  parameter N=4;
  input clk,clr,ld;
  input[N-1:0] div_by;
  output reg[N-1:0] A;
 
 
  always @(posedge clk)
    begin
      if(clr)
        A<=0;
      else if(ld)
        A<=div_by;
    end
endmodule

module  divider_dat(clk,clr,div_to,div_by,ld_M,ld_N,ld_MSB,shft_MSB,shft_N,curr_bit,A_vs_S,enter,sign,div_res);//half data path
  input clk,clr,ld_M,ld_N,ld_MSB,shft_MSB,shft_N,enter;
  input [31:0]div_to,div_by;
  input A_vs_S;
  input curr_bit;
  output sign;
  output [63:0] div_res ;
  
  //output [63:0]result ;
  reg end_n;
  wire [31:0]a;
  wire [32:0] b,c;
  wire LSB_N;
  wire [32:0] f;
  wire [31:0] div_op ;
  wire [31:0] wh;
 wire s;
 assign div_res = {b[31:0],div_op};
//assign result ={b[31:0]};
  wire in ;
  assign in =1'b0 ;
  wire l;
 // assign l = 1'b0 ;
  wire p;
  assign c[32]= p^l^b[32] ; // an be form instance 
  register #(.N(32)) reg_M (.clr(clr),.clk(clk),.ld(ld_M),.div_by(div_by),.A(a)); // M =short
  register_op_MSB #(.N(33)) reg_MSB (.clr(clr),.clk(clk),.ld(ld_MSB),.shft(shft_MSB),.data_in(c),.A(b),.Div_shft(LSB_N),.sign(sign));
  register_op #(.N(32)) reg_N (.clr(clr),.clk(clk),.ld(ld_N),.shft(shft_N),.div_to(div_to),.N0(curr_bit),.v1(LSB_N),.enter(enter),.A(div_op));
  twOs_compleme  twoco (.a(a),.c(f));
  CarryLookAhead_adder mul_adder (.A(wh),.B(b[31:0]),.sum(c[31:0]),.carry_out(l),.carry_in(in));  
  //adder  summ (.A(a),.B(b),.C(A));
 // sub  subtract (.A(a),.B(b),.C(S));
  mux M(.in1(f[31:0]),.in2(a),.out(wh),.sel(A_vs_S));
 // adder  summ (.A(a),.B(b),.C(A)); // N =biggee one
  //sub  subtract (.A(a),.B(b),.C(S));
  mux1 Mx(.in1(f[32]),.in2(in),.out(p),.sel(A_vs_S));
  endmodule

module divider_contr (clk,clr,ld_M,ld_N,ld_MSB,shft_MSB,shft_N,start,curr_bit,A_vs_S,enter,sign,done);
input clk,start,sign;
output reg clr,ld_M,ld_N,ld_MSB,shft_MSB,shft_N,done,A_vs_S,curr_bit,enter;
  
  
  reg  [3:0] state;
  reg [5:0] count;
  parameter K=32;// no of operation 1st time,2nd time ,3rd time,4th time
  parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101,s7=3'b111,s8=4'b1000,s_add_sub=4'b0110;// 1'd_value not allowed
  
  always @(posedge clk)
    begin
      case (state)
       s0:
          if(start)
            begin 
              clr<=1'b1;
              done<=1'b0;
              state<=s1;
        end
        else
          state<=s0;
        s1:
          begin
          clr<=0;
        count<=0;
            ld_M<= 0;
            enter<=0;
            ld_N<=0;
            ld_MSB<=0;
            
            shft_MSB<=0;
            shft_N<=0;
            state<=s2;
            curr_bit<=0;
            
          end
        s2:// enter mul1
          begin
            ld_N<= 1;
          ld_M<=1;
        state<=s4;
          end
       /* s3://enter mul2
          begin
          ld_M<=0;
            ld_N<=1;
            
            state<=s4;
          end */
      s4: begin //shifting 
      enter<=0;
        ld_M<=0;
        ld_N<= 0;
        ld_MSB<=0;
        if (count==K)
          begin
          state<=s7;
          end
        else begin
              state<=s5; 
           //
          ld_MSB<=0;
          shft_MSB<=1;
        shft_N<=1;
        count<=count+1;
        end
          end
        s5: //S5 direct to sub and off  shift 
          begin
            shft_MSB<=0;
        
              A_vs_S<=0;
               // state<=s7;   
            shft_N<=0; 
          // A_vs_S<=0;
            ld_MSB<=1;
            state<= s_add_sub;
            end
        s_add_sub://s6 decision for add or skip
          begin
             enter<=1;
            if(sign) begin  
           A_vs_S<=1;
              state<=s4;             
              curr_bit<= 0;
            end
            else
              begin
              ld_MSB <= 0;
                curr_bit<= 1;
                state<=s4;
              end
          end
       
        //s6
          
            s7:
              begin
                shft_MSB<=0;
        shft_N<=0;
                ld_MSB<=0;
             done<=1;
                if(start)
                  state<=s0;
                else
                  state<=s7;
                
              end
        default:
          state<=s0;
          endcase     
    end
  
endmodule
 
module divider(clk,clk2,start,done,div_to,div_by,dv_r);
  input clk,clk2,start;
  //input clk2;
  input [31:0] div_to,div_by;
  output [63:0]dv_r ;
  output done;
  wire clr,ld_M,ld_N,ld_MSB,shft_MSB,shft_N,last_bit,a_or_sub,enter,sign;
  divider_dat D_D (.clk(clk2),.clr(clr),.div_to(div_to),.div_by(div_by),.ld_M(ld_M),.ld_N(ld_N),.ld_MSB(ld_MSB),.shft_MSB(shft_MSB),.shft_N(shft_N),.curr_bit(last_bit),.A_vs_S(a_or_sub),.enter(enter),.sign(sign),.div_res(dv_r));
  divider_contr D_C (.clk(clk),.clr(clr),.ld_M(ld_M),.ld_N(ld_N),.ld_MSB(ld_MSB),.shft_MSB(shft_MSB),.shft_N(shft_N),.start(start),.curr_bit(last_bit),.A_vs_S(a_or_sub),.done(done),.enter(enter),.sign(sign));
endmodule

