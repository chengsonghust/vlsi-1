module ctrl_blk_50 (
        input a5_or_c3,
        input data_ena,
        input clk_50,
        input reset_n,
        output wr_fifo
        );

// data available on serial line
enum {
  true,
  false
} detect_ps, detect_ns;

// packet type
enum {
  temp,
  check
} pkt_type_ps, pkt_type_ns;

// header or data?
enum {
  header,
  data
} data_type_ps, data_type_ns;

endmodule
