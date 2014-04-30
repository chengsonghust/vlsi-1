view signals
add wave -r /*

force in_a 8'd40
force in_b 8'd129
force opcode 4'h1
run 100ns

force in_a 8'd64
force in_b 8'd69
force opcode 4'h2
run 100ns

force in_a 8'hff
force in_b 8'hXX
force opcode 4'h3
run 100ns

force in_a 8'd20
force in_b 8'hXX
force opcode 4'h4
run 100ns

force in_a 8'b10101010
force in_b 8'b01010110
force opcode 4'h5
run 100ns

force in_a 8'b11001100
force in_b 8'b11000011
force opcode 4'h6
run 100ns

force in_a 8'b10101010
force in_b 8'b10010110
force opcode 4'h7
run 100ns

force in_a 8'b10101010
force in_b 8'hXX
force opcode 4'h8
run 100ns

force in_a 8'b10101010
force in_b 8'hXX
force opcode 4'h9
run 100ns

force in_a 8'hbb
force in_b 8'hXX
force opcode 4'ha
run 100ns

force in_a 8'hbb
force in_b 8'hXX
force opcode 4'hb
run 100ns

force in_a 8'hXX
force in_b 8'hXX
force opcode 4'hc
run 100ns

