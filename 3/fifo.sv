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
parameter width = 8;          // 8-bit wide
parameter depth = 8;          // 8-byte deep
parameter pointer_width = 3;  // width = ceil(log_2(depth))

/// internals
// pointers
reg [pointer_width-1:0] rd_pointer, wr_pointer;
reg [pointer_width-1:0] pointer_remaining;

// use internal full and empty for assignments
reg full_ps, empty_ps;

// use an internal memory so we can read and write at the same time
reg [width-1:0] memory[depth-1:0];

assign full = full_ps;
assign empty = empty_ps;

// writing to memory
always @(posedge wr_clk) begin
	// synchronize deassert with wr_clk
	if (pointer_remaining < (depth - 1)) begin
		full_ps <= 1'b0;
	end

	if (wr) begin
		if (pointer_remaining == (depth - 1)) begin
			full_ps <= 1'b1;
			memory[wr_pointer] <= data_in;
			if (wr_pointer < depth) begin
				wr_pointer <= wr_pointer + 1;
			end else begin
				wr_pointer <= 0;
			end
		end
	end
end

// reading from memory
always @(posedge rd_clk) begin
	// synchronize deassert with rd_clk
	if (pointer_remaining != 0) begin
		empty_ps <= 1'b0;
	end

	if (rd) begin
		if (pointer_remaining == 0) begin
			empty_ps <= 1'b1;
			data_out <= memory[rd_pointer];
			// rollover the pointer
			if (rd_pointer < depth) begin
				rd_pointer <= rd_pointer + 1;
			end else begin
				rd_pointer <= 0;
			end
		end
	end else begin
		data_out[rd_pointer] <= 0;
	end
end

// pointer_remaining changes for both clocks
always @(*) begin
	if (wr_pointer > rd_pointer) begin
		pointer_remaining <= wr_pointer - rd_pointer;
	end else if (wr_pointer < rd_pointer) begin
		pointer_remaining <= ((depth - rd_pointer) + wr_pointer);
	end else begin
		pointer_remaining <= 0;
	end
end

// can reset at any time
always @(negedge reset_n) begin
	for (rd_pointer = 0; rd_pointer < depth; rd_pointer = rd_pointer + 1) begin
		memory[rd_pointer] <= 0;
	end
	rd_pointer <= 0;
	wr_pointer <= 0;
end

endmodule
