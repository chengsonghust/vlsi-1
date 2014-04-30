#!/usr/bin/env bash
# Jordan Bayles
# VLSI HW #2
# 4/30/2014

# create the work directory if it doesn't exist
if [ ! -d "work" ] ; then
  echo "work does not exist, making it"
  vlib work
fi

# compile alu.sv if they exist
if [ -s "alu.sv" ] ; then
  vlog -novopt alu.sv
fi

# first run of the simulation
if [ -s "adder.do" ] ; then
	vsim alu -do alu.do -quiet -c -t 1ps
fi

# synthesize alu
if [ -s "syn_alu" ] ; then
	dc_shell-xg-t -f syn_alu
fi

# compile the .gate.v file
if [ -s "alu.gate.v" ] then
	vlog -novopt alu.gate.v
fi

vsim alu -do alu.do -quiet -c -t 1ps

