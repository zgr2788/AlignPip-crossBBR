#!/bin/bash
#
# Unzip downloaded fastq files.


# Single
unpigz -p16 $(find Single/ -name "*gz*" -print)

# Paired
unpigz -p16 $(find Paired/ -name "*gz*" -print)
