module ctrl_blk_2 (
        input empty_flag,
        input clk_2,
        input reset_n,
        output zero_sel,
        output rd_fifo,
        output wr_ram
        );

// reading the fifo into the averager
enum {
  read,
  idle
} fifo_avg_ps, fifo_avg_ns;

// boolean on the first byte?
enum {
  true,
  false
} first_byte_ps, first_byte_ns;

// what is the current byte?
enum {
  idle,
  byte_0,
  byte_1,
  byte_2,
  byte_3
} cur_byte_ps, cur_byte_ns;

// ram write status
enum {
  idle,
  write,
  hold
} ram_write_ps, ram_write_ns;

// read fifo into the averager/accumulator
always_ff (posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    fifo_avg_ps <= idle;
  else
    fifo_avg_ps <= fifo_avg_ns;
end

always_comb begin
  fifo_avg_ns = idle;

  case (fifo_avg_ps)
  read:
    fifo_avg_ns = idle;
  idle:
    if (!fifo_empty)
      fifo_avg_ns = read;
  endcase
end

// boolean on the first byte?
always_ff (posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    first_byte_ps <= false;
  else
    first_byte_ps <= first_byte_ns;
end

always_comb begin
  first_byte_ns = false;

  case (first_byte_ps)
  true:
    first_byte_ns = false;
  false:
    if (cur_byte_ns == byte_0)
      first_byte_ns = true;
    else
      first_byte_ns = false;
  endcase
end


// what is the current byte?
always_ff (posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    cur_byte_ps<= false;
  else
    cur_byte_ps <= cur_byte_ns;
end

always_comb begin
  cur_byte_ns = idle;

  case (cur_byte_ps)
  idle:

  byte_0:

  byte_1:

  byte_2:

  byte_3:

  endcase
end


// ram write status
always_ff (posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    ram_write_ps <= false;
  else
    ram_write_ps <= ram_write_ns;
end

always_comb begin
  ram_write_ns = idle;

  case (ram_write_ps)
  idle:

  write:

  hold:

  endcase
end

endmodule
