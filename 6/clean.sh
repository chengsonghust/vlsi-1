#!/usr/bin/env bash

# No hw6 main folder

# data comes in as LSB

files="work vectors/output* reports vlogout sdfout"
for file in $files
do
  rm -rf $file
done
