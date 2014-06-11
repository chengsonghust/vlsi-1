//        Author: Jordan Bayles
//    Assignment: HW6 
//        Course: ECE 474 - VLSI System Design
//   Description: Temperature Averaging System (TAS)

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

wire [7:0] fifo_data;
wire fifo_empty;
wire fifo_full;

wire [7:0] parallel_data;
wire ram_ena;
reg ram_ena_ffo;
wire rd_fifo;
wire wr_fifo;
wire wr_ram;
wire zero_sel;

assign a5_or_c3 = (parallel_data == 8'hA5) || (parallel_data == 8'hC3);
assign ram_data = acc_out[7:0];

shift_reg S1 (clk_50,
              reset_n,
              data_ena,
              serial_data,
              parallel_data
              );

ctrl_blk_50 CB50 (a5_or_c3,
                  data_ena,
                  clk_50,
                  reset_n,
                  wr_fifo);

fifo F1 (clk_50,
         clk_2,
         reset_n,
         wr_fifo,
         rd_fifo,
         parallel_data,
         fifo_data,
         fifo_empty,
         fifo_full
         );

ctrl_blk_2 CB2 (fifo_empty,
                clk_2,
                reset_n,
                zero_sel,
                rd_fifo,
                ram_ena,
                ram_wr_n
                );

averager A1 (fifo_data,
             zero_sel,
             rd_fifo,
             clk_2,
             reset_n,
             acc_out);

ram_addresser RA1 (clk_2,
                   reset_n,
                   ram_ena,
                   ram_addr
                   );

endmodule

