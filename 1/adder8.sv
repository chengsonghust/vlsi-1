//-------------------------------------------------------------------
//8-bit ripple carry adder program
// author: Jordan Bayles
// module: adder8 (8-bit adder)
// course: ECE 474 (VLSI), HW #1
//   date: 4/16/2014
//-------------------------------------------------------------------

module adder8(
  input  [7:0]  a,       //data in a
  input  [7:0]  b,       //data in b
  output [7:0] sum_out,  //sum output
  output c_out           //carry output
  );

  wire [6:0] cx;

  fadder a1(
  .a         (a[0]),
  .b         (b[0]),
  .sum_out   (sum_out[0]),
  .c_out     (cx[0])
  );

   fadder a2(
  .a         (a[1]),
  .b         (b[1]),
  .cin       (cx[0]),
  .sum_out   (sum_out[1]),
  .c_out     (cx[1])
  );

  fadder a3(
  .a         (a[2]),
  .b         (b[2]),
  .cin       (cx[1]),
  .sum_out   (sum_out[2]),
  .c_out     (cx[2])
  );

  fadder a4(
  .a         (a[3]),
  .b         (b[3]),
  .cin       (cx[2]),
  .sum_out   (sum_out[3]),
  .c_out     (cx[3])
  );

  fadder a5(
  .a         (a[4]),
  .b         (b[4]),
  .cin       (cx[3]),
  .sum_out   (sum_out[4]),
  .c_out     (cx[4])
  );

  fadder a6(
  .a         (a[5]),
  .b         (b[5]),
  .cin       (cx[4]),
  .sum_out   (sum_out[5]),
  .c_out     (cx[4])
  );

  fadder a7(
  .a         (a[6]),
  .b         (b[6]),
  .cin       (cx[5]),
  .sum_out   (sum_out[6]),
  .c_out     (cx[6])
  );

  fadder a8(
  .a         (a[7]),
  .b         (b[7]),
  .cin       (cx[6]),
  .sum_out   (sum_out[7]),
  .c_out     (c_out)
  );

endmodule
