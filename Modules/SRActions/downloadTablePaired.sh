#!/bin/bash
#SBATCH --job-name=aspDownload
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --qos=mid_mdbf
#SBATCH --partition=mid_mdbf
#SBATCH --time=1440
#SBATCH --output=downloadPaired.log

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
	
	# Download the file
	if [ ! -f "Paired/$string/${string}_1.fastq.gz" ]
	then
		[ ! -f "Paired/$string/${string}.fastq.gz" ] && ascp -QT -l 300m -P 33001 -i $aspKey $downloadString1 $outDir
	else
		echo "${string}_1 exists, skipping..."
	fi

	if [ ! -f "Paired/$string/${string}_2.fastq.gz" ]
	then
		[ ! -f "Paired/$string/${string}.fastq.gz" ] && ascp -QT -l 300m -P 33001 -i $aspKey $downloadString2 $outDir
	else
		echo "${string}_2 exists, skipping..."
	fi

	if [ ! -f "Paired/$string/${string}.fastq.gz" ]
	then
		[ ! -f "Paired/$string/${string}_1.fastq.gz" ] && [ ! -f "Paired/$string/${string}_2.fastq.gz" ] && ascp -QT -l 300m -P 33001 -i $aspKey $downloadStringAlt $outDir 
	else
		echo "${string} exists, skipping..."
	fi

	# Check if successful
	if [ [ -f "Paired/$string/${string}_1.fastq.gz" ] && [ -f "Paired/$string/${string}_2.fastq.gz" ] ] || [ -f "Paired/$string/${string}.fastq.gz" ]; then
		echo "Download succeeded for $string"
	else
		echo $string >> pairedFails.txt	
	fi
done
