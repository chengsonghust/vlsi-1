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
reg b_neq_zero;                              // is reg_b != 0 ?

// wires
wire [nbits-1:0] sub_out;                    // output of subtraction

// state machine registry
typedef enum {
  IDLE,
  RUNNING,
  DONE,
  UNKNOWN
  } state;
state gcd_ps, gcd_ns;

enum {
  REG_A_SEL_X,
  REG_A_SEL_IN,
  REG_A_SEL_SUB,
  REG_A_SEL_B
  } reg_a_sel;

enum {
  REG_B_SEL_X,
  REG_B_SEL_IN,
  REG_B_SEL_A
  } reg_b_sel;

// assignments
assign b_neq_zero = (reg_b != 0);
assign a_lt_b = (reg_a < reg_b);
assign sub_out = (reg_a - reg_b);
assign result = reg_a;

// internal combinatorial logic
always @(*) begin

  // mux for setting value of reg_a
  case (reg_a_sel)
  REG_A_SEL_IN:
    reg_a = a_in;
  REG_A_SEL_SUB:
    reg_a = sub_out;
  REG_A_SEL_B:
    reg_a = reg_b;
  REG_A_SEL_X:
    reg_a = a_in;
  endcase

  // mux for setting value of reg_b
  case (reg_b_sel)
  REG_B_SEL_IN:
    reg_b = b_in;
  REG_B_SEL_A:
    reg_b = reg_a;
  endcase
end

// finite state machine control
always @(*) begin
  // defaults
  reg_a_sel <= REG_A_SEL_X;
  reg_b_sel <= REG_B_SEL_X;
  done = 1'b0;

  // case dependent values
  case (gcd_ps)
  IDLE: begin
    reg_a_sel <= REG_A_SEL_IN;
    reg_b_sel <= REG_B_SEL_IN;
  end

  RUNNING: begin
    if (a_lt_b) begin
      reg_a_sel <= REG_A_SEL_B;
      reg_b_sel <= REG_B_SEL_A;

    end else if (b_neq_zero) begin
      reg_a_sel <= REG_A_SEL_SUB;
    end
  end

  DONE:
    done = 1'b1;
  endcase
end

// advance the state machine
assign gcd_ns = state'(state_machine(gcd_ps, start, b_neq_zero));
function [nbits-1:0] state_machine;
  input state ps;
  input start;
  input b_neq_zero;

  // default stay in current state
  state_machine = ps;
  case (ps)
  IDLE:
    if (start)
      state_machine = RUNNING;
  RUNNING:
    if (!b_neq_zero)
      state_machine = DONE;
  DONE:
    // only assert for one cycle
    state_machine = IDLE;
  endcase
endfunction

// move to next state at clock
always @(posedge clk) begin
  gcd_ps = gcd_ns;
end

// async active low reset
always @(negedge reset_n) begin
  gcd_ps = IDLE;
end

endmodule
