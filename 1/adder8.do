// Jordan Bayles
// VLSI HW #1
// 4/16/2014

add list -nodelta
configure list -strobestart {9 ns}  -strobeperiod {10 ns}
configure list -usestrobe 1

add list -notrigger -hex -width 4  -label a          a
add list -notrigger -hex -width 4  -label b          b
add list -notrigger -hex -width 10 -label sum_out    sum_out
add list -notrigger -hex -width 8  -label c_out      c_out

// test cases

//both zero
force a  x"0"
force b  x"0"
run 10 ns

// one zero
force a  x"0"
force b  x"1"
run 10 ns

//neither zero
force a  x"1"
force b  x"1"
run 10 ns

//both positive: multiple cases
force a  x"1"
force b  x"10"
run 10 ns

force a  x"2"
force b  x"20"
run 10 ns

force a  x"10"
force b  x"1"
run 10 ns

force a  x"20"
force b  x"2"
run 10 ns

force a  x"30"
force b  x"3"
run 10 ns

force a  x"40"
force b  x"4"
run 10 ns

force a  x"4"
force b  x"40"
run 10 ns

force a  x"3"
force b  x"30"
run 10 ns

force a  x"50"
force b  x"5"
run 10 ns

force a  x"5"
force b  x"50"
run 10 ns

force a  x"60"
force b  x"6"
run 10 ns

force a  x"6"
force b  x"60"
run 10 ns

force a  x"70"
force b  x"7"
run 10 ns

force a  x"7"
force b  x"70"
run 10 ns

force a  x"80"
force b  x"8"
run 10 ns

force a  x"8"
force b  x"80"
run 10 ns

force a  x"5"
force b  x"5"
run 10 ns

force a  x"50"
force b  x"50"
run 10 ns

force a  x"2"
force b  x"22"
run 10 ns

force a  x"22"
force b  x"22"
run 10 ns

write list adder8.list
