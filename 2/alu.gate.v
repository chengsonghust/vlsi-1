
module alu_DW01_addsub_0 ( A, B, CI, ADD_SUB, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI, ADD_SUB;
  output CO;

  wire   [9:0] carry;
  wire   [8:0] B_AS;

  FADDX1 U1_6 ( .A(A[6]), .B(B_AS[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  FADDX1 U1_5 ( .A(A[5]), .B(B_AS[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  FADDX1 U1_4 ( .A(A[4]), .B(B_AS[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  FADDX1 U1_3 ( .A(A[3]), .B(B_AS[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  FADDX1 U1_2 ( .A(A[2]), .B(B_AS[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  FADDX1 U1_1 ( .A(A[1]), .B(B_AS[1]), .CI(carry[1]), .CO(carry[2]), .S(SUM[1]) );
  FADDX1 U1_7 ( .A(A[7]), .B(B_AS[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  FADDX1 U1_0 ( .A(A[0]), .B(B_AS[0]), .CI(carry[0]), .CO(carry[1]), .S(SUM[0]) );
  XOR3X1 U1_8 ( .IN1(A[8]), .IN2(carry[0]), .IN3(carry[8]), .Q(SUM[8]) );
  XOR2X1 U1 ( .IN1(ADD_SUB), .IN2(CI), .Q(carry[0]) );
  XOR2X1 U2 ( .IN1(B[7]), .IN2(ADD_SUB), .Q(B_AS[7]) );
  XOR2X1 U3 ( .IN1(B[6]), .IN2(ADD_SUB), .Q(B_AS[6]) );
  XOR2X1 U4 ( .IN1(B[5]), .IN2(ADD_SUB), .Q(B_AS[5]) );
  XOR2X1 U5 ( .IN1(B[4]), .IN2(ADD_SUB), .Q(B_AS[4]) );
  XOR2X1 U6 ( .IN1(B[3]), .IN2(ADD_SUB), .Q(B_AS[3]) );
  XOR2X1 U7 ( .IN1(B[2]), .IN2(ADD_SUB), .Q(B_AS[2]) );
  XOR2X1 U8 ( .IN1(B[1]), .IN2(ADD_SUB), .Q(B_AS[1]) );
  XOR2X1 U9 ( .IN1(B[0]), .IN2(ADD_SUB), .Q(B_AS[0]) );
endmodule


module alu ( in_a, in_b, opcode, alu_out, alu_zero, alu_carry );
  input [7:0] in_a;
  input [7:0] in_b;
  input [3:0] opcode;
  output [7:0] alu_out;
  output alu_zero, alu_carry;
  wire   N74, N75, N76, N77, N78, N79, N80, N81, N82, N83, N84, N85, N86, N87,
         N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99, N100,
         N101, N102, N103, N104, N105, N106, \U3/U1/Z_0 , \U3/U1/Z_1 ,
         \U3/U1/Z_2 , \U3/U1/Z_3 , \U3/U1/Z_4 , \U3/U1/Z_5 , \U3/U1/Z_6 ,
         \U3/U1/Z_7 , \U3/U2/Z_0 , \U3/U2/Z_1 , \U3/U2/Z_2 , \U3/U2/Z_3 ,
         \U3/U2/Z_4 , \U3/U2/Z_5 , \U3/U2/Z_6 , \U3/U2/Z_7 , \U3/U4/Z_0 , n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128;

  alu_DW01_addsub_0 r30 ( .A({n127, \U3/U1/Z_7 , \U3/U1/Z_6 , \U3/U1/Z_5 , 
        \U3/U1/Z_4 , \U3/U1/Z_3 , \U3/U1/Z_2 , \U3/U1/Z_1 , \U3/U1/Z_0 }), .B(
        {n128, \U3/U2/Z_7 , \U3/U2/Z_6 , \U3/U2/Z_5 , \U3/U2/Z_4 , \U3/U2/Z_3 , 
        \U3/U2/Z_2 , \U3/U2/Z_1 , \U3/U2/Z_0 }), .CI(n128), .ADD_SUB(
        \U3/U4/Z_0 ), .SUM({N82, N81, N80, N79, N78, N77, N76, N75, N74}) );
  MUX21X1 U77 ( .IN1(n78), .IN2(n76), .S(opcode[3]), .Q(alu_out[2]) );
  MUX21X1 U78 ( .IN1(N76), .IN2(n77), .S(opcode[2]), .Q(n78) );
  MUX41X1 U79 ( .IN1(in_a[3]), .IN3(n124), .IN2(in_a[1]), .IN4(N76), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n76) );
  MUX41X1 U80 ( .IN1(N76), .IN3(N96), .IN2(N88), .IN4(N104), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n77) );
  MUX21X1 U81 ( .IN1(n90), .IN2(n88), .S(opcode[3]), .Q(alu_out[6]) );
  MUX21X1 U82 ( .IN1(N80), .IN2(n89), .S(opcode[2]), .Q(n90) );
  MUX41X1 U83 ( .IN1(in_a[7]), .IN3(n120), .IN2(in_a[5]), .IN4(N80), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n88) );
  MUX41X1 U84 ( .IN1(N80), .IN3(N92), .IN2(N84), .IN4(N100), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n89) );
  MUX21X1 U85 ( .IN1(n81), .IN2(n79), .S(opcode[3]), .Q(alu_out[3]) );
  MUX21X1 U86 ( .IN1(N77), .IN2(n80), .S(opcode[2]), .Q(n81) );
  MUX41X1 U87 ( .IN1(in_a[4]), .IN3(n123), .IN2(in_a[2]), .IN4(N77), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n79) );
  MUX41X1 U88 ( .IN1(N77), .IN3(N95), .IN2(N87), .IN4(N103), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n80) );
  MUX21X1 U89 ( .IN1(n95), .IN2(n93), .S(opcode[3]), .Q(alu_out[7]) );
  MUX21X1 U90 ( .IN1(N81), .IN2(n94), .S(opcode[2]), .Q(n95) );
  MUX21X1 U91 ( .IN1(n92), .IN2(n91), .S(opcode[1]), .Q(n93) );
  MUX41X1 U92 ( .IN1(N81), .IN3(N91), .IN2(N83), .IN4(N99), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n94) );
  MUX21X1 U93 ( .IN1(n84), .IN2(n82), .S(opcode[3]), .Q(alu_out[4]) );
  MUX21X1 U94 ( .IN1(N78), .IN2(n83), .S(opcode[2]), .Q(n84) );
  MUX41X1 U95 ( .IN1(in_a[5]), .IN3(n122), .IN2(in_a[3]), .IN4(N78), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n82) );
  MUX41X1 U96 ( .IN1(N78), .IN3(N94), .IN2(N86), .IN4(N102), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n83) );
  MUX21X1 U97 ( .IN1(n72), .IN2(n70), .S(opcode[3]), .Q(alu_out[0]) );
  MUX21X1 U98 ( .IN1(N74), .IN2(n71), .S(opcode[2]), .Q(n72) );
  MUX21X1 U99 ( .IN1(n69), .IN2(n68), .S(opcode[1]), .Q(n70) );
  MUX41X1 U100 ( .IN1(N74), .IN3(N98), .IN2(N90), .IN4(N106), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n71) );
  MUX21X1 U101 ( .IN1(n75), .IN2(n73), .S(opcode[3]), .Q(alu_out[1]) );
  MUX21X1 U102 ( .IN1(N75), .IN2(n74), .S(opcode[2]), .Q(n75) );
  MUX41X1 U103 ( .IN1(in_a[2]), .IN3(n125), .IN2(in_a[0]), .IN4(N75), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n73) );
  MUX41X1 U104 ( .IN1(N75), .IN3(N97), .IN2(N89), .IN4(N105), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n74) );
  MUX21X1 U105 ( .IN1(n87), .IN2(n85), .S(opcode[3]), .Q(alu_out[5]) );
  MUX21X1 U106 ( .IN1(N79), .IN2(n86), .S(opcode[2]), .Q(n87) );
  MUX41X1 U107 ( .IN1(in_a[6]), .IN3(n121), .IN2(in_a[4]), .IN4(N79), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n85) );
  MUX41X1 U108 ( .IN1(N79), .IN3(N93), .IN2(N85), .IN4(N101), .S0(opcode[1]), 
        .S1(opcode[0]), .Q(n86) );
  AND2X1 U109 ( .IN1(n96), .IN2(n118), .Q(n63) );
  AND2X1 U110 ( .IN1(in_a[1]), .IN2(n96), .Q(n69) );
  AND2X1 U111 ( .IN1(in_a[6]), .IN2(opcode[0]), .Q(n92) );
  MUX21X1 U112 ( .IN1(n126), .IN2(N74), .S(opcode[0]), .Q(n68) );
  MUX21X1 U113 ( .IN1(n119), .IN2(N81), .S(opcode[0]), .Q(n91) );
  MUX21X1 U114 ( .IN1(in_a[0]), .IN2(in_a[7]), .S(opcode[0]), .Q(n64) );
  MUX21X1 U115 ( .IN1(n67), .IN2(n66), .S(opcode[3]), .Q(alu_carry) );
  MUX21X1 U116 ( .IN1(n64), .IN2(n65), .S(opcode[1]), .Q(n66) );
  OA21X1 U117 ( .IN1(n63), .IN2(n116), .IN3(N82), .Q(n67) );
  OR2X1 U118 ( .IN1(N82), .IN2(n96), .Q(n65) );
  INVX0 U119 ( .IN(opcode[0]), .QN(n96) );
  NOR2X0 U120 ( .IN1(n97), .IN2(n98), .QN(alu_zero) );
  OR4X1 U121 ( .IN1(alu_out[1]), .IN2(alu_out[0]), .IN3(alu_out[3]), .IN4(
        alu_out[2]), .Q(n98) );
  OR4X1 U122 ( .IN1(alu_out[5]), .IN2(alu_out[4]), .IN3(alu_out[7]), .IN4(
        alu_out[6]), .Q(n97) );
  INVX0 U123 ( .IN(n99), .QN(\U3/U4/Z_0 ) );
  MUX21X1 U124 ( .IN1(n100), .IN2(n128), .S(n101), .Q(\U3/U2/Z_7 ) );
  MUX21X1 U125 ( .IN1(n100), .IN2(n128), .S(n102), .Q(\U3/U2/Z_6 ) );
  MUX21X1 U126 ( .IN1(n100), .IN2(n128), .S(n103), .Q(\U3/U2/Z_5 ) );
  MUX21X1 U127 ( .IN1(n100), .IN2(n128), .S(n104), .Q(\U3/U2/Z_4 ) );
  MUX21X1 U128 ( .IN1(n100), .IN2(n128), .S(n105), .Q(\U3/U2/Z_3 ) );
  MUX21X1 U129 ( .IN1(n100), .IN2(n128), .S(n106), .Q(\U3/U2/Z_2 ) );
  MUX21X1 U130 ( .IN1(n100), .IN2(n128), .S(n107), .Q(\U3/U2/Z_1 ) );
  INVX0 U131 ( .IN(n108), .QN(n128) );
  INVX0 U132 ( .IN(n109), .QN(n100) );
  NAND3X0 U133 ( .IN1(n110), .IN2(n111), .IN3(n112), .QN(\U3/U2/Z_0 ) );
  MUX21X1 U134 ( .IN1(n109), .IN2(n108), .S(n113), .Q(n112) );
  MUX21X1 U135 ( .IN1(n114), .IN2(n127), .S(n119), .Q(\U3/U1/Z_7 ) );
  MUX21X1 U136 ( .IN1(n114), .IN2(n127), .S(n120), .Q(\U3/U1/Z_6 ) );
  MUX21X1 U137 ( .IN1(n114), .IN2(n127), .S(n121), .Q(\U3/U1/Z_5 ) );
  MUX21X1 U138 ( .IN1(n114), .IN2(n127), .S(n122), .Q(\U3/U1/Z_4 ) );
  MUX21X1 U139 ( .IN1(n114), .IN2(n127), .S(n123), .Q(\U3/U1/Z_3 ) );
  MUX21X1 U140 ( .IN1(n114), .IN2(n127), .S(n124), .Q(\U3/U1/Z_2 ) );
  MUX21X1 U141 ( .IN1(n114), .IN2(n127), .S(n125), .Q(\U3/U1/Z_1 ) );
  MUX21X1 U142 ( .IN1(n114), .IN2(n127), .S(n126), .Q(\U3/U1/Z_0 ) );
  INVX0 U143 ( .IN(n111), .QN(n127) );
  NAND3X0 U144 ( .IN1(opcode[1]), .IN2(opcode[0]), .IN3(opcode[3]), .QN(n111)
         );
  NAND3X0 U145 ( .IN1(n109), .IN2(n108), .IN3(n110), .QN(n114) );
  AND2X1 U146 ( .IN1(n99), .IN2(n115), .Q(n110) );
  NAND4X0 U147 ( .IN1(opcode[1]), .IN2(opcode[0]), .IN3(n116), .IN4(n117), 
        .QN(n115) );
  NAND3X0 U148 ( .IN1(n118), .IN2(n117), .IN3(n96), .QN(n99) );
  NAND3X0 U149 ( .IN1(n116), .IN2(n117), .IN3(n96), .QN(n108) );
  NAND3X0 U150 ( .IN1(n116), .IN2(n117), .IN3(n118), .QN(n109) );
  INVX0 U151 ( .IN(opcode[1]), .QN(n118) );
  INVX0 U152 ( .IN(opcode[3]), .QN(n117) );
  INVX0 U153 ( .IN(opcode[2]), .QN(n116) );
  XNOR2X1 U154 ( .IN1(n101), .IN2(in_a[7]), .Q(N99) );
  NOR2X0 U155 ( .IN1(n126), .IN2(n113), .QN(N98) );
  NOR2X0 U156 ( .IN1(n125), .IN2(n107), .QN(N97) );
  NOR2X0 U157 ( .IN1(n124), .IN2(n106), .QN(N96) );
  NOR2X0 U158 ( .IN1(n123), .IN2(n105), .QN(N95) );
  NOR2X0 U159 ( .IN1(n122), .IN2(n104), .QN(N94) );
  NOR2X0 U160 ( .IN1(n121), .IN2(n103), .QN(N93) );
  NOR2X0 U161 ( .IN1(n120), .IN2(n102), .QN(N92) );
  NOR2X0 U162 ( .IN1(n119), .IN2(n101), .QN(N91) );
  NAND2X0 U163 ( .IN1(n113), .IN2(n126), .QN(N90) );
  INVX0 U164 ( .IN(in_a[0]), .QN(n126) );
  NAND2X0 U165 ( .IN1(n107), .IN2(n125), .QN(N89) );
  INVX0 U166 ( .IN(in_a[1]), .QN(n125) );
  NAND2X0 U167 ( .IN1(n106), .IN2(n124), .QN(N88) );
  INVX0 U168 ( .IN(in_a[2]), .QN(n124) );
  NAND2X0 U169 ( .IN1(n105), .IN2(n123), .QN(N87) );
  INVX0 U170 ( .IN(in_a[3]), .QN(n123) );
  NAND2X0 U171 ( .IN1(n104), .IN2(n122), .QN(N86) );
  INVX0 U172 ( .IN(in_a[4]), .QN(n122) );
  NAND2X0 U173 ( .IN1(n103), .IN2(n121), .QN(N85) );
  INVX0 U174 ( .IN(in_a[5]), .QN(n121) );
  NAND2X0 U175 ( .IN1(n102), .IN2(n120), .QN(N84) );
  INVX0 U176 ( .IN(in_a[6]), .QN(n120) );
  NAND2X0 U177 ( .IN1(n101), .IN2(n119), .QN(N83) );
  INVX0 U178 ( .IN(in_a[7]), .QN(n119) );
  INVX0 U179 ( .IN(in_b[7]), .QN(n101) );
  XNOR2X1 U180 ( .IN1(n113), .IN2(in_a[0]), .Q(N106) );
  INVX0 U181 ( .IN(in_b[0]), .QN(n113) );
  XNOR2X1 U182 ( .IN1(n107), .IN2(in_a[1]), .Q(N105) );
  INVX0 U183 ( .IN(in_b[1]), .QN(n107) );
  XNOR2X1 U184 ( .IN1(n106), .IN2(in_a[2]), .Q(N104) );
  INVX0 U185 ( .IN(in_b[2]), .QN(n106) );
  XNOR2X1 U186 ( .IN1(n105), .IN2(in_a[3]), .Q(N103) );
  INVX0 U187 ( .IN(in_b[3]), .QN(n105) );
  XNOR2X1 U188 ( .IN1(n104), .IN2(in_a[4]), .Q(N102) );
  INVX0 U189 ( .IN(in_b[4]), .QN(n104) );
  XNOR2X1 U190 ( .IN1(n103), .IN2(in_a[5]), .Q(N101) );
  INVX0 U191 ( .IN(in_b[5]), .QN(n103) );
  XNOR2X1 U192 ( .IN1(n102), .IN2(in_a[6]), .Q(N100) );
  INVX0 U193 ( .IN(in_b[6]), .QN(n102) );
endmodule

