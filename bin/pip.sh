#!/bin/bash
# -= Resources =-
#SBATCH --job-name=alignPip
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --qos=longer_mdbf
#SBATCH --partition=longer_mdbf
#SBATCH --time=21600
#SBATCH --output=outPip-%j.log

condaDir="Run setup.sh to configure"

source $condaDir
conda activate snakemake

snakemake \
  --profile slurm \
  --conda-frontend mamba \
