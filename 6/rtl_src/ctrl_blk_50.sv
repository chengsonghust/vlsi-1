//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: 50 MHz subsystem control system
//                Decides whether or not the FIFO takes in data each clock cycle

module ctrl_blk_50 (
        input a5_or_c3,
        input data_ena,
        input clk_50,
        input reset_n,
        output wr_fifo
        );

// specify the bit width of the enum to save space
enum bit [2:0] {
  byte_0 = 'h0,
  byte_1 = 'h1,
  byte_2 = 'h2,
  byte_3 = 'h3
} cur_byte_ps, cur_byte_ns;


wire byte_assembled; // has the byte been assembled from serial data yet?
reg data_written;    // has data been written yet?
reg seen_header;     // have we seen a header yet?

// byte_assembled is a flag signaling that a a byte is ready
// on parallel_data. It is the output of an AND gate with
// inputs (not data_ena) and a flip flop with the old value of data_ena
// data_ena is synchronous with the clock, otherwise we can't do this.
assign byte_assembled = (!data_ena & data_written);

always_ff @(posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    data_written <= 0;
  else
    data_written <= data_ena;
end

// we want to sync wr_fifo with clk_50 so we only command a write once
wire writeable_byte;
reg writeable_delay;
assign writeable_byte = (seen_header & byte_assembled);
assign wr_fifo = writeable_byte ^ writeable_delay;

always_ff @(posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    writeable_delay <= 0;
  else 
    writeable_delay <= writeable_byte;
end
  
// logic for the seen_header flag and output
always_ff @(posedge clk_50, negedge reset_n) begin
  if (!reset_n) begin
     seen_header <= 0;
   end
  else begin
    // if this is a header, just make note of it.
    if (a5_or_c3)
      seen_header <= 1;
    
    else if (seen_header) begin
      // if it's the last byte in the packet reset the header flag 
      if ((cur_byte_ps == byte_3) & (cur_byte_ns == byte_0))
        seen_header <= 0;
    end 
  end
end

// Keep track of the last data byte successfully read
always_ff @(posedge clk_50, negedge reset_n) begin
  if (!reset_n)
    cur_byte_ps <= byte_0;
  else
    cur_byte_ps <= cur_byte_ns;
end

// state machine is simple: if the byte is writeable, assume its written
// and increment self
always_comb begin
  //default
  cur_byte_ns = byte_0;
  if (writeable_byte) begin
    case (cur_byte_ps)
      byte_0:
        cur_byte_ns = byte_1;
      byte_1:
        cur_byte_ns = byte_2;
      byte_2:
        cur_byte_ns = byte_3;
      byte_3:
        cur_byte_ns = byte_0;
    endcase
    
  // otherwise just stay on the current byte
  end else 
    cur_byte_ns = cur_byte_ps;
  
end

endmodule
