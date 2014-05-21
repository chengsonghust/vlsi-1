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
reg [nbits-1:0] tmp;                         // temporary register
reg reg_a_en, reg_b_en;                      // enable registries 

// calculation registries
reg a_lt_b;                                  // is reg_a < reg_b?
reg b_neq_zero;                              // is reg_b != 0 ?
reg [1:0] reg_a_sel;                         // mux for reg_a
reg reg_b_sel;                               // mux for reg_b

// wires
wire [nbits-1:0] sub_out;                    // output of subtraction

// internal constants
parameter PS_NS_SIZE = 2;
parameter IDLE = 2'b01, RUNNING = 2'b10, DONE = 2'b11;
parameter REG_A_SEL_X = 2'b01, REG_A_SEL_IN = 2'b10, REG_A_SEL_SUB = 2'b11, REG_A_SEL_B = 2'b00;
parameter REG_B_SEL_X = 1'b0, REG_B_SEL_IN = 1'b0, REG_B_SEL_A = 1'b1;

// state machine registry
reg [PS_NS_SIZE-1:0] gcd_ps;                // present state
wire[PS_NS_SIZE-1:0] gcd_ns;                // next state

// assignments
assign b_neq_zero = (reg_b != 0) ? 1'b1 : 1'b0;
assign a_lt_b = (reg_a < reg_b) ? 1'b1 : 1'b0;
assign sub_out = (reg_a - reg_b) ? 1'b1 : 1'b0;
assign result = reg_a;

// internal combinatorial logic
always @(*) begin

  // mux for setting value of reg_a
  if (reg_a_en) begin
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
  end

  // mux for setting value of reg_b
  if (reg_b_en) begin
    case (reg_b_sel)
    REG_B_SEL_IN:
      reg_b = b_in;
    REG_B_SEL_A:
      reg_b = reg_a;
    endcase
  end
end

// finite state machine control
always_ff @(posedge clk) begin
  // defaults
  //start = 1'b0;
  reg_a_sel = REG_A_SEL_X;
  reg_a_en = 1'b0;
  reg_b_sel = REG_B_SEL_X;
  reg_b_en = 1'b0;
  done = 1'b0;

  // case dependent values
  case (gcd_ps)
  IDLE: begin
    reg_a_sel = REG_A_SEL_IN;
    reg_a_en = 1'b1;
    reg_b_sel = REG_B_SEL_IN;
    reg_b_en = 1'b1;
  end
  
  RUNNING: begin
    if (a_lt_b) begin
      reg_a_sel = REG_A_SEL_B;
      reg_a_en = 1'b1;
      reg_b_sel = REG_B_SEL_A;
      reg_b_en = 1'b1;
      
    end else if (b_neq_zero) begin
      reg_a_sel = REG_A_SEL_SUB;
      reg_a_en = 1'b1;
    end
  end
  
  DONE:
    done = 1'b1;  
  endcase
end

// advance the state machine
assign gcd_ns = state_machine(gcd_ps, start, b_neq_zero);
function [nbits-1:0] state_machine;
  input [nbits-1:0] ps;
  input start;
  input b_neq_zero;
  
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
  default:
    state_machine = IDLE;
  endcase
endfunction

// move to next state at clock
always @(posedge clk) begin
  gcd_ps <= gcd_ns;  
end

// async active low reset
always @(negedge reset_n) begin
  gcd_ps <= IDLE;
end

endmodule
