//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: 50 MHz subsystem control system
//                Decides when to reset accumulator
//                Decides when to write to RAM
//                Decides when the accumulator reads from the FIFO

module ctrl_blk_2 (
        input empty_flag,
        input clk,
        input reset_n,
        
        output reg restart_avg,
        output reg rd_fifo,
        output reg wr_ram
        );

// reading the fifo into the averager
wire should_read = !empty_flag;

// how full is the averager?
reg [2:0] avgr_cnt_ps;

// is the averager full?
wire avgr_full = (avgr_cnt_ps == 4);

// restart the averager if we are full and should read
wire avgr_restart = (should_read & avgr_full);

// writing to RAM
wire ram_write = avgr_full;

// if averager full, start over, otherwise increment
wire [2:0] avgr_cnt_ns = avgr_full ? 0 : avgr_cnt_ps + 1;

// flag logic
always_ff @(posedge clk, negedge reset_n) begin
  // restart the averager
  restart_avg <= avgr_restart;
  
  // if the fifo is not empty, read from it
  rd_fifo <= should_read;
  
  // we write to the ram if the accumulator is done doing its thing
  wr_ram <= ram_write;

end

// current byte finite state machine
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n)
    avgr_cnt_ps <= 0;
  else
    if (should_read)
      avgr_cnt_ps <= avgr_cnt_ns;
end
  
endmodule
