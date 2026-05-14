 //`include "Alu_adder32(CLA).v"
 //`include "Alu_subtr(_cla).v"
//`include "adder.v"
//`include "sub32.v"
`ifndef adder32_V
`define adder32_V


module adder(a,b,Carry_in,Carry_out,sum1);
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

module And_Or_stage1(a,b,c,d);
input a,b;
  output c,d;
  assign c=a & b;
  assign d =a^b;
endmodule

module and_orr(d,c,b,a);//2nd stage operator
  input a,b,c;
  output wire d;
  wire t1;
  and A1(t1,a,b);
  or O1(d,t1,c);
endmodule

module generate_propagate_add (g_in_upper,g_in_lower,p_in_upper,p_in_lower,G_out,P_out) ;
  input p_in_lower,g_in_upper,g_in_lower,p_in_upper;
  output wire G_out,P_out;
  wire t1;
  and A1 (t1,p_in_upper,g_in_lower);
  or O1(G_out,g_in_upper,t1);
  and A2(P_out,p_in_lower,p_in_upper);
endmodule
module CarryLookAhead_adder(A,B,sum,carry_out,carry_in);
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
      generate_propagate_add  gp (.G_out(Gi[n+32]),.P_out(Pi[n+32]),.g_in_lower(Gi[2*n]),.p_in_upper(Pi[2*n+1]),.p_in_lower(Pi[2*n]),.g_in_upper(Gi[2*n+1]));// gp not advised to give 
   //.G_out(Gi[n+32]),.P_out(Pi[n+32]),
    end
  endgenerate
  
  generate for(a=0;a<32;a=a+1)//2nd stage adder
    begin : gens_adder
      
        
      if(a%2==0)
      adder adding (.a(A[a]),.b(B[a]),.Carry_in(agn[a/2]),.sum1(sum[a]),.Carry_out(carry_flow[a/2]));
   else
     
     adder adding (.a(A[a]),.b(B[a]),.Carry_in(carry_flow[(a-1)/2]),.sum1(sum[a]),.Carry_out());
    end
  endgenerate
  //2nd stage cal
  and_orr AO1(t2,Gi[58],Gi[60],Pi[58]);
  and_orr AO2(t4,Gi[52],Gi[60],Pi[52]);
  and_orr AO3(t6,Gi[40],Gi[60],Pi[40]);//after reading notes i analysis then move from again stage 1 adder to here to fix this
  and_orr AO4(t9,Gi[50],Gi[56],Pi[50]);
  and_orr AO5(t11,Gi[36],Gi[56],Pi[36]);
  and_orr AO6(t13,Gi[54],t2,Pi[54]);
  and_orr AO7(t15,Gi[44],t2,Pi[44]);
  and_orr AO8(t18,Gi[34],Gi[48],Pi[34]);
  and_orr AO9(t20,Gi[38],t9,Pi[38]);
  and_orr A10(t22,Gi[42],t4,Pi[42]);
  and_orr A11(t24,Gi[46],t13,Pi[46]);
  
 
  adder A0 (A[0],B[0],carry_in,Gi[0],Pi[0]); // 1st adder
  genvar i;
  generate//remaing 1st stage adder 2input
    for( i=1;i<32;i=i+1)
    begin
      
        
      And_Or_stage1 ao(A[i],B[i],Gi[i],Pi[i]);// t help ordering which by mistake not 
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
  `endif