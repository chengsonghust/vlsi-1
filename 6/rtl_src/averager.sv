//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: Averager - basically an accumulator with output logical right shifted twice,
//                to provide the average of four values

module averager (
        input  [7:0] fifo_data,
        input  zero_sel,
        input  rd_fifo,
        input  clk_2,
        input  reset_n,
        output [8:0] acc_out
        );

// internal model of averager is basically an accumulator
// fifo_data is added to the output of an internal flip flop through
// the use of an internal adder. Synced to clk_2
//                         clk_2
//fifo_data ----- |---\  11   |       9
//              > + |-/-[D clk Q] --/-- acc_out
//            /-|___/               |
//            \---------------------/

// internal data is larger for allowing averaging
reg [10:0] data;

// acc_out is data/4, i.e. the average value
// since we have four data points this is basically "data >> 2"
assign acc_out = data[10:2];

always_ff @(posedge clk_2, negedge reset_n) begin
  if (!reset_n) begin
    data <= 0;
  end
  
  if (rd_fifo) begin
    data <= data + fifo_data;
  end
  
  // zero_sel is interpreted as resetting the accumulator and inputting data
  if (zero_sel) begin
    data <= fifo_data;
  end  
end

endmodule
