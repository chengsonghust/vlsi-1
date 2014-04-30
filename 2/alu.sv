module alu(
    input        [7:0] in_a     ,  //input a
    input        [7:0] in_b     ,  //input b
    input        [3:0] opcode   ,  //opcode input
    output  reg  [7:0] alu_out  ,  //alu output
    output  reg        alu_zero ,  //logic '1' when alu_output [7:0] is all zeros
    output  reg        alu_carry   //indicates a carry out from ALU 
    );

    // constant values
    parameter c_add      = 4'h1;
    parameter c_sub      = 4'h2;
    parameter c_inc      = 4'h3;
    parameter c_dec      = 4'h4;
    parameter c_or       = 4'h5;
    parameter c_and      = 4'h6;
    parameter c_xor      = 4'h7;
    parameter c_shr      = 4'h8;
    parameter c_shl      = 4'h9;
    parameter c_onescomp = 4'ha;
    parameter c_twoscomp = 4'hb;

    reg [8:0] result;            // alu result for finding carries
   
    // combinational logic / logic gates block 
    always @(*) begin

    case (opcode)
    c_add:
        result = in_a + in_b;
    c_sub:
        result = in_a + ~in_b + 1;
    c_inc:
        result = in_a + 8'b00000001;
    c_dec:
        result = in_a - 8'b00000001;
    c_or:
        result = in_a | in_b;
    c_and:
        result = in_a & in_b;
    c_xor:
        result = in_a ^ in_b;
    c_shr:
        // in_a[0] becomes the carry bit
        result = {in_a[0], 1'b0, in_a[7:1]};
    c_shl:
	// implicitly sets alu_carry to value of MSB bit
        result = {in_a[7:0], 1'b0};
    c_onescomp:
        result = ~in_a;
    c_twoscomp:
        result = ~in_a + 1;
    default:
	result = 'x;
    endcase


    // split up the results
    alu_out = result[7:0];
    alu_carry = result[8];
    alu_zero = !alu_out;

    end

endmodule
