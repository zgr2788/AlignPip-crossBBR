#!/bin/bash
# -= Resources =-
#SBATCH --job-name=fetchSraPaired
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --qos=long_mdbf
#SBATCH --partition=long_mdbf
#SBATCH --time=10080
#SBATCH --output=PEdownload.log

which prefetch

mkdir -p Paired

prefetch \
	-X 99999999999999999999 \
	-O ./Paired \
	--option-file runFiles/sampleTable_final_paired.txt
