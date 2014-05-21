#!/bin/bash
# Jordan Bayles
# VLSI HW #1
# 4/16/2014

# create the work directory if it doesn't exist
if [ ! -d "work" ] ; then
  echo "work does not exist, making it"
  vlib work
fi

# compile gcd.sv
if [ -s "gcd.sv" ] ; then
  vlog -novopt gcd.sv
fi


# first run of the simulation
if [ -s "adder.do" ] ; then
	vsim gcd -do gcd.do -quiet -c -t 1ps
fi


# synthesize gcd
if [ -s "syn_gcd" ] ; then
	dc_shell-xg-t -f syn_gcd
fi

# compile the gate library if it hasn't been done yet
if [ -s `grep gcd work/_info/*` ] ; then

fi

# compile the .gate.v file
if [ -s "gcd.gate.v" ] then
	vlog -novopt gcd.gate.v
fi

# second run of the simulation
vsim gcd -do gcd.do -quiet -c -t 1ps

# compare results of the two runs of simulation

# user message indicating if comparison failed

