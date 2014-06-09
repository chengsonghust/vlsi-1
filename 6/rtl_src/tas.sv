module tas (
       input  clk_50,               // 50Mhz input clock
       input  clk_2,                // 2Mhz input clock
       input  reset_n,              // reset async active low
       input  serial_data,          // serial input data
       input  data_ena,             // serial data enable
       output ram_wr_n,             // write strobe to ram
       output [7:0] ram_data,       // ram data
       output [10:0] ram_addr       // ram address
       );

wire a5_or_c3;
wire [8:0] acc_out;
wire byte_assembled;
wire [7:0] fifo_data;
wire fifo_empty;
wire fifo_full;
wire [7:0] parallel_data;
wire ram_ena;
wire rd_fifo;
wire wr_fifo;
wire wr_ram;
wire zero_sel;

assign a5_or_c3 = (parallel_data == 8'hA5) || (parallel_data == 8'hC3);
assign ram_data = acc_out[7:0];

shift_reg(clk_50,
          reset_n,
          data_ena,
          serial_data,
          parallel_data
         );

ctrl_blk_50(a5_or_c3,
            data_ena,
            clk_50,
            reset_n,
            wr_fifo);

fifo(clk_50,
     clk_2,
     reset_n,
     wr_fifo,
     rd_fifo,
     parallel_data,
     fifo_data,
     fifo_empty,
     fifo_full
     );

ctrl_blk_2(fifo_empty,
           clk_2,
           reset_n,
           zero_sel,
           rd_fifo,
           wr_ram
           );

accumulator(fifo_data,
            zero_sel,
            rd_fifo,
            clk_2,
            reset_n,
            acc_out);

ram_addr_cntr(clk_2,
              reset_n,
              ram_ena
              );

// delay flip flop to addr_counter
always_ff @(posedge clk_2, negedge reset_n) begin
  if (!reset_n) begin
    ram_en <= 0;
  end else begin
    ram_en <= wr_ram;
  end
end

endmodule

