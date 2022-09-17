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

module load sra-toolkit-3.0.0-gcc-9.2.0-f6ulhyq
which prefetch

mkdir -p Single

prefetch \
	-X 99999999999999999999 \
	-O ./Single \
	--option-file runFiles/sampleTable_final_single.txt
