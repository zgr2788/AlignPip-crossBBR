#!/bin/bash
# -= Resources =-
#SBATCH --job-name=alignPip
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --qos=mid_mdbf
#SBATCH --partition=mid_mdbf
#SBATCH --time=1440
#SBATCH --output=outPip-%j.log

condaDir="Run setup.sh to configure"

source $condaDir
conda activate snakemake

snakemake \
  --profile slurm \
  --conda-frontend mamba \
