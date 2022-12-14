#!/bin/bash

#Script to split paired/single reads for alignment

printf -- "\n========================================\n\n"

printf -- "Enter the name of the sampleTable WITHOUT the extension.\nEx. Input: 'sampleTable.csv' --> Enter: 'sampleTable'"

printf -- "\n\nYour filename: "
read filename

mkdir -p runFiles

printf -- "\nWriting tables...\n\n"

#Get paired end reads
cat "${filename}.csv" | grep -av ID | grep -a PAIRED | cut -f26 -d, | tr -s "_" "\n" | awk '{$1=$1;print}' > "runFiles/${filename}_paired.txt"

#Get single end reads, treat SC as SINGLE (flow is same)
cat "${filename}.csv" | grep -av ID | grep -av PAIRED | cut -f26 -d, | tr -s "_" "\n" | awk '{$1=$1;print}' > "runFiles/${filename}_single.txt"
