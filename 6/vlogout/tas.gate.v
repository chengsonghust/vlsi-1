
module tas ( clk_50, clk_2, reset_n, serial_data, data_ena, ram_wr_n, ram_data, 
        ram_addr );
  output [7:0] ram_data;
  output [10:0] ram_addr;
  input clk_50, clk_2, reset_n, serial_data, data_ena;
  output ram_wr_n;
  wire   n5, n6, n7, n8, n9, n10;
  tri   clk_50;
  tri   clk_2;
  tri   reset_n;
  tri   serial_data;
  tri   data_ena;
  tri   ram_wr_n;
  tri   [7:0] ram_data;
  tri   [10:0] ram_addr;
  tri   [7:0] parallel_data;
  tri   a5_or_c3;
  tri   wr_fifo;
  tri   rd_fifo;
  tri   [7:0] fifo_data;
  tri   fifo_empty;
  tri   zero_sel;
  tri   wr_ram;
  wire   SYNOPSYS_UNCONNECTED__0;

  shift_reg S1 ( .p1(clk_50), .p2(reset_n), .p3(data_ena), .p4(serial_data), 
        .p5(parallel_data) );
  ctrl_blk_50 CB50 ( .p1(a5_or_c3), .p2(data_ena), .p3(clk_50), .p4(reset_n), 
        .p5(wr_fifo) );
  fifo F1 ( .p1(clk_50), .p2(clk_2), .p3(reset_n), .p4(wr_fifo), .p5(rd_fifo), 
        .p6(parallel_data), .p7(fifo_data), .p8(fifo_empty) );
  ctrl_blk_2 CB2 ( .p1(fifo_empty), .p2(clk_2), .p3(reset_n), .p4(zero_sel), 
        .p5(rd_fifo), .p6(wr_ram) );
  averager A1 ( .p1(fifo_data), .p2(zero_sel), .p3(rd_fifo), .p4(clk_2), .p5(
        reset_n), .p6({SYNOPSYS_UNCONNECTED__0, ram_data}) );
  ram_addr_cntr RAC1 ( .p1(clk_2), .p2(reset_n), .p3(ram_wr_n), .p4(ram_addr)
         );
  DFFARX1 ram_ena_reg ( .D(wr_ram), .CLK(clk_2), .RSTB(reset_n), .Q(ram_wr_n)
         );
  OR2X1 C39 ( .IN1(n6), .IN2(n5), .Q(a5_or_c3) );
  NOR4X0 U9 ( .IN1(n7), .IN2(n8), .IN3(parallel_data[6]), .IN4(
        parallel_data[1]), .QN(n6) );
  NAND2X0 U10 ( .IN1(parallel_data[5]), .IN2(parallel_data[2]), .QN(n7) );
  NOR4X0 U11 ( .IN1(n9), .IN2(n8), .IN3(parallel_data[5]), .IN4(
        parallel_data[2]), .QN(n5) );
  NAND3X0 U12 ( .IN1(parallel_data[7]), .IN2(parallel_data[0]), .IN3(n10), 
        .QN(n8) );
  NOR2X0 U13 ( .IN1(parallel_data[4]), .IN2(parallel_data[3]), .QN(n10) );
  NAND2X0 U14 ( .IN1(parallel_data[6]), .IN2(parallel_data[1]), .QN(n9) );
endmodule

