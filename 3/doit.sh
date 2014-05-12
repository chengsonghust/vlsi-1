#!/usr/bin/env bash
# Jordan Bayles
# VLSI HW #2
# 4/30/2014

# create the work directory if it doesn't exist
if [ ! -d "work" ]
then
  echo "work does not exist, making it"
  vlib work
fi

# compile fifo.sv if they exist
if [ -s "fifo.sv" ]
then
  vlog -novopt fifo.sv
fi

# first run of the simulation
if [ -s "adder.do" ]
then
	vsim fifo -do fifo.do -quiet -c -t 1ps
fi

# synthesize fifo
if [ -s "syn_fifo" ]
then
	dc_shell-xg-t -f syn_fifo
fi

# compile the .gate.v file
if [ -s "fifo.gate.v" ]
then
	vlog -novopt fifo.gate.v
fi

vsim fifo -do fifo.do -quiet -c -t 1ps

