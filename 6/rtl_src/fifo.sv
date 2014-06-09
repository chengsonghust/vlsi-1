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

// use internal full and empty state machines for assignments
reg full_ps, full_ns;
reg empty_ps, empty_ns;

// use an internal memory so we can read and write at the same time
reg [width-1:0] memory[depth-1:0];

/// assignments
assign full = full_ps;
assign empty = empty_ps;

assign rd_pointer = rd_address[pointer_width-1:0];
assign wr_pointer = wr_address[pointer_width-1:0];

assign rd_msb = rd_address[pointer_width];
assign wr_msb = wr_address[pointer_width];

// reading
always_comb begin
  data_out <= memory[rd_pointer];
end

// writing
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n) begin
    for (i = 0; i < depth; i++) begin
      memory[i] <= 8'b0;
    end
  end

  else if (wr)
    memory[wr_pointer] <= data_in;
end

/// mealy machines
// advance empty state machine
always_ff @(posedge rd_clk, negedge reset_n)
  if (!reset_n)
    empty_ps <= 1;
  else
    empty_ps <= empty_ns;
end

// advance full state machine
always_ff @(posedge wr_clk, negedge reset_n)
  if (!reset_n)
    full_ps <= 0;
  else
    full_ps <= full_ns;
end

// compare pointers
always_comb begin
  if (rd_pointer == wr_pointer) begin
    if (rd_msb != wr_msb)
      full_ns = 1;
    else
      empty_ns = 1;
  end else begin
    full_ns = 0;
    empty_ns = 0;
  end
end

// adder for rd_pointer
always_ff @(posedge rd_clk, negedge reset_n) begin
  if (!reset_n)
    rd_pointer <= 3'b0;
  else if (rd)
    rd_pointer <= rd_pointer + 1;
end

// adder for wr_pointer
always_ff @(posedge wr_clk, negedge reset_n) begin
  if (!reset_n)
    wr_pointer <= 3'b0;
  else if (wr)
    wr_pointer <= wr_pointer + 1;
end

endmodule
