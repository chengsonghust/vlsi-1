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
        output[7:0] data_out,      // data out
        output empty,              // empty flag
        output full                // full flag
        );

/// parameters
parameter width = 8;               // 8-bit wide
parameter depth = 8;               // 8-byte deep
parameter ptr_width = 3;           // width = ceil(log_2(depth))

/// internals
// addresses
reg [ptr_width:0] rd_addr;
reg [ptr_width:0] wr_addr;

// the ptr to the actual data is the LSBs of the full address
wire [ptr_width-1:0] rd_ptr = rd_addr[ptr_width-1:0];
wire [ptr_width-1:0] wr_ptr = wr_addr[ptr_width-1:0];

// keep track of the MSB seperately for compares
wire rd_msb = rd_addr[ptr_width];
wire wr_msb = wr_addr[ptr_width];

// this is an index for a C-style loop. Synthesizes away though.
integer i;

// use internal full and empty flags
wire full_cmp = (rd_msb != wr_msb) & (rd_ptr == wr_ptr); 
reg full_delay;

wire empty_cmp = (rd_addr == wr_addr);
reg empty_delay;

// use an internal memory so we can read and write at the same time
reg [width-1:0] memory [depth-1:0];

/// assignments
// empty is the XOR'ed output of a ff synced to rd_clk with
// input and compared to wr and rd ptr
// empty needs to be deasserted when write happens
assign empty = empty_cmp & !empty_delay;

// full is like empty, but with wr_clk
assign full = full_cmp & !full_delay;

assign data_out = memory[rd_ptr];
  
// writing
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n) begin
    for (i = 0; i < depth; i++) begin
      memory[i] <= 8'b0;
    end
  end

  else if (wr) begin
    memory[wr_ptr] <= data_in;
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

// adder for rd_ptr
always_ff @(posedge rd_clk, negedge reset_n) begin
  if (!reset_n)
    rd_addr <= 4'b0;
  else if (rd)
    rd_addr <= rd_addr + 1;
end

// adder for wr_ptr
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n)
    wr_addr <= 4'b0;
  else if (wr)
    wr_addr <= wr_addr + 1;
end

endmodule
