//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: Shift Register - takes serial data and parallelizes it.
//                Basically constructs bytes from bits

module shift_reg (
        input clk,
        input reset_n,
        input data_ena,
        input serial_data,
        output [7:0] parallel_data
        );

// valid bits are 0-7
reg [2:0] current_bit;
wire [2:0] next_bit;

// current and next registers
reg [7:0] ps;
wire [7:0] ns;

wire on_last_bit;
assign on_last_bit = (current_bit == 7);

assign parallel_data = ps;

// pseudo state machines; calculate the next bit and next
// value of the shift register
assign ns = on_last_bit ? 0 : {serial_data, ps[6:1]};
assign next_bit = on_last_bit ? 0 : current_bit + 1;

// set current from future and reset data
always_ff @(posedge clk, negedge reset_n) begin
    if (!reset_n) begin
      ps <= 0;
      current_bit <= 0;
    end else if (data_ena) begin
      ps <= ns;
      current_bit <= next_bit;
  end
end

endmodule
