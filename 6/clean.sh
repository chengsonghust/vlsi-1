#!/usr/bin/env bash

# No hw6 main folder

files="work vectors/output* reports vlogout sdfout"
for file in $files
do
  rm -rf $file
done
