module ctrl_blk_50 (
        input a5_or_c3,
        input data_ena,
        input clk_50,
        input reset_n,
        output wr_fifo,
        output byte_assembled
        );

// data available on serial line
enum {
  true,
  false
} detect_ps, detect_ns;

// packet type
enum {
  temp,
  check,
  unknown
} pkt_type_ps, pkt_type_ns;

// header or data?
enum {
  header,
  data,
  unknown
} data_type_ps, data_type_ns;

assign byte_assembled = (detect_ps == true) && (detect_ns == false);

// byte assembled
always_ff (posedge clk_2, negedge reset_n) begin
  if (!reset_n)
    detect_ps <= false;
  else
    detect_ps <= detect_ns;
end

// logic for detection?
always_comb begin
  detect_ns = false;

  case (detect_ps)
  true:
    
  false:

  endcase
end

// packet type
always_ff (posedge clk_2, negedge reset_n) begin
  if (!reset_n)
    pkt_type_ps <= check;
  else
    pkt_type_ps <= pkt_type_ns;
end

// logic for packet type?
always_comb begin
  pkt_type_ns = unknown;

  case (pkt_type_ps)
  temp:

  check:

  unknown:

  endcase
end

// data type
always_ff (posedge clk_2, negedge reset_n) begin
  if (!reset_n)
    data_type_ps <= data;
  else
    data_type_ps <= data_type_ns;
end

// TODO fix logic for data type?
always_comb begin
  data_type_ns = unknown;

  case(data_type_ps)
  header:
    if (a5_or_c3)
      data_type_ns = header;
    else
      data_type_ns = data;
  data:
    if (a5_or_c3)
      data_type_ns = header;
    else
      data_type_ns = data;
  unknown:
    data_type_ns = header;
  endcase
end

endmodule
