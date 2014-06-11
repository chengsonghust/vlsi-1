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

assign ns = {ps[6:0], serial_data};
assign parallel_data = ps;

// set current from future and reset data
always_ff @(posedge clk, negedge reset_n) begin
    if (!reset_n) begin
      ps <= 0;
    end else if (data_ena) begin
      ps <= ns;
  end
end

endmodule
