#!/bin/bash
# Jordan Bayles
# VLSI HW #1
# 4/16/2014

# create the work directory if it doesn't exist
if [ ! -d "work" ] ; then
  echo "work does not exist, making it"
  vlib work
fi

# compile fadder.sv and adder8.sv if they exist
if [ -s "fadder.sv" ] ; then
  vlog -novopt fadder.sv
fi

if [ -s "adder8.sv" ] ; then
  vlog -novopt adder8.sv
fi

# first run of the simulation
if [ -s "adder.do" ] ; then
	vsim adder8 -do adder8.do -quiet -c -t 1ps
fi


# synthesize adder8
if [ -s "syn_adder8" ] ; then
	dc_shell-xg-t -f syn_adder8
fi

# compile the gate library if it hasn't been done yet
if [ -s `grep adder8 work/_info/*` ] ; then

fi

# compile the .gate.v file
if [ -s "adder8.gate.v" ] then
	vlog -novopt adder8.gate.v
fi

# second run of the simulation
vsim adder8 -do adder8.do -quiet -c -t 1ps

# compare results of the two runs of simulation

# user message indicating if comparison failed

