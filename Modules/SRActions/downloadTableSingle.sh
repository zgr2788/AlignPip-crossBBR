#!/bin/bash
#
# Script for downloading files sequentially from ENA through aspera
#
# @zgr2788


# Read vars
fileName=$1
fileStrings=$(cat $fileName)
aspKey=$2

for string in $fileStrings
do
	# Example command:  ascp -QT -l 100m -P33001 -i /cta/users/oybeker/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/SRR182/026/SRR18291926/SRR18291926.fastq.gz .
	# The string starting with era-fasp is the one that changes, along with output
	
	# Designate output
	outDir="Single/$string"
	
	# Encoding: If the string is 10 chars, only take last digit, if not, take last 2
	if [ ${#string} == 10 ]
	then
		downloadString="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/00${string:9:1}/$string/$string.fastq.gz"
	else
		downloadString="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/0${string:9:2}/$string/$string.fastq.gz"
	fi	
	
	# Download the file - change key here if needed
	ascp -QT -l 300m -P 33001 -i $aspKey $downloadString $outDir
done
