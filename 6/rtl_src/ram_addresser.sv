//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: RAM Address Counter - keeps track of address we are writing to in RAM

module ram_addresser (
        input clk_2,
        input reset_n,
        input ram_ena,
        output [10:0] ram_addr
        );

reg [10:0] address;

// high address, all ones
parameter start_address = 11'h7FF;

assign ram_addr = address;

always_ff @(posedge clk_2, negedge reset_n) begin
  // handle reset
  if (!reset_n) begin
    address <= start_address;
    
  end else begin
    // ram_ena means a write is occuring this cycle
    if (ram_ena) begin

      // hit the bottom so start rewriting data
      if (ram_addr == 0'h0000)
        address <= start_address;
        
      // just decrement since we have more memory
      else
        address <= address - 1;
        
    end
  end 
end

endmodule
