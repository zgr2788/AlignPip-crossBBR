#!/bin/bash
# -= Resources =-
#SBATCH --job-name=fetchSraSingle
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --qos=long_mdbf
#SBATCH --partition=long_mdbf
#SBATCH --time=10080
#SBATCH --output=SEdownload.log

which prefetch

mkdir -p Single

prefetch \
	-X 99999999999999999999 \
	-O ./Single \
	--option-file runFiles/sampleTable_final_single.txt
