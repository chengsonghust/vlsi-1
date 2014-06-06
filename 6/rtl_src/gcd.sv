// Author: Jordan Bayles
//   Desc: ECE 474 - HW 4
//  refer: http://www.angelfire.com/in/rajesh52/verilogvhdl.html
//         http://cseweb.ucsd.edu/classes/sp09/cse141L/Slides/02-Verilog2.pdf
//
// FSM ref:http://www.asic-world.com/tidbits/verilog_fsm.html

// Greatest Common Denominator Engine Module
module gcd#(parameter nbits = 32)
           (input [nbits-1:0] a_in,          //operand a
            input [nbits-1:0] b_in,          //operand b
            input start,                     //validates the input data
            input reset_n,                   //reset
            input clk,                       //clock
            output reg [nbits-1:0] result,   //output of GCD engine
            output reg done                  //validates output value
            );

// operand registries
reg [nbits-1:0] reg_a, reg_b;                // manipulable operands

// calculation registries
reg a_lt_b;                                  // is reg_a < reg_b?
reg b_eq_zero;                              // is reg_b != 0 ?

// wires
wire [nbits-1:0] sub_out;                    // output of subtraction

// state machine registry
typedef enum reg [1:0] {
  IDLE,
  RUNNING,
  DONE,
  UNKNOWN
  } state;
state gcd_ps, gcd_ns;

enum reg [1:0] {
  REG_A_HOLD,
  REG_A_IN,
  REG_A_SUB,
  REG_A_B
  } reg_a_sel;

enum reg [1:0] {
  REG_B_HOLD,
  REG_B_IN,
  REG_B_A
  } reg_b_sel;

// assignments
assign b_eq_zero = (reg_b == 0);
assign a_lt_b = (reg_a < reg_b);
assign sub_out = (reg_a - reg_b);
assign result = reg_a;

// logic for registers
always_ff @(posedge clk, negedge reset_n) begin

  if (!reset_n) begin
    reg_a <= '0;
    reg_b <= '0;
  end

  end else begin
    // mux for setting value of reg_a
    unique case (reg_a_sel)
    REG_A_IN:
      reg_a <= a_in;
    REG_A_SUB:
      reg_a <= sub_out;
    REG_A_B:
      reg_a <= reg_b;
    REG_A_HOLD:
      reg_a <= reg_a;
    endcase

    // mux for setting value of reg_b
    unique case (reg_b_sel)
    REG_B_IN:
      reg_b <= b_in;
    REG_B_A:
      reg_b <= reg_a;
    REG_B_HOLD:
      reg_b <= reg_b;

    // default is to hold
    default:
      reg_b <= reg_b;
    endcase
  end
end

// finite state machine control
always_comb begin
  reg_a_sel = REG_A_HOLD;
  reg_b_sel = REG_B_HOLD;
  done = 1'b0;

  // case dependent values
  unique case (gcd_ps)
  IDLE:
    if (start) begin
      reg_a_sel = REG_A_IN;
      reg_b_sel = REG_B_IN;
    end

  RUNNING:
    if (a_lt_b) begin
      reg_a_sel = REG_A_B;
      reg_b_sel = REG_B_A;
    end else if (!b_eq_zero) begin
      reg_a_sel = REG_A_SUB;
    end

  DONE:
    done = 1'b1;

  endcase
end

// determine next state
always_comb begin
  // default is to keep state
  gcd_ns = gcd_ps;
  unique case (gcd_ps)
    IDLE:
      if (start)
        gcd_ns = RUNNING;

    RUNNING:
      if (b_eq_zero)
        gcd_ns = DONE;

    DONE:
      gcd_ns = IDLE;

  endcase
end

// move to next state
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    gcd_ps <= IDLE;
  end else begin
    gcd_ps <= gcd_ns;
  end
end

endmodule
