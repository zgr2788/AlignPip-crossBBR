#!/bin/bash
#
# Script for downloading files sequentially from ENA through aspera
#
# @zgr2788


# Read vars
fileName=$1
aspKey=$2
fileStrings=$(cat $fileName)

for string in $fileStrings
do
	# Example command:  ascp -QT -l 100m -P33001 -i /cta/users/oybeker/.aspera/connect/etc/asperaweb_id_dsa.openssh era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/SRR182/026/SRR18291926/SRR18291926.fastq.gz .
	# The string starting with era-fasp is the one that changes, along with output
	
	# Designate output
	outDir="Paired/$string"
	mkdir -p $outDir
	
	# Encoding: If the string is 10 chars, only take last digit, if not, take last 2
	if [ ${#string} == 10 ]
	then
		downloadStringAlt="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/00${string:9:1}/$string/$string.fastq.gz"
		downloadString1="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/00${string:9:1}/$string/${string}_1.fastq.gz"
		downloadString2="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/00${string:9:1}/$string/${string}_2.fastq.gz"
	else
		downloadStringAlt="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/0${string:9:2}/$string/${string}.fastq.gz"
		downloadString1="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/0${string:9:2}/$string/${string}_1.fastq.gz"
		downloadString2="era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/${string:0:6}/0${string:9:2}/$string/${string}_2.fastq.gz"
	fi	
	
	# Download the file - change aspera key here if desired
	ascp -QT -l 300m -P 33001 -i $aspKey $downloadStringAlt $outDir || ascp -QT -l 300m -P 33001 -i $aspKey $downloadString1 $outDir && ascp -QT -l 300m -P 33001 -i $aspKey $downloadString2 $outDir
done
