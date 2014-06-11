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

always_ff @(posedge clk, negedge reset_n) begin
    if (!reset_n)
      parallel_data <= '0;
    else if (data_ena) 
      parallel_data <= {serial_data, ps[7:1]};
end

endmodule
