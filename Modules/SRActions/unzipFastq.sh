#!/bin/bash
#
# Unzip downloaded fastq files.


# Single
gunzip $(find Single/ -name "*gz*" -print)

# Paired
gunzip $(find Paired/ -name "*gz*" -print)
