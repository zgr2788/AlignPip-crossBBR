#!/bin/bash
#
# Unzip downloaded fastq files.

cores=$1

# Single
unpigz -p${cores} $(find Single/ -name "*gz*" -print)

# Paired
unpigz -p${cores} $(find Paired/ -name "*gz*" -print)
