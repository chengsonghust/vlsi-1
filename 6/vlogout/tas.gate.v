
module tas ( clk_50, clk_2, reset_n, serial_data, data_ena, ram_wr_n, ram_data, 
        ram_addr );
  output [7:0] ram_data;
  output [10:0] ram_addr;
  input clk_50, clk_2, reset_n, serial_data, data_ena;
  output ram_wr_n;
  wire   a5_or_c3, wr_fifo, fifo_empty, n3, n4, n5, n6, \S1/n9 , \S1/n8 ,
         \S1/n7 , \S1/n6 , \S1/n5 , \S1/n4 , \S1/n3 , \S1/n2 , \S1/n1 ,
         \CB50/n16 , \CB50/n15 , \CB50/n14 , \CB50/n13 , \CB50/n12 ,
         \CB50/n11 , \CB50/n10 , \CB50/n9 , \CB50/n8 , \CB50/n6 , \CB50/n5 ,
         \CB50/n4 , \CB50/n3 , \CB50/n2 , \CB50/n1 , \CB50/write_ns ,
         \CB50/data_type_ns[2] , \CB50/data_type_ns[1] ,
         \CB50/data_type_ns[0] , \CB50/data_type_ps[0] ,
         \CB50/data_type_ps[1] , \CB50/data_type_ps[2] , \CB50/packet_type_ns ,
         \CB50/packet_type_ps , \F1/n134 , \F1/n133 , \F1/n132 , \F1/n131 ,
         \F1/n130 , \F1/n129 , \F1/n128 , \F1/n127 , \F1/n126 , \F1/n125 ,
         \F1/n124 , \F1/n123 , \F1/n122 , \F1/n121 , \F1/n120 , \F1/n119 ,
         \F1/n118 , \F1/n117 , \F1/n116 , \F1/n115 , \F1/n114 , \F1/n113 ,
         \F1/n112 , \F1/n111 , \F1/n110 , \F1/n109 , \F1/n108 , \F1/n107 ,
         \F1/n106 , \F1/n105 , \F1/n104 , \F1/n103 , \F1/n102 , \F1/n101 ,
         \F1/n100 , \F1/n99 , \F1/n98 , \F1/n97 , \F1/n96 , \F1/n95 , \F1/n94 ,
         \F1/n93 , \F1/n92 , \F1/n91 , \F1/n90 , \F1/n89 , \F1/n88 , \F1/n87 ,
         \F1/n86 , \F1/n85 , \F1/n84 , \F1/n83 , \F1/n82 , \F1/n81 , \F1/n80 ,
         \F1/n79 , \F1/n78 , \F1/n77 , \F1/n76 , \F1/n75 , \F1/n74 , \F1/n73 ,
         \F1/n72 , \F1/n71 , \F1/n70 , \F1/n69 , \F1/n68 , \F1/n67 , \F1/n66 ,
         \F1/n65 , \F1/n64 , \F1/n63 , \F1/n62 , \F1/n61 , \F1/n60 , \F1/n59 ,
         \F1/n58 , \F1/n57 , \F1/n56 , \F1/n55 , \F1/n54 , \F1/n53 , \F1/n52 ,
         \F1/n51 , \F1/n50 , \F1/n49 , \F1/n48 , \F1/n47 , \F1/n46 , \F1/n45 ,
         \F1/n44 , \F1/n42 , \F1/n41 , \F1/n40 , \F1/n39 , \F1/n38 , \F1/n37 ,
         \F1/n35 , \F1/n33 , \F1/n32 , \F1/n31 , \F1/n30 , \F1/n29 , \F1/n28 ,
         \F1/n27 , \F1/n26 , \F1/n25 , \F1/n24 , \F1/n23 , \F1/n22 , \F1/n21 ,
         \F1/n20 , \F1/n19 , \F1/n18 , \F1/n17 , \F1/n15 , \F1/n13 , \F1/n12 ,
         \F1/n11 , \F1/n10 , \F1/n9 , \F1/n8 , \F1/n7 , \F1/n6 , \F1/n5 ,
         \F1/memory[0][0] , \F1/memory[0][1] , \F1/memory[0][2] ,
         \F1/memory[0][3] , \F1/memory[0][4] , \F1/memory[0][5] ,
         \F1/memory[0][6] , \F1/memory[0][7] , \F1/memory[1][0] ,
         \F1/memory[1][1] , \F1/memory[1][2] , \F1/memory[1][3] ,
         \F1/memory[1][4] , \F1/memory[1][5] , \F1/memory[1][6] ,
         \F1/memory[1][7] , \F1/memory[2][0] , \F1/memory[2][1] ,
         \F1/memory[2][2] , \F1/memory[2][3] , \F1/memory[2][4] ,
         \F1/memory[2][5] , \F1/memory[2][6] , \F1/memory[2][7] ,
         \F1/memory[3][0] , \F1/memory[3][1] , \F1/memory[3][2] ,
         \F1/memory[3][3] , \F1/memory[3][4] , \F1/memory[3][5] ,
         \F1/memory[3][6] , \F1/memory[3][7] , \F1/memory[4][0] ,
         \F1/memory[4][1] , \F1/memory[4][2] , \F1/memory[4][3] ,
         \F1/memory[4][4] , \F1/memory[4][5] , \F1/memory[4][6] ,
         \F1/memory[4][7] , \F1/memory[5][0] , \F1/memory[5][1] ,
         \F1/memory[5][2] , \F1/memory[5][3] , \F1/memory[5][4] ,
         \F1/memory[5][5] , \F1/memory[5][6] , \F1/memory[5][7] ,
         \F1/memory[6][0] , \F1/memory[6][1] , \F1/memory[6][2] ,
         \F1/memory[6][3] , \F1/memory[6][4] , \F1/memory[6][5] ,
         \F1/memory[6][6] , \F1/memory[6][7] , \F1/memory[7][0] ,
         \F1/memory[7][1] , \F1/memory[7][2] , \F1/memory[7][3] ,
         \F1/memory[7][4] , \F1/memory[7][5] , \F1/memory[7][6] ,
         \F1/memory[7][7] , \F1/empty_cmp , \F1/wr_addr[3] , \F1/wr_ptr[0] ,
         \F1/wr_ptr[1] , \F1/wr_ptr[2] , \F1/rd_addr[3] , \F1/N16 , \F1/N15 ,
         \F1/N14 , \CB2/n18 , \CB2/n17 , \CB2/n16 , \CB2/n15 , \CB2/n14 ,
         \CB2/n13 , \CB2/n12 , \CB2/n11 , \CB2/n10 , \CB2/n9 , \CB2/n8 ,
         \CB2/n7 , \CB2/n6 , \CB2/n5 , \CB2/n4 , \CB2/n3 , \CB2/n1 ,
         \CB2/ram_write_ns[1] , \CB2/ram_write_ns[0] , \CB2/ram_write_ps[0] ,
         \CB2/ram_write_ps[1] , \CB2/byte_cnt_ns[2] , \CB2/byte_cnt_ns[1] ,
         \CB2/byte_cnt_ns[0] , \CB2/byte_cnt_ps[0] , \CB2/byte_cnt_ps[1] ,
         \CB2/byte_cnt_ps[2] , \CB2/read_ns , n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19;
  wire   [7:0] parallel_data;
  tri   clk_2;
  tri   reset_n;
  tri   [7:0] ram_data;
  tri   [10:0] ram_addr;
  tri   rd_fifo;
  tri   [7:0] fifo_data;
  tri   zero_sel;
  tri   ram_ena;
  wire   SYNOPSYS_UNCONNECTED__0;

  averager A1 ( .fifo_data(fifo_data), .zero_sel(zero_sel), .rd_fifo(rd_fifo), 
        .clk_2(clk_2), .reset_n(reset_n), .acc_out({SYNOPSYS_UNCONNECTED__0, 
        ram_data}) );
  ram_addresser RA1 ( .clk_2(clk_2), .reset_n(reset_n), .ram_ena(ram_ena), 
        .ram_addr(ram_addr) );
  INVX0 \S1/U10  ( .IN(n10), .QN(\S1/n1 ) );
  AO22X1 \S1/U9  ( .IN1(serial_data), .IN2(n10), .IN3(n13), .IN4(\S1/n1 ), .Q(
        \S1/n9 ) );
  AO22X1 \S1/U8  ( .IN1(n13), .IN2(n10), .IN3(n14), .IN4(\S1/n1 ), .Q(\S1/n8 )
         );
  AO22X1 \S1/U7  ( .IN1(n14), .IN2(n10), .IN3(n15), .IN4(\S1/n1 ), .Q(\S1/n7 )
         );
  AO22X1 \S1/U6  ( .IN1(n15), .IN2(n10), .IN3(n16), .IN4(\S1/n1 ), .Q(\S1/n6 )
         );
  AO22X1 \S1/U5  ( .IN1(n16), .IN2(n10), .IN3(n17), .IN4(\S1/n1 ), .Q(\S1/n5 )
         );
  AO22X1 \S1/U4  ( .IN1(n17), .IN2(n10), .IN3(n18), .IN4(\S1/n1 ), .Q(\S1/n4 )
         );
  AO22X1 \S1/U3  ( .IN1(n18), .IN2(n10), .IN3(n19), .IN4(\S1/n1 ), .Q(\S1/n3 )
         );
  AO22X1 \S1/U2  ( .IN1(n19), .IN2(n10), .IN3(parallel_data[0]), .IN4(\S1/n1 ), 
        .Q(\S1/n2 ) );
  DFFARX1 \CB50/packet_type_ps_reg  ( .D(\CB50/packet_type_ns ), .CLK(clk_50), 
        .RSTB(reset_n), .Q(\CB50/packet_type_ps ), .QN(\CB50/n2 ) );
  DFFARX1 \CB50/data_type_ps_reg[2]  ( .D(\CB50/data_type_ns[2] ), .CLK(clk_50), .RSTB(reset_n), .Q(\CB50/data_type_ps[2] ), .QN(\CB50/n4 ) );
  DFFARX1 \CB50/data_type_ps_reg[1]  ( .D(\CB50/data_type_ns[1] ), .CLK(clk_50), .RSTB(reset_n), .Q(\CB50/data_type_ps[1] ), .QN(\CB50/n5 ) );
  DFFARX1 \CB50/data_type_ps_reg[0]  ( .D(\CB50/data_type_ns[0] ), .CLK(clk_50), .RSTB(reset_n), .Q(\CB50/data_type_ps[0] ), .QN(\CB50/n6 ) );
  XNOR2X1 \F1/U115  ( .IN1(\F1/rd_addr[3] ), .IN2(\F1/wr_addr[3] ), .Q(
        \F1/n37 ) );
  XOR2X1 \F1/U114  ( .IN1(\F1/wr_ptr[2] ), .IN2(\F1/n44 ), .Q(\F1/n39 ) );
  XOR2X1 \F1/U113  ( .IN1(\F1/wr_ptr[1] ), .IN2(\F1/n45 ), .Q(\F1/n40 ) );
  XOR2X1 \F1/U112  ( .IN1(\F1/wr_ptr[0] ), .IN2(\F1/n46 ), .Q(\F1/n41 ) );
  AND3X1 \F1/U111  ( .IN1(\F1/n39 ), .IN2(\F1/n40 ), .IN3(\F1/n41 ), .Q(
        \F1/n35 ) );
  NAND2X0 \F1/U110  ( .IN1(\F1/n37 ), .IN2(\F1/n35 ), .QN(\F1/n38 ) );
  NAND2X0 \F1/U109  ( .IN1(\F1/n42 ), .IN2(\F1/n38 ), .QN(fifo_empty) );
  INVX0 \F1/U108  ( .IN(\F1/n38 ), .QN(\F1/empty_cmp ) );
  NOR2X0 \F1/U100  ( .IN1(\F1/n10 ), .IN2(\F1/wr_ptr[0] ), .QN(\F1/n11 ) );
  INVX0 \F1/U98  ( .IN(\F1/n32 ), .QN(\F1/n33 ) );
  AO22X1 \F1/U97  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][0] ), .IN3(\F1/n33 ), 
        .IN4(parallel_data[0]), .Q(\F1/n118 ) );
  AO22X1 \F1/U96  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][1] ), .IN3(\F1/n33 ), 
        .IN4(n19), .Q(\F1/n117 ) );
  AO22X1 \F1/U95  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][2] ), .IN3(\F1/n33 ), 
        .IN4(n18), .Q(\F1/n116 ) );
  AO22X1 \F1/U94  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][3] ), .IN3(\F1/n33 ), 
        .IN4(n17), .Q(\F1/n115 ) );
  AO22X1 \F1/U93  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][4] ), .IN3(\F1/n33 ), 
        .IN4(n16), .Q(\F1/n114 ) );
  AO22X1 \F1/U92  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][5] ), .IN3(\F1/n33 ), 
        .IN4(n15), .Q(\F1/n113 ) );
  AO22X1 \F1/U91  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][6] ), .IN3(\F1/n33 ), 
        .IN4(n14), .Q(\F1/n112 ) );
  AO22X1 \F1/U90  ( .IN1(\F1/n32 ), .IN2(\F1/memory[0][7] ), .IN3(\F1/n33 ), 
        .IN4(n13), .Q(\F1/n111 ) );
  NAND2X0 \F1/U89  ( .IN1(\F1/wr_ptr[0] ), .IN2(wr_fifo), .QN(\F1/n9 ) );
  INVX0 \F1/U88  ( .IN(\F1/n9 ), .QN(\F1/n23 ) );
  INVX0 \F1/U86  ( .IN(\F1/n30 ), .QN(\F1/n31 ) );
  AO22X1 \F1/U85  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][0] ), .IN3(\F1/n31 ), 
        .IN4(parallel_data[0]), .Q(\F1/n110 ) );
  AO22X1 \F1/U84  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][1] ), .IN3(\F1/n31 ), 
        .IN4(n19), .Q(\F1/n109 ) );
  AO22X1 \F1/U83  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][2] ), .IN3(\F1/n31 ), 
        .IN4(n18), .Q(\F1/n108 ) );
  AO22X1 \F1/U82  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][3] ), .IN3(\F1/n31 ), 
        .IN4(n17), .Q(\F1/n107 ) );
  AO22X1 \F1/U81  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][4] ), .IN3(\F1/n31 ), 
        .IN4(n16), .Q(\F1/n106 ) );
  AO22X1 \F1/U80  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][5] ), .IN3(\F1/n31 ), 
        .IN4(n15), .Q(\F1/n105 ) );
  AO22X1 \F1/U79  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][6] ), .IN3(\F1/n31 ), 
        .IN4(n14), .Q(\F1/n104 ) );
  AO22X1 \F1/U78  ( .IN1(\F1/n30 ), .IN2(\F1/memory[1][7] ), .IN3(\F1/n31 ), 
        .IN4(n13), .Q(\F1/n103 ) );
  INVX0 \F1/U76  ( .IN(\F1/n28 ), .QN(\F1/n29 ) );
  AO22X1 \F1/U75  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][0] ), .IN3(\F1/n29 ), 
        .IN4(parallel_data[0]), .Q(\F1/n102 ) );
  AO22X1 \F1/U74  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][1] ), .IN3(\F1/n29 ), 
        .IN4(n19), .Q(\F1/n101 ) );
  AO22X1 \F1/U73  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][2] ), .IN3(\F1/n29 ), 
        .IN4(n18), .Q(\F1/n100 ) );
  AO22X1 \F1/U72  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][3] ), .IN3(\F1/n29 ), 
        .IN4(n17), .Q(\F1/n99 ) );
  AO22X1 \F1/U71  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][4] ), .IN3(\F1/n29 ), 
        .IN4(n16), .Q(\F1/n98 ) );
  AO22X1 \F1/U70  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][5] ), .IN3(\F1/n29 ), 
        .IN4(n15), .Q(\F1/n97 ) );
  AO22X1 \F1/U69  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][6] ), .IN3(\F1/n29 ), 
        .IN4(n14), .Q(\F1/n96 ) );
  AO22X1 \F1/U68  ( .IN1(\F1/n28 ), .IN2(\F1/memory[2][7] ), .IN3(\F1/n29 ), 
        .IN4(n13), .Q(\F1/n95 ) );
  NAND2X0 \F1/U67  ( .IN1(\F1/wr_ptr[1] ), .IN2(\F1/n23 ), .QN(\F1/n6 ) );
  INVX0 \F1/U66  ( .IN(\F1/n6 ), .QN(\F1/n18 ) );
  AO22X1 \F1/U63  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][0] ), .IN3(\F1/n7 ), 
        .IN4(parallel_data[0]), .Q(\F1/n94 ) );
  AO22X1 \F1/U62  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][1] ), .IN3(\F1/n7 ), 
        .IN4(n19), .Q(\F1/n93 ) );
  AO22X1 \F1/U61  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][2] ), .IN3(\F1/n7 ), 
        .IN4(n18), .Q(\F1/n92 ) );
  AO22X1 \F1/U60  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][3] ), .IN3(\F1/n7 ), 
        .IN4(n17), .Q(\F1/n91 ) );
  AO22X1 \F1/U59  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][4] ), .IN3(\F1/n7 ), 
        .IN4(n16), .Q(\F1/n90 ) );
  AO22X1 \F1/U58  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][5] ), .IN3(\F1/n7 ), 
        .IN4(n15), .Q(\F1/n89 ) );
  AO22X1 \F1/U57  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][6] ), .IN3(\F1/n7 ), 
        .IN4(n14), .Q(\F1/n88 ) );
  AO22X1 \F1/U56  ( .IN1(\F1/n26 ), .IN2(\F1/memory[3][7] ), .IN3(\F1/n7 ), 
        .IN4(n13), .Q(\F1/n87 ) );
  INVX0 \F1/U54  ( .IN(\F1/n24 ), .QN(\F1/n25 ) );
  AO22X1 \F1/U53  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][0] ), .IN3(\F1/n25 ), 
        .IN4(parallel_data[0]), .Q(\F1/n86 ) );
  AO22X1 \F1/U52  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][1] ), .IN3(\F1/n25 ), 
        .IN4(n19), .Q(\F1/n85 ) );
  AO22X1 \F1/U51  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][2] ), .IN3(\F1/n25 ), 
        .IN4(n18), .Q(\F1/n84 ) );
  AO22X1 \F1/U50  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][3] ), .IN3(\F1/n25 ), 
        .IN4(n17), .Q(\F1/n83 ) );
  AO22X1 \F1/U49  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][4] ), .IN3(\F1/n25 ), 
        .IN4(n16), .Q(\F1/n82 ) );
  AO22X1 \F1/U48  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][5] ), .IN3(\F1/n25 ), 
        .IN4(n15), .Q(\F1/n81 ) );
  AO22X1 \F1/U47  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][6] ), .IN3(\F1/n25 ), 
        .IN4(n14), .Q(\F1/n80 ) );
  AO22X1 \F1/U46  ( .IN1(\F1/n24 ), .IN2(\F1/memory[4][7] ), .IN3(\F1/n25 ), 
        .IN4(n13), .Q(\F1/n79 ) );
  INVX0 \F1/U44  ( .IN(\F1/n21 ), .QN(\F1/n22 ) );
  AO22X1 \F1/U43  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][0] ), .IN3(\F1/n22 ), 
        .IN4(parallel_data[0]), .Q(\F1/n78 ) );
  AO22X1 \F1/U42  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][1] ), .IN3(\F1/n22 ), 
        .IN4(n19), .Q(\F1/n77 ) );
  AO22X1 \F1/U41  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][2] ), .IN3(\F1/n22 ), 
        .IN4(n18), .Q(\F1/n76 ) );
  AO22X1 \F1/U40  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][3] ), .IN3(\F1/n22 ), 
        .IN4(n17), .Q(\F1/n75 ) );
  AO22X1 \F1/U39  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][4] ), .IN3(\F1/n22 ), 
        .IN4(n16), .Q(\F1/n74 ) );
  AO22X1 \F1/U38  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][5] ), .IN3(\F1/n22 ), 
        .IN4(n15), .Q(\F1/n73 ) );
  AO22X1 \F1/U37  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][6] ), .IN3(\F1/n22 ), 
        .IN4(n14), .Q(\F1/n72 ) );
  AO22X1 \F1/U36  ( .IN1(\F1/n21 ), .IN2(\F1/memory[5][7] ), .IN3(\F1/n22 ), 
        .IN4(n13), .Q(\F1/n71 ) );
  INVX0 \F1/U34  ( .IN(\F1/n19 ), .QN(\F1/n20 ) );
  AO22X1 \F1/U33  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][0] ), .IN3(\F1/n20 ), 
        .IN4(parallel_data[0]), .Q(\F1/n70 ) );
  AO22X1 \F1/U32  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][1] ), .IN3(\F1/n20 ), 
        .IN4(n19), .Q(\F1/n69 ) );
  AO22X1 \F1/U31  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][2] ), .IN3(\F1/n20 ), 
        .IN4(n18), .Q(\F1/n68 ) );
  AO22X1 \F1/U30  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][3] ), .IN3(\F1/n20 ), 
        .IN4(n17), .Q(\F1/n67 ) );
  AO22X1 \F1/U29  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][4] ), .IN3(\F1/n20 ), 
        .IN4(n16), .Q(\F1/n66 ) );
  AO22X1 \F1/U28  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][5] ), .IN3(\F1/n20 ), 
        .IN4(n15), .Q(\F1/n65 ) );
  AO22X1 \F1/U27  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][6] ), .IN3(\F1/n20 ), 
        .IN4(n14), .Q(\F1/n64 ) );
  AO22X1 \F1/U26  ( .IN1(\F1/n19 ), .IN2(\F1/memory[6][7] ), .IN3(\F1/n20 ), 
        .IN4(n13), .Q(\F1/n63 ) );
  AO22X1 \F1/U23  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][0] ), .IN3(
        parallel_data[0]), .IN4(\F1/n5 ), .Q(\F1/n62 ) );
  AO22X1 \F1/U22  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][1] ), .IN3(n19), .IN4(
        \F1/n5 ), .Q(\F1/n61 ) );
  AO22X1 \F1/U21  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][2] ), .IN3(n18), .IN4(
        \F1/n5 ), .Q(\F1/n60 ) );
  AO22X1 \F1/U20  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][3] ), .IN3(n17), .IN4(
        \F1/n5 ), .Q(\F1/n59 ) );
  AO22X1 \F1/U19  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][4] ), .IN3(n16), .IN4(
        \F1/n5 ), .Q(\F1/n58 ) );
  AO22X1 \F1/U18  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][5] ), .IN3(n15), .IN4(
        \F1/n5 ), .Q(\F1/n57 ) );
  AO22X1 \F1/U17  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][6] ), .IN3(n14), .IN4(
        \F1/n5 ), .Q(\F1/n56 ) );
  AO22X1 \F1/U16  ( .IN1(\F1/n17 ), .IN2(\F1/memory[7][7] ), .IN3(n13), .IN4(
        \F1/n5 ), .Q(\F1/n55 ) );
  XOR2X1 \F1/U14  ( .IN1(\F1/N14 ), .IN2(rd_fifo), .Q(\F1/n54 ) );
  NAND2X0 \F1/U13  ( .IN1(rd_fifo), .IN2(\F1/N14 ), .QN(\F1/n15 ) );
  XOR2X1 \F1/U12  ( .IN1(\F1/n15 ), .IN2(\F1/n45 ), .Q(\F1/n53 ) );
  NOR2X0 \F1/U11  ( .IN1(\F1/n15 ), .IN2(\F1/n45 ), .QN(\F1/n13 ) );
  XOR2X1 \F1/U9  ( .IN1(\F1/n13 ), .IN2(\F1/N16 ), .Q(\F1/n52 ) );
  NAND2X0 \F1/U8  ( .IN1(\F1/n13 ), .IN2(\F1/N16 ), .QN(\F1/n12 ) );
  XNOR2X1 \F1/U7  ( .IN1(\F1/rd_addr[3] ), .IN2(\F1/n12 ), .Q(\F1/n51 ) );
  AO21X1 \F1/U6  ( .IN1(\F1/wr_ptr[0] ), .IN2(\F1/n10 ), .IN3(\F1/n11 ), .Q(
        \F1/n50 ) );
  XOR2X1 \F1/U5  ( .IN1(\F1/n8 ), .IN2(\F1/n9 ), .Q(\F1/n49 ) );
  AO21X1 \F1/U4  ( .IN1(\F1/wr_ptr[2] ), .IN2(\F1/n6 ), .IN3(\F1/n7 ), .Q(
        \F1/n48 ) );
  XOR2X1 \F1/U3  ( .IN1(\F1/wr_addr[3] ), .IN2(\F1/n5 ), .Q(\F1/n47 ) );
  DFFASX1 \F1/empty_sync_reg  ( .D(\F1/empty_cmp ), .CLK(clk_2), .SETB(reset_n), .QN(\F1/n42 ) );
  DFFARX1 \F1/wr_addr_reg[3]  ( .D(\F1/n47 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/wr_addr[3] ) );
  DFFARX1 \F1/memory_reg[3][0]  ( .D(\F1/n94 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][0] ) );
  DFFARX1 \F1/memory_reg[3][1]  ( .D(\F1/n93 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][1] ) );
  DFFARX1 \F1/memory_reg[3][2]  ( .D(\F1/n92 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][2] ) );
  DFFARX1 \F1/memory_reg[3][3]  ( .D(\F1/n91 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][3] ) );
  DFFARX1 \F1/memory_reg[3][4]  ( .D(\F1/n90 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][4] ) );
  DFFARX1 \F1/memory_reg[3][5]  ( .D(\F1/n89 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][5] ) );
  DFFARX1 \F1/memory_reg[3][6]  ( .D(\F1/n88 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][6] ) );
  DFFARX1 \F1/memory_reg[3][7]  ( .D(\F1/n87 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[3][7] ) );
  DFFARX1 \F1/memory_reg[7][0]  ( .D(\F1/n62 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][0] ) );
  DFFARX1 \F1/memory_reg[7][1]  ( .D(\F1/n61 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][1] ) );
  DFFARX1 \F1/memory_reg[7][2]  ( .D(\F1/n60 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][2] ) );
  DFFARX1 \F1/rd_addr_reg[3]  ( .D(\F1/n51 ), .CLK(clk_2), .RSTB(reset_n), .Q(
        \F1/rd_addr[3] ) );
  DFFARX1 \CB2/ram_write_ps_reg[0]  ( .D(\CB2/ram_write_ns[0] ), .CLK(clk_2), 
        .RSTB(reset_n), .Q(\CB2/ram_write_ps[0] ) );
  DFFASX1 \CB2/byte_cnt_ps_reg[0]  ( .D(\CB2/byte_cnt_ns[0] ), .CLK(clk_2), 
        .SETB(reset_n), .Q(\CB2/byte_cnt_ps[0] ), .QN(\CB2/n6 ) );
  DFFARX1 \CB2/read_ps_reg  ( .D(\CB2/read_ns ), .CLK(clk_2), .RSTB(reset_n), 
        .Q(rd_fifo) );
  MUX41X1 \F1/U137  ( .IN1(\F1/memory[4][7] ), .IN3(\F1/memory[6][7] ), .IN2(
        \F1/memory[5][7] ), .IN4(\F1/memory[7][7] ), .S0(n12), .S1(n11), .Q(
        \F1/n133 ) );
  MUX41X1 \F1/U138  ( .IN1(\F1/memory[0][7] ), .IN3(\F1/memory[2][7] ), .IN2(
        \F1/memory[1][7] ), .IN4(\F1/memory[3][7] ), .S0(n12), .S1(n11), .Q(
        \F1/n134 ) );
  MUX21X1 \F1/U139  ( .IN1(\F1/n134 ), .IN2(\F1/n133 ), .S(\F1/N16 ), .Q(
        fifo_data[7]) );
  MUX41X1 \F1/U134  ( .IN1(\F1/memory[4][6] ), .IN3(\F1/memory[6][6] ), .IN2(
        \F1/memory[5][6] ), .IN4(\F1/memory[7][6] ), .S0(n12), .S1(n11), .Q(
        \F1/n131 ) );
  MUX41X1 \F1/U135  ( .IN1(\F1/memory[0][6] ), .IN3(\F1/memory[2][6] ), .IN2(
        \F1/memory[1][6] ), .IN4(\F1/memory[3][6] ), .S0(n12), .S1(n11), .Q(
        \F1/n132 ) );
  MUX21X1 \F1/U136  ( .IN1(\F1/n132 ), .IN2(\F1/n131 ), .S(\F1/N16 ), .Q(
        fifo_data[6]) );
  MUX41X1 \F1/U131  ( .IN1(\F1/memory[4][5] ), .IN3(\F1/memory[6][5] ), .IN2(
        \F1/memory[5][5] ), .IN4(\F1/memory[7][5] ), .S0(n12), .S1(n11), .Q(
        \F1/n129 ) );
  MUX41X1 \F1/U132  ( .IN1(\F1/memory[0][5] ), .IN3(\F1/memory[2][5] ), .IN2(
        \F1/memory[1][5] ), .IN4(\F1/memory[3][5] ), .S0(n12), .S1(n11), .Q(
        \F1/n130 ) );
  MUX21X1 \F1/U133  ( .IN1(\F1/n130 ), .IN2(\F1/n129 ), .S(\F1/N16 ), .Q(
        fifo_data[5]) );
  MUX41X1 \F1/U128  ( .IN1(\F1/memory[4][4] ), .IN3(\F1/memory[6][4] ), .IN2(
        \F1/memory[5][4] ), .IN4(\F1/memory[7][4] ), .S0(n12), .S1(n11), .Q(
        \F1/n127 ) );
  MUX41X1 \F1/U129  ( .IN1(\F1/memory[0][4] ), .IN3(\F1/memory[2][4] ), .IN2(
        \F1/memory[1][4] ), .IN4(\F1/memory[3][4] ), .S0(n12), .S1(n11), .Q(
        \F1/n128 ) );
  MUX21X1 \F1/U130  ( .IN1(\F1/n128 ), .IN2(\F1/n127 ), .S(\F1/N16 ), .Q(
        fifo_data[4]) );
  MUX41X1 \F1/U125  ( .IN1(\F1/memory[4][3] ), .IN3(\F1/memory[6][3] ), .IN2(
        \F1/memory[5][3] ), .IN4(\F1/memory[7][3] ), .S0(n12), .S1(n11), .Q(
        \F1/n125 ) );
  MUX41X1 \F1/U126  ( .IN1(\F1/memory[0][3] ), .IN3(\F1/memory[2][3] ), .IN2(
        \F1/memory[1][3] ), .IN4(\F1/memory[3][3] ), .S0(n12), .S1(n11), .Q(
        \F1/n126 ) );
  MUX21X1 \F1/U127  ( .IN1(\F1/n126 ), .IN2(\F1/n125 ), .S(\F1/N16 ), .Q(
        fifo_data[3]) );
  MUX41X1 \F1/U122  ( .IN1(\F1/memory[4][2] ), .IN3(\F1/memory[6][2] ), .IN2(
        \F1/memory[5][2] ), .IN4(\F1/memory[7][2] ), .S0(n12), .S1(n11), .Q(
        \F1/n123 ) );
  MUX41X1 \F1/U123  ( .IN1(\F1/memory[0][2] ), .IN3(\F1/memory[2][2] ), .IN2(
        \F1/memory[1][2] ), .IN4(\F1/memory[3][2] ), .S0(n12), .S1(n11), .Q(
        \F1/n124 ) );
  MUX21X1 \F1/U124  ( .IN1(\F1/n124 ), .IN2(\F1/n123 ), .S(\F1/N16 ), .Q(
        fifo_data[2]) );
  MUX41X1 \F1/U119  ( .IN1(\F1/memory[4][1] ), .IN3(\F1/memory[6][1] ), .IN2(
        \F1/memory[5][1] ), .IN4(\F1/memory[7][1] ), .S0(n12), .S1(n11), .Q(
        \F1/n121 ) );
  MUX41X1 \F1/U120  ( .IN1(\F1/memory[0][1] ), .IN3(\F1/memory[2][1] ), .IN2(
        \F1/memory[1][1] ), .IN4(\F1/memory[3][1] ), .S0(n12), .S1(n11), .Q(
        \F1/n122 ) );
  MUX21X1 \F1/U121  ( .IN1(\F1/n122 ), .IN2(\F1/n121 ), .S(\F1/N16 ), .Q(
        fifo_data[1]) );
  MUX41X1 \F1/U116  ( .IN1(\F1/memory[4][0] ), .IN3(\F1/memory[6][0] ), .IN2(
        \F1/memory[5][0] ), .IN4(\F1/memory[7][0] ), .S0(n12), .S1(n11), .Q(
        \F1/n119 ) );
  MUX41X1 \F1/U117  ( .IN1(\F1/memory[0][0] ), .IN3(\F1/memory[2][0] ), .IN2(
        \F1/memory[1][0] ), .IN4(\F1/memory[3][0] ), .S0(n12), .S1(n11), .Q(
        \F1/n120 ) );
  MUX21X1 \F1/U118  ( .IN1(\F1/n120 ), .IN2(\F1/n119 ), .S(\F1/N16 ), .Q(
        fifo_data[0]) );
  DFFARX1 \CB2/ram_write_ps_reg[1]  ( .D(\CB2/ram_write_ns[1] ), .CLK(clk_2), 
        .RSTB(reset_n), .Q(\CB2/ram_write_ps[1] ), .QN(\CB2/n7 ) );
  DFFARX1 \F1/rd_addr_reg[0]  ( .D(\F1/n54 ), .CLK(clk_2), .RSTB(reset_n), .Q(
        \F1/N14 ), .QN(\F1/n46 ) );
  DFFARX1 \F1/rd_addr_reg[1]  ( .D(\F1/n53 ), .CLK(clk_2), .RSTB(reset_n), .Q(
        \F1/N15 ), .QN(\F1/n45 ) );
  DFFARX1 \F1/rd_addr_reg[2]  ( .D(\F1/n52 ), .CLK(clk_2), .RSTB(reset_n), .Q(
        \F1/N16 ), .QN(\F1/n44 ) );
  DFFARX1 \CB2/byte_cnt_ps_reg[2]  ( .D(\CB2/byte_cnt_ns[2] ), .CLK(clk_2), 
        .RSTB(reset_n), .Q(\CB2/byte_cnt_ps[2] ), .QN(\CB2/n4 ) );
  DFFARX1 \CB2/byte_cnt_ps_reg[1]  ( .D(\CB2/byte_cnt_ns[1] ), .CLK(clk_2), 
        .RSTB(reset_n), .Q(\CB2/byte_cnt_ps[1] ), .QN(\CB2/n5 ) );
  DFFARX1 \CB50/detect_ps_reg  ( .D(data_ena), .CLK(clk_50), .RSTB(reset_n), 
        .QN(n9) );
  DFFARX1 \F1/wr_addr_reg[1]  ( .D(\F1/n49 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/wr_ptr[1] ), .QN(\F1/n8 ) );
  DFFARX1 \F1/wr_addr_reg[0]  ( .D(\F1/n50 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/wr_ptr[0] ) );
  DFFARX1 \F1/memory_reg[5][7]  ( .D(\F1/n71 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][7] ) );
  DFFARX1 \F1/memory_reg[5][6]  ( .D(\F1/n72 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][6] ) );
  DFFARX1 \F1/memory_reg[5][5]  ( .D(\F1/n73 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][5] ) );
  DFFARX1 \F1/memory_reg[5][4]  ( .D(\F1/n74 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][4] ) );
  DFFARX1 \F1/memory_reg[5][3]  ( .D(\F1/n75 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][3] ) );
  DFFARX1 \F1/memory_reg[5][2]  ( .D(\F1/n76 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][2] ) );
  DFFARX1 \F1/memory_reg[5][1]  ( .D(\F1/n77 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][1] ) );
  DFFARX1 \F1/memory_reg[5][0]  ( .D(\F1/n78 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[5][0] ) );
  DFFARX1 \F1/memory_reg[1][7]  ( .D(\F1/n103 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][7] ) );
  DFFARX1 \F1/memory_reg[1][6]  ( .D(\F1/n104 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][6] ) );
  DFFARX1 \F1/memory_reg[1][5]  ( .D(\F1/n105 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][5] ) );
  DFFARX1 \F1/memory_reg[1][4]  ( .D(\F1/n106 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][4] ) );
  DFFARX1 \F1/memory_reg[1][3]  ( .D(\F1/n107 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][3] ) );
  DFFARX1 \F1/memory_reg[1][2]  ( .D(\F1/n108 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][2] ) );
  DFFARX1 \F1/memory_reg[1][1]  ( .D(\F1/n109 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][1] ) );
  DFFARX1 \F1/memory_reg[1][0]  ( .D(\F1/n110 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[1][0] ) );
  DFFARX1 \F1/memory_reg[6][7]  ( .D(\F1/n63 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][7] ) );
  DFFARX1 \F1/memory_reg[6][6]  ( .D(\F1/n64 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][6] ) );
  DFFARX1 \F1/memory_reg[6][5]  ( .D(\F1/n65 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][5] ) );
  DFFARX1 \F1/memory_reg[6][4]  ( .D(\F1/n66 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][4] ) );
  DFFARX1 \F1/memory_reg[6][3]  ( .D(\F1/n67 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][3] ) );
  DFFARX1 \F1/memory_reg[6][2]  ( .D(\F1/n68 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][2] ) );
  DFFARX1 \F1/memory_reg[6][1]  ( .D(\F1/n69 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][1] ) );
  DFFARX1 \F1/memory_reg[6][0]  ( .D(\F1/n70 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[6][0] ) );
  DFFARX1 \F1/memory_reg[4][7]  ( .D(\F1/n79 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][7] ) );
  DFFARX1 \F1/memory_reg[4][6]  ( .D(\F1/n80 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][6] ) );
  DFFARX1 \F1/memory_reg[4][5]  ( .D(\F1/n81 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][5] ) );
  DFFARX1 \F1/memory_reg[4][4]  ( .D(\F1/n82 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][4] ) );
  DFFARX1 \F1/memory_reg[4][3]  ( .D(\F1/n83 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][3] ) );
  DFFARX1 \F1/memory_reg[4][2]  ( .D(\F1/n84 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][2] ) );
  DFFARX1 \F1/memory_reg[4][1]  ( .D(\F1/n85 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][1] ) );
  DFFARX1 \F1/memory_reg[4][0]  ( .D(\F1/n86 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[4][0] ) );
  DFFARX1 \F1/memory_reg[2][7]  ( .D(\F1/n95 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][7] ) );
  DFFARX1 \F1/memory_reg[2][6]  ( .D(\F1/n96 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][6] ) );
  DFFARX1 \F1/memory_reg[2][5]  ( .D(\F1/n97 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][5] ) );
  DFFARX1 \F1/memory_reg[2][4]  ( .D(\F1/n98 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][4] ) );
  DFFARX1 \F1/memory_reg[2][3]  ( .D(\F1/n99 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][3] ) );
  DFFARX1 \F1/memory_reg[2][2]  ( .D(\F1/n100 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][2] ) );
  DFFARX1 \F1/memory_reg[2][1]  ( .D(\F1/n101 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][1] ) );
  DFFARX1 \F1/memory_reg[2][0]  ( .D(\F1/n102 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[2][0] ) );
  DFFARX1 \F1/memory_reg[0][7]  ( .D(\F1/n111 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][7] ) );
  DFFARX1 \F1/memory_reg[0][6]  ( .D(\F1/n112 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][6] ) );
  DFFARX1 \F1/memory_reg[0][5]  ( .D(\F1/n113 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][5] ) );
  DFFARX1 \F1/memory_reg[0][4]  ( .D(\F1/n114 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][4] ) );
  DFFARX1 \F1/memory_reg[0][3]  ( .D(\F1/n115 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][3] ) );
  DFFARX1 \F1/memory_reg[0][2]  ( .D(\F1/n116 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][2] ) );
  DFFARX1 \F1/memory_reg[0][1]  ( .D(\F1/n117 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][1] ) );
  DFFARX1 \F1/memory_reg[0][0]  ( .D(\F1/n118 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[0][0] ) );
  DFFARX1 \CB50/write_ps_reg  ( .D(\CB50/write_ns ), .CLK(clk_50), .RSTB(
        reset_n), .Q(wr_fifo), .QN(\F1/n10 ) );
  DFFARX1 \S1/parallel_data_reg[7]  ( .D(\S1/n9 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[7]) );
  DFFARX1 \S1/parallel_data_reg[6]  ( .D(\S1/n8 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[6]), .QN(n8) );
  DFFARX1 \S1/parallel_data_reg[5]  ( .D(\S1/n7 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[5]) );
  DFFARX1 \S1/parallel_data_reg[4]  ( .D(\S1/n6 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[4]) );
  DFFARX1 \S1/parallel_data_reg[3]  ( .D(\S1/n5 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[3]) );
  DFFARX1 \S1/parallel_data_reg[2]  ( .D(\S1/n4 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[2]) );
  DFFARX1 \S1/parallel_data_reg[1]  ( .D(\S1/n3 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[1]), .QN(n7) );
  DFFARX1 \S1/parallel_data_reg[0]  ( .D(\S1/n2 ), .CLK(clk_50), .RSTB(reset_n), .Q(parallel_data[0]) );
  DFFARX1 \F1/wr_addr_reg[2]  ( .D(\F1/n48 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/wr_ptr[2] ), .QN(\F1/n27 ) );
  DFFARX1 \F1/memory_reg[7][7]  ( .D(\F1/n55 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][7] ) );
  DFFARX1 \F1/memory_reg[7][6]  ( .D(\F1/n56 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][6] ) );
  DFFARX1 \F1/memory_reg[7][5]  ( .D(\F1/n57 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][5] ) );
  DFFARX1 \F1/memory_reg[7][4]  ( .D(\F1/n58 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][4] ) );
  DFFARX1 \F1/memory_reg[7][3]  ( .D(\F1/n59 ), .CLK(clk_50), .RSTB(reset_n), 
        .Q(\F1/memory[7][3] ) );
  INVX0 U8 ( .IN(\F1/n26 ), .QN(\F1/n7 ) );
  NAND2X0 U9 ( .IN1(\F1/n18 ), .IN2(\F1/n27 ), .QN(\F1/n26 ) );
  NAND3X0 U10 ( .IN1(\F1/n8 ), .IN2(\F1/n27 ), .IN3(\F1/n11 ), .QN(\F1/n32 )
         );
  NAND3X0 U11 ( .IN1(\F1/n8 ), .IN2(\F1/n27 ), .IN3(\F1/n23 ), .QN(\F1/n30 )
         );
  INVX0 U12 ( .IN(\F1/n17 ), .QN(\F1/n5 ) );
  NAND2X0 U13 ( .IN1(n5), .IN2(n6), .QN(n4) );
  NAND4X0 U14 ( .IN1(n15), .IN2(n18), .IN3(n7), .IN4(n8), .QN(n6) );
  OR4X1 U15 ( .IN1(n8), .IN2(n7), .IN3(n18), .IN4(n15), .Q(n5) );
  INVX0 U16 ( .IN(\CB2/n13 ), .QN(\CB2/n1 ) );
  INVX0 U17 ( .IN(\CB50/n8 ), .QN(\CB50/n1 ) );
  NOR2X0 U18 ( .IN1(n16), .IN2(n17), .QN(n3) );
  INVX0 U19 ( .IN(\CB50/n11 ), .QN(\CB50/n3 ) );
  INVX0 U20 ( .IN(\CB2/n14 ), .QN(\CB2/n3 ) );
  INVX0 U21 ( .IN(\CB2/n15 ), .QN(zero_sel) );
  NAND2X0 U22 ( .IN1(\F1/wr_ptr[2] ), .IN2(\F1/n18 ), .QN(\F1/n17 ) );
  NOR2X0 U23 ( .IN1(rd_fifo), .IN2(fifo_empty), .QN(\CB2/read_ns ) );
  NAND2X0 U24 ( .IN1(rd_fifo), .IN2(\CB2/n8 ), .QN(\CB2/n13 ) );
  INVX0 U25 ( .IN(fifo_empty), .QN(\CB2/n8 ) );
  OR2X1 U26 ( .IN1(n9), .IN2(n10), .Q(\CB50/n8 ) );
  NAND3X0 U27 ( .IN1(\F1/wr_ptr[2] ), .IN2(\F1/n8 ), .IN3(\F1/n11 ), .QN(
        \F1/n24 ) );
  NAND3X0 U28 ( .IN1(\F1/wr_ptr[2] ), .IN2(\F1/wr_ptr[1] ), .IN3(\F1/n11 ), 
        .QN(\F1/n19 ) );
  NAND3X0 U29 ( .IN1(\F1/wr_ptr[1] ), .IN2(\F1/n27 ), .IN3(\F1/n11 ), .QN(
        \F1/n28 ) );
  NAND3X0 U30 ( .IN1(\F1/n23 ), .IN2(\F1/n8 ), .IN3(\F1/wr_ptr[2] ), .QN(
        \F1/n21 ) );
  AO222X1 U31 ( .IN1(zero_sel), .IN2(\CB2/n1 ), .IN3(\CB2/n12 ), .IN4(
        \CB2/byte_cnt_ps[1] ), .IN5(\CB2/n3 ), .IN6(\CB2/n13 ), .Q(
        \CB2/byte_cnt_ns[1] ) );
  NOR2X0 U32 ( .IN1(\CB2/byte_cnt_ps[2] ), .IN2(\CB2/byte_cnt_ps[0] ), .QN(
        \CB2/n12 ) );
  AO22X1 U33 ( .IN1(\CB2/n16 ), .IN2(\CB2/n13 ), .IN3(\CB2/n17 ), .IN4(
        \CB2/n1 ), .Q(\CB2/byte_cnt_ns[0] ) );
  OA21X1 U34 ( .IN1(\CB2/n18 ), .IN2(\CB2/n10 ), .IN3(\CB2/n6 ), .Q(\CB2/n17 )
         );
  NAND2X0 U35 ( .IN1(\CB2/n15 ), .IN2(\CB2/n14 ), .QN(\CB2/n16 ) );
  NOR2X0 U36 ( .IN1(\CB2/byte_cnt_ps[2] ), .IN2(\CB2/n5 ), .QN(\CB2/n18 ) );
  AO22X1 U37 ( .IN1(\CB2/n3 ), .IN2(\CB2/n1 ), .IN3(\CB2/n11 ), .IN4(\CB2/n10 ), .Q(\CB2/byte_cnt_ns[2] ) );
  NOR2X0 U38 ( .IN1(\CB2/byte_cnt_ps[0] ), .IN2(\CB2/n1 ), .QN(\CB2/n11 ) );
  NOR2X0 U39 ( .IN1(\CB50/data_type_ps[2] ), .IN2(\CB50/n16 ), .QN(
        \CB50/data_type_ns[0] ) );
  XOR2X1 U40 ( .IN1(\CB50/n8 ), .IN2(\CB50/data_type_ps[0] ), .Q(\CB50/n16 )
         );
  NOR2X0 U41 ( .IN1(\CB50/data_type_ps[2] ), .IN2(\CB50/n14 ), .QN(
        \CB50/data_type_ns[1] ) );
  XOR2X1 U42 ( .IN1(\CB50/n15 ), .IN2(\CB50/data_type_ps[1] ), .Q(\CB50/n14 )
         );
  NAND2X0 U43 ( .IN1(\CB50/n1 ), .IN2(\CB50/data_type_ps[0] ), .QN(\CB50/n15 )
         );
  NBUFFX2 U44 ( .IN(parallel_data[6]), .Q(n14) );
  NBUFFX2 U45 ( .IN(parallel_data[1]), .Q(n19) );
  NBUFFX2 U46 ( .IN(data_ena), .Q(n10) );
  NOR4X0 U47 ( .IN1(wr_fifo), .IN2(\CB50/n3 ), .IN3(\CB50/n8 ), .IN4(\CB50/n2 ), .QN(\CB50/write_ns ) );
  NBUFFX2 U48 ( .IN(parallel_data[5]), .Q(n15) );
  NBUFFX2 U49 ( .IN(parallel_data[2]), .Q(n18) );
  NAND2X0 U50 ( .IN1(\CB50/n9 ), .IN2(\CB50/n10 ), .QN(\CB50/packet_type_ns )
         );
  NAND2X0 U51 ( .IN1(\CB50/packet_type_ps ), .IN2(\CB50/n11 ), .QN(\CB50/n9 )
         );
  NAND4X0 U52 ( .IN1(a5_or_c3), .IN2(\CB50/n3 ), .IN3(\CB50/n1 ), .IN4(
        \CB50/n2 ), .QN(\CB50/n10 ) );
  AND4X1 U53 ( .IN1(parallel_data[0]), .IN2(n13), .IN3(n3), .IN4(n4), .Q(
        a5_or_c3) );
  NAND2X0 U54 ( .IN1(\CB50/n12 ), .IN2(\CB50/n13 ), .QN(\CB50/data_type_ns[2] ) );
  NAND4X0 U55 ( .IN1(\CB50/n1 ), .IN2(\CB50/data_type_ps[0] ), .IN3(
        \CB50/data_type_ps[1] ), .IN4(\CB50/n4 ), .QN(\CB50/n12 ) );
  NAND4X0 U56 ( .IN1(\CB50/data_type_ps[2] ), .IN2(\CB50/n8 ), .IN3(\CB50/n6 ), 
        .IN4(\CB50/n5 ), .QN(\CB50/n13 ) );
  NAND3X0 U57 ( .IN1(\CB50/n5 ), .IN2(\CB50/n4 ), .IN3(\CB50/n6 ), .QN(
        \CB50/n11 ) );
  NBUFFX2 U58 ( .IN(parallel_data[3]), .Q(n17) );
  NBUFFX2 U59 ( .IN(parallel_data[4]), .Q(n16) );
  NBUFFX2 U60 ( .IN(parallel_data[7]), .Q(n13) );
  NAND2X0 U61 ( .IN1(\CB2/ram_write_ps[0] ), .IN2(\CB2/n7 ), .QN(ram_wr_n) );
  NOR2X0 U62 ( .IN1(\CB2/n4 ), .IN2(\CB2/byte_cnt_ps[1] ), .QN(\CB2/n10 ) );
  NAND3X0 U63 ( .IN1(\CB2/byte_cnt_ps[0] ), .IN2(\CB2/n4 ), .IN3(
        \CB2/byte_cnt_ps[1] ), .QN(\CB2/n14 ) );
  NAND3X0 U64 ( .IN1(\CB2/n5 ), .IN2(\CB2/n4 ), .IN3(\CB2/byte_cnt_ps[0] ), 
        .QN(\CB2/n15 ) );
  NOR4X0 U65 ( .IN1(\CB2/n9 ), .IN2(\CB2/byte_cnt_ps[0] ), .IN3(
        \CB2/ram_write_ps[1] ), .IN4(\CB2/ram_write_ps[0] ), .QN(
        \CB2/ram_write_ns[0] ) );
  NAND2X0 U66 ( .IN1(rd_fifo), .IN2(\CB2/n10 ), .QN(\CB2/n9 ) );
  AND2X1 U67 ( .IN1(\CB2/n7 ), .IN2(\CB2/ram_write_ps[0] ), .Q(
        \CB2/ram_write_ns[1] ) );
  NBUFFX2 U68 ( .IN(\F1/N14 ), .Q(n11) );
  NOR2X0 U69 ( .IN1(\CB2/ram_write_ps[0] ), .IN2(\CB2/n7 ), .QN(ram_ena) );
  NBUFFX2 U70 ( .IN(\F1/N15 ), .Q(n12) );
endmodule

