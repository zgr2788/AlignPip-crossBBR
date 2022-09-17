#!/bin/bash

#Script to split paired/single reads for alignment


filename=$1

mkdir -p runFiles

#Get paired end reads
cat "${filename}.csv" | grep -v ID | grep PAIRED | cut -f26 -d, | tr -s ";" "\n" | awk '{$1=$1;print}' > "runFiles/${1}_paired.txt"

#Get single end reads
cat "${filename}.csv" | grep -v ID | grep SINGLE | cut -f26 -d, | tr -s ";" "\n" | awk '{$1=$1;print}' > "runFiles/${1}_single.txt"

