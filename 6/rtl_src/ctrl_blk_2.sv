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
reg [2:0] avgr_cnt_ns;

// is the averager full?
wire avgr_full = (avgr_cnt_ps == 4);

// writing to RAM
wire ram_write = avgr_full;

// restart the averager after its filled and completed its job
enum bit [1:0] {
  avgr_idle,
  avgr_adding,
  avgr_computing
  } avgr_restart_ns, avgr_restart_ps;

reg restart_avgr;

// flag for calling to restart averager
// flag logic
always_ff @(posedge clk, negedge reset_n) begin
  // if the fifo is not empty, read from it
  rd_fifo <= should_read;
  
  // we write to the ram if the accumulator is done doing its thing
  wr_ram <= ram_write;

  // restart the averager
  restart_avg <= restart_avgr;
end

// restart logic
always_comb begin
  avgr_restart_ns = avgr_idle;
  restart_avgr = 0;

  case (avgr_restart_ps)
  avgr_idle:
    if (avgr_cnt_ns == 1)
      avgr_restart_ns = avgr_adding;
  avgr_adding:
    if (avgr_cnt_ns == 0)
      avgr_restart_ns = avgr_computing;
    else
      avgr_restart_ns = avgr_adding;
  avgr_computing: begin
    avgr_restart_ns = avgr_idle;
    restart_avgr = 1;
  end
  endcase
end

always_ff @ (posedge clk, negedge reset_n) begin
  if (!reset_n)
    avgr_restart_ps <= avgr_idle;
  else
    avgr_restart_ps <= avgr_restart_ns;
end

// count logic
always_comb begin
  avgr_cnt_ns = 0;

  if (should_read) begin
    if (avgr_full)
      avgr_cnt_ns = 0;
    else
      avgr_cnt_ns = avgr_cnt_ps + 1;
  end else
    avgr_cnt_ns = avgr_cnt_ps;
end

// current byte finite state machine
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n)
    avgr_cnt_ps <= 0;
  else
    avgr_cnt_ps <= avgr_cnt_ns;
end
  
endmodule
