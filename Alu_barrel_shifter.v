  module mux_2to_1_32(in0,in1,sel,out);
input[31:0] in0,in1;
input sel;
output[31:0] out;
assign out=(sel==1'b1) ?in1 :in0;
endmodule

module Mux_8_to1 (in0,in1,in2,in3,in4,in5,in6,in7, sel,y);
input [31:0] in0,in1,in2,in3,in4,in5,in6,in7;
input [2:0] sel;
  output [31:0] y;
 
wire [31:0] w1_0,w1_1,w1_2,w1_3;
wire [31:0] w2_0,w2_1;
mux_2to_1_32 l1 (.in0(in0),.in1(in1),.sel(sel[0]),.out(w1_0));    
  mux_2to_1_32    l2(.in0(in2),.in1(in3),.sel(sel[0]),.out(w1_1));
mux_2to_1_32 l3(.in0(in4),.in1(in5),.sel(sel[0]),.out(w1_2)); 
 mux_2to_1_32 l4(.in0(in6),.in1(in7),.sel(sel[0]),.out(w1_3)); 
 mux_2to_1_32 l5(.in0(w1_0),.in1(w1_1),.sel(sel[1]),.out(w2_0)); 
  mux_2to_1_32 l6(.in0(w1_2),.in1(w1_3),.sel(sel[1]),.out(w2_1)); 
   mux_2to_1_32 l7(.in0(w2_0),.in1(w2_1),.sel(sel[2]),.out(y));
endmodule
module Mux_32to_1 (in0,in1, in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,sel,y);
input [31:0] in0,in1, in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31 ; 
input [4:0] sel ;
output [31:0] y; 
wire [31:0] w1,w2,w3,w4,w5,w6;
Mux_8_to1 i1 (.in0(in0),.in1(in1),.in2(in2),.in3(in3),.in4(in4),.in5(in5),.in6(in6),.in7(in7),.sel(sel[2:0]),.y(w1));
Mux_8_to1 i2 (.in0(in8),.in1(in9),.in2(in10),.in3(in11),.in4(in12),.in5(in13),.in6(in14),.in7(in15),.sel(sel[2:0]),.y(w2));
Mux_8_to1 i3 (.in0(in16),.in1(in17),.in2(in18),.in3(in19),.in4(in20),.in5(in21),.in6(in22),.in7(in23),.sel(sel[2:0]),.y(w3));
Mux_8_to1 i4 (.in0(in24),.in1(in25),.in2(in26),.in3(in27),.in4(in28),.in5(in29),.in6(in30),.in7(in31),.sel(sel[2:0]),.y(w4));
mux_2to_1_32 i5(.in0(w1),.in1(w2),.sel(sel[3]),.out(w5));
mux_2to_1_32 i6 (.in0(w3),.in1(w4),.sel(sel[3]),.out(w6));
mux_2to_1_32 i7 (.in0(w5),.in1(w6),.sel(sel[4]),.out(y));
endmodule

module barrel_shifter(data_in,shift,dir,data_out);
input [31:0] data_in;
input [4:0]shift;
input dir;
output [31:0] data_out;
wire[31:0]L_shift0,L_shift1,L_shift2,L_shift3,L_shift4,L_shift5,L_shift6,L_shift7,L_shift8,L_shift9,L_shift10,L_shift11,L_shift12,L_shift13,L_shift14,L_shift15,L_shift16,L_shift17,L_shift18,L_shift19,L_shift20,L_shift21,L_shift22,L_shift23,L_shift24,L_shift25,L_shift26,L_shift27,L_shift28,L_shift29,L_shift30,L_shift31;
wire[31:0]right_shift0, right_shift1,right_shift2,right_shift3,right_shift4,right_shift5,right_shift6,right_shift_7,right_shift8,right_shift9,right_shift10,right_shift11,right_shift12,right_shift13,right_shift14,right_shift15,right_shift16,right_shift17,right_shift18,right_shift19,right_shift20,right_shift21,right_shift22,right_shift23,right_shift24,right_shift25,right_shift26,right_shift27,right_shift28,right_shift29,right_shift30,right_shift31;
wire[31:0] left_side;
wire [31:0]right_side;
wire gnd;
assign gnd= 1'b0;
//** right 0
assign right_shift0[0]= data_in[0];
assign right_shift0[1]= data_in[1];
assign right_shift0[2]= data_in[2];
assign right_shift0[3]= data_in[3];
assign right_shift0[4]= data_in[4];
assign right_shift0[5]= data_in[5];
assign right_shift0[6]= data_in[6];
assign right_shift0[7]= data_in[7];
assign right_shift0[8]= data_in[8];
assign right_shift0[9]= data_in[9];
assign right_shift0[10]= data_in[ 10];
assign right_shift0[11]= data_in[ 11];
assign right_shift0[12]= data_in[ 12];
assign right_shift0[13]= data_in[ 13];
assign right_shift0[14]= data_in[ 14];
assign right_shift0[15]= data_in[15 ];
assign right_shift0[16]= data_in[16];
assign right_shift0[17]= data_in[ 17];
assign right_shift0[18]= data_in[ 18];
assign right_shift0[19]= data_in[ 19];
assign right_shift0[20]= data_in[ 20];
assign right_shift0[21]= data_in[ 21];
assign right_shift0[22]= data_in[22 ];
assign right_shift0[23]= data_in[ 23];
assign right_shift0[24]= data_in[ 24];
assign right_shift0[25]= data_in[ 25];
assign right_shift0[26]= data_in[26 ];
assign right_shift0[27]= data_in[ 27];
assign right_shift0[28]= data_in[ 28];
assign right_shift0[29]= data_in[ 29];
assign right_shift0[30]= data_in[ 30];
assign right_shift0[31]= data_in[ 31];


//** right 1 >>
assign right_shift1[0]= data_in[1];
assign right_shift1[1]= data_in[2];
assign right_shift1[2]= data_in[3];
assign right_shift1[3]= data_in[4];
assign right_shift1[4]= data_in[5];
assign right_shift1[5]= data_in[6];
assign right_shift1[6]= data_in[7];
assign right_shift1[7]= data_in[8];
assign right_shift1[31:8]={gnd,data_in[31:9]};
//** right 2
assign right_shift2[0]= data_in[2];
assign right_shift2[1]= data_in[3];
assign right_shift2[2]= data_in[4];
assign right_shift2[3]= data_in[5];
assign right_shift2[4]= data_in[6];
assign right_shift2[5]= data_in[7];
assign right_shift2[6]= data_in[8];
assign right_shift2[7]= data_in[9];
assign right_shift2[31:8] ={gnd,gnd,data_in[31:10]};

//** right 3
assign right_shift3[0]= data_in[3];
assign right_shift3[1]= data_in[4];
assign right_shift3[2]= data_in[5];
assign right_shift3[3]= data_in[6];
assign right_shift3[4]= data_in[7];
assign right_shift3[5]= data_in[8];
assign right_shift3[6]= data_in[9];
assign right_shift3[7]= data_in[10];
assign right_shift3[31:8]={({3{gnd}}),data_in[31:11]};
//** right 4
assign right_shift4[0]= data_in[4];
assign right_shift4[1]= data_in[5];
assign right_shift4[2]= data_in[6];
assign right_shift4[3]= data_in[7];
assign right_shift4[4]= data_in[8];
assign right_shift4[5]= data_in[9];
assign right_shift4[6]= data_in[10];
assign right_shift4[7]= data_in[12];
assign right_shift4[31:8]={({4{gnd}}),data_in[31:12]};
//** right 5
assign right_shift5[0]= data_in[5];
assign right_shift5[1]= data_in[6];
assign right_shift5[2]= data_in[7];
assign right_shift5[3]= data_in[8];
assign right_shift5[4]= data_in[9];
assign right_shift5[5]= data_in[10];
assign right_shift5[6]=data_in[11] ;
assign right_shift5[7]=data_in[12] ;
assign right_shift5[31:8]={({5{gnd}}),data_in[31:13]};
//** right 6
assign right_shift6[0]= data_in[6];
assign right_shift6[1]= data_in[7];
assign right_shift6[2]=data_in[8] ;
assign right_shift6[3]= data_in[9] ;
assign right_shift6[4]= data_in[10];
assign right_shift6[5]= data_in[11];
assign right_shift6[6]=data_in [12];
assign right_shift6[7]= data_in[13];
assign right_shift6[31:8] = {({6{gnd}}),data_in[31:14]};
//** right 7
assign right_shift_7[0]= data_in[7];
assign right_shift_7[1]= data_in[8];
assign right_shift_7[2]= data_in[9];
assign right_shift_7[3]= data_in[10] ;
assign right_shift_7[4]= data_in[11];
assign right_shift_7[5]=data_in[12] ;
assign right_shift_7[6]= data_in[13];
assign right_shift_7[7]= data_in[14];
assign right_shift_7[31:8] = {({7{gnd}}),data_in[31:15]};
// right 8 
assign right_shift8[31:0] = {({8{gnd}}),data_in[31:8]};
// right 9 
assign right_shift9[31:0] = {({9{gnd}}),data_in[31:9]};
// right 10
assign right_shift10[31:0] = {({10{gnd}}),data_in[31:10]};
// right 011
assign right_shift11[31:0] = {({11{gnd}}),data_in[31:11]};

// right 12 
assign right_shift12[31:0] = {({12{gnd}}),data_in[31:12]};
// right 13 
assign right_shift13[31:0] = {({13{gnd}}),data_in[31:13]};
// right 14 
assign right_shift14[31:0] = {({14{gnd}}),data_in[31:14]};
// right 15
assign right_shift15[31:0] = {({15{gnd}}),data_in[31:15]};
// right 16
assign right_shift16[31:0] = {({16{gnd}}),data_in[31:16]};
// right 17 
assign right_shift17[31:0] = {({17{gnd}}),data_in[31:17]};
// right 18 
assign right_shift18[31:0] = {({18{gnd}}),data_in[31:18]};
// right 19 
assign right_shift19[31:0] = {({19{gnd}}),data_in[31:19]};
// right 20 
assign right_shift20[31:0] = {({20{gnd}}),data_in[31:20]} ;
// right 8 
assign right_shift21[31:0] = {({21{gnd}}),data_in[31:21]} ;
// right 8 
assign right_shift22[31:0] = {({22{gnd}}),data_in[31:22]} ;
// right 8 
assign right_shift23[31:0] = {({23{gnd}}),data_in[31:23]} ;
// right 8 
assign right_shift24[31:0] = {({24{gnd}}),data_in[31:24]} ;
// right 8 
assign right_shift25[31:0] = {({25{gnd}}),data_in[31:25]} ;

// right 8 
assign right_shift26[31:0] = {({26{gnd}}),data_in[31:26]} ;
// right 8 
assign right_shift27[31:0] = {({27{gnd}}),data_in[31:27]} ;
// right 8 
assign right_shift28[31:0] = {({28{gnd}}),data_in[31:28]} ;
// right 8 
assign right_shift29[31:0] = {({29{gnd}}),data_in[31:29]} ;
// right 8 
assign right_shift30[31:0] = {({30{gnd}}),data_in[31:30]} ;
// right 8 
assign right_shift31[31:0] = {({31{gnd}}),data_in[31]} ;
// Left 0
assign L_shift0[0]= data_in[0];
assign L_shift0[1]= data_in[1];
assign L_shift0[2]= data_in[2];
assign L_shift0[3]= data_in[3];
assign L_shift0[4]= data_in[4];
assign L_shift0[5]= data_in[5];
assign L_shift0[6]= data_in[6];
assign L_shift0[7]= data_in[7];
assign L_shift0[8]=data_in[8] ;
assign L_shift0[9] = data_in[9] ;
assign L_shift0[10] = data_in[10] ;
assign L_shift0[31:11] = data_in[31:11] ;
//** Left 1
assign L_shift1[0]= gnd;
assign L_shift1[1]= data_in[0];
assign L_shift1[2]= data_in[1];
assign L_shift1[3]= data_in[2];
assign L_shift1[4]= data_in[3];
assign L_shift1[5]= data_in[4];
assign L_shift1[6]= data_in[5];
assign L_shift1[7]= data_in[6];
assign L_shift1[31:8] = {data_in[30:7] };
//** Left 2
assign L_shift2[0]= gnd;
assign L_shift2[1]= gnd;
assign L_shift2[2]= data_in[0];
assign L_shift2[3]= data_in[1];
assign L_shift2[4]= data_in[2];
assign L_shift2[5]= data_in[3];
assign L_shift2[6]= data_in[4];
assign L_shift2[7]= data_in[5];
assign L_shift2[31:8] = {data_in[29:6] };
//LEft 3
assign L_shift3[0]= gnd;
assign L_shift3[1]= gnd;
assign L_shift3[2]= gnd;
assign L_shift3[3]= data_in[0];
assign L_shift3[4]= data_in[1];
assign L_shift3[5]= data_in[2];
assign L_shift3[6]= data_in[3];
assign L_shift3[7]= data_in[4];
assign L_shift3[31:8] = {data_in[28:5] };
// Left 4
assign L_shift4[0]= gnd;
assign L_shift4[1]= gnd;
assign L_shift4[2]= gnd;
assign L_shift4[3]= gnd;
assign L_shift4[4]= data_in[0];
assign L_shift4[5]= data_in[1];
assign L_shift4[6]= data_in[2];
assign L_shift4[7]= data_in[3];
assign L_shift4[31:8] = {data_in[27:4] };
//** Left 5
assign L_shift5[0]= gnd;
assign L_shift5[1]= gnd;
assign L_shift5[2]= gnd;
assign L_shift5[3]= gnd;
assign L_shift5[4]= gnd;
assign L_shift5[5]= data_in[0];
assign L_shift5[6]= data_in[1];
assign L_shift5[7]= data_in[2];
assign L_shift5[31:8] = {data_in[26:3] };

//** left 6
assign L_shift6[0]= gnd;
assign L_shift6[1]= gnd;
assign L_shift6[2]= gnd;
assign L_shift6[3]= gnd;
assign L_shift6[4]= gnd;
assign L_shift6[5]= gnd;
assign L_shift6[6]=data_in[0];
assign L_shift6[7]= data_in[1];
assign L_shift6[31:8] = {data_in[25:2] };
//** left 7
assign L_shift7[0]= gnd;
assign L_shift7[1]= gnd;
assign L_shift7[2]= gnd;
assign L_shift7[3]= gnd;
assign L_shift7[4]= gnd;
assign L_shift7[5]= gnd;
assign L_shift7[6]= gnd;
assign L_shift7[7]=data_in[0];
assign L_shift7[31:8] = {data_in[24:1] };
//** left 8
assign L_shift8[31:0] = {data_in[23:0], ({8{gnd}}) };
assign L_shift9[31:0] = {data_in[22:0] ,({9{gnd}})  };
assign L_shift10[31:0] = {data_in[21:0] ,({10{gnd}})};
assign L_shift11[31:0] = { data_in[20:0] ,  ({11{gnd}})};
assign L_shift12[31:0] = {data_in[19:0] ,({12{gnd}})};
assign L_shift13[31:0] = {data_in[18:0] ,({13{gnd}})  } ;
assign L_shift14[31:0] = {data_in[17:0] ,({14{gnd}})  } ;
assign L_shift15[31:0] = {data_in[16:0] ,({15{gnd} }) } ;
assign L_shift16[31:0] = {data_in[15:0] ,({16{gnd}})  } ;
assign L_shift17[31:0] = {data_in[14:0] ,({17{gnd}})  } ;
assign L_shift18[31:0] = {data_in[13:0] ,({18{gnd} }) }  ;
assign L_shift19[31:0] = {data_in[12:0] ,({19{gnd}})  } ;
assign L_shift20[31:0] = {data_in[11:0] ,({20{gnd}})  };
assign L_shift21[31:0] = {data_in[10:0] ,({21{gnd}})  }  ;
assign L_shift22[31:0] = {data_in[9:0] ,({22{gnd} }) } ;
assign L_shift23[31:0] = {data_in[8:0] ,({23{gnd}})  } ;
assign L_shift24[31:0] = {data_in[7:0] ,({24{gnd} }) } ;
assign L_shift25[31:0] = {data_in[6:0] ,({25{gnd}})  } ;
assign L_shift26[31:0] = {data_in[5:0] ,({26{gnd} }) } ;
assign L_shift27[31:0] = {data_in[4:0] ,({27{gnd} }) } ;
assign L_shift28[31:0] = {data_in[3:0] ,({28{gnd} }) } ;
assign L_shift29[31:0] = {data_in[2:0] ,({29{gnd}})  } ;
assign L_shift30[31:0] = {data_in[1:0] ,({30{gnd}})  } ;
assign L_shift31[31:0]= {data_in[0],({31{gnd}})} ;

  //Mux_8_to1 g2 (.in0(L_shift0),.in1(L_shift1),.in2(L_shift2),.in3(L_shift3),.in4(L_shift4),.in5(L_shift5),.in6(L_shift6),.in7(L_shift7),.sel(shift), .y(left_side));
//Mux_8_to1 g3 (.in0(right_shift0),.in1(right_shift1),.in2(right_shift2),.in3(right_shift3),.in4(right_shift4),.in5(right_shift5),.in6(right_shift6),.in7(right_shift_7),.sel(shift), .y(right_side));
Mux_32to_1 j1 (.in0(L_shift0),.in1(L_shift1), .in2(L_shift2),.in3(L_shift3),.in4(L_shift4),.in5(L_shift5),.in6(L_shift6),.in7(L_shift7),.in8(L_shift8),.in9(L_shift9),.in10(L_shift10),.in11(L_shift11),.in12(L_shift12),.in13(L_shift13),.in14(L_shift14),.in15(L_shift15),.in16(L_shift16),.in17(L_shift17),.in18(L_shift18),.in19(L_shift19),.in20(L_shift20),.in21(L_shift21),.in22(L_shift22),.in23(L_shift23),.in24(L_shift24),.in25(L_shift25),.in26(L_shift26),.in27(L_shift27),.in28(L_shift28),.in29(L_shift29),.in30(L_shift30),.in31(L_shift31),.sel(shift),.y(left_side));
Mux_32to_1 j2 (.in0(right_shift0),.in1(right_shift1), .in2(right_shift2),.in3(right_shift3),.in4(right_shift4),.in5(right_shift5),.in6(right_shift6),.in7(right_shift_7),.in8(right_shift8),.in9(right_shift9),.in10(right_shift10),.in11(right_shift11),.in12(right_shift12),.in13(right_shift13),.in14(right_shift14),.in15(right_shift15),.in16(right_shift16),.in17(right_shift17),.in18(right_shift18),.in19(right_shift19),.in20(right_shift20),.in21(right_shift21),.in22(right_shift22),.in23(right_shift23),.in24(right_shift24),.in25(right_shift25),.in26(right_shift26),.in27(right_shift27),.in28(right_shift28),.in29(right_shift29),.in30(right_shift30),.in31(right_shift31),.sel(shift),.y(right_side));
mux_2to_1_32 g4(.in0(left_side),.in1(right_side),.sel(dir),.out(data_out));
endmodule