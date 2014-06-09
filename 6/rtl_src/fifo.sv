//        Author: Jordan Bayles
//    Assignment: HW3 - revised for HW6
//        Course: ECE 474 - VLSI System Design
//   Description: 8-bit, 8-byte wide FIFO

module fifo (
        input wr_clk,              // write clock
        input rd_clk,              // read clock
        input reset_n,             // reset async active low
        input wr,                  // write enable
        input rd,                  // read enable
        input [7:0] data_in,       // data in
        output reg [7:0] data_out, // data out
        output empty,              // empty flag
        output full                // full flag
        );

/// parameters
parameter width = 8;               // 8-bit wide
parameter depth = 8;               // 8-byte deep
parameter pointer_width = 3;       // width = ceil(log_2(depth))

/// internals
// pointers
reg [pointer_width:0] rd_address, wr_address;
wire [pointer_width-1:0] rd_pointer, wr_pointer;
wire rd_msb, wr_msb;

// this is an index for a C-style loop. Synthesizes away though.
integer i;

// use internal full and empty flags
reg full_ps;
wire full_cmp;
wire full_delay;

reg empty_ps;
wire empty_cmp;
wire empty_delay;

// use an internal memory so we can read and write at the same time
reg [width-1:0] memory [depth-1:0];

/// assignments
assign full = full_ps;

// empty is the XOR'ed output of a ff synced to rd_clk with
// input and compared to wr and rd pointer
// empty needs to be deasserted when write happens
assign empty = empty_cmp ^ empty_delay;

// full is like empty, but with wr_clk
assign full = full_cmp ^ full_delay;

// the pointer to the actual data is the LSBs of the full address
assign rd_pointer = rd_address[pointer_width-1:0];
assign wr_pointer = wr_address[pointer_width-1:0];

// keep track of the MSB seperately for compares
assign rd_msb = rd_address[pointer_width];
assign wr_msb = wr_address[pointer_width];

// reading
always_comb begin
  data_out = memory[rd_pointer];
end

// writing
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n) begin
    for (i = 0; i < depth; i++) begin
      memory[i] <= 8'b0;
    end
  end

  else if (wr) begin
    memory[wr_pointer] <= data_in;
  end
end

// output delayed empty
// we want to sync empty with rd_clk, hence flip flop
always_ff @(posedge rd_clk, negedge reset_n) begin
  if (!reset_n)
    empty_delay <= 1;
  else
    empty_delay <= empty_cmp;
end

// output delayed full
// we want to sync full with wr_clk, hence flip flop
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n)
    full_delay <= 0;
  else
    full_delay <= full_cmp;
end

// compare pointers
always_comb begin
  if (rd_pointer == wr_pointer) begin
    if (rd_msb != wr_msb)
      full_cmp = 1;
    else
      empty_cmp = 1;
  end else begin
    full_cmp = 0;
    empty_cmp = 0;
  end
end

// adder for rd_pointer
always_ff @(posedge rd_clk, negedge reset_n) begin
  if (!reset_n)
    rd_address <= 4'b0;
  else if (rd)
    rd_address <= rd_address + 1;
end

// adder for wr_pointer
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n)
    wr_address <= 4'b0;
  else if (wr)
    wr_address <= wr_address + 1;
end

endmodule
