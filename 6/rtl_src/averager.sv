//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: Averager - basically an accumulator with output logical right shifted twice,
//                to provide the average of four values

module averager (
        input  data_in,
        input  restart,
        input  rd_fifo,
        input  clk,
        input  reset_n,
        output [8:0] acc_out
        );

// internal model of averager is basically an accumulator
// data_in is added to the output of an internal flip flop through
// the use of an internal adder. Synced to clk_2
//                         clk_2
//data_in ----- |---\  11   |       9
//              > + |-/-[D clk Q] --/-- acc_out
//            /-|___/               |
//            \---------------------/

// internal data is larger for allowing averaging
reg [10:0] data;

// acc_out is data/4, i.e. the average value
// since we have four data points this is basically "data >> 2"
assign acc_out = data[10:2];

always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    data <= 0;
  end
  
  if (rd_fifo) begin
    data <= data + data_in;
  end
  
  // restart is interpreted as resetting the accumulator and inputting data
  if (restart) begin
    data <= data_in;
  end  
end

endmodule
