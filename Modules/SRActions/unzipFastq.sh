#!/bin/bash
#
# Unzip downloaded fastq files.

cores=$1

# Single
filesSingle=$(find Single/ -name "*gz*" -print)
for files in $filesSingle
do
  echo "Unzipping $files..."
  unpigz -p${cores} -k $files
done

# Paired
filesPaired=$(find Paired/ -name "*gz*" -print)
for file in $filesPaired
do
  echo "Unzipping $file..."
  unpigz -p${cores} -k $file
done
