#!/bin/bash
#SBATCH --job-name=fetchFailed
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --qos=long_mdbf
#SBATCH --partition=long_mdbf
#SBATCH --time=10080
#SBATCH --output=fetch-%j.log

condaDir="/cta/users/oybeker/mambaforge/etc/profile.d/conda.sh"
entry=$1
readType=$2

if [[ $readType == "Paired" ]]
then
	outLoc="Paired"
else
	outLoc="Single"
fi


source $condaDir
conda activate par-fastq
module load sra-toolkit-3.0.0-gcc-9.2.0-f6ulhyq

mkdir -p SRAcache

printf -- "\n\n******************************\n**Now processing $entry**\n******************************\n\n"
	
if [ ! -f "SRAcache/$entry/$entry.sra" ]; then
prefetch -O SRAcache/ $entry
fi

if [ ! -f "SRAcache/$entry/$entry.sra" ]; then
echo "PREFETCH ERROR"
fi

parallel-fastq-dump --sra-id SRAcache/$entry/$entry.sra --threads 16 --outdir "${outLoc}/$entry/" --split-3 --gzip 
