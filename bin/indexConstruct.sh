#!/bin/bash
# 
#
# GRCH38-Latest index construct script
#
# @zgr2788
#
# -= Resources =-
#
#SBATCH --job-name=constructIndex
#SBATCH --account=mdbf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --qos=long_mdbf
#SBATCH --partition=long_mdbf
#SBATCH --time=10080
#SBATCH --output=%j-idxConstruct.log


module load star-2.7.0e-gcc-9.2.0-vynasg3


STAR \
    --runMode genomeGenerate \
    --runThreadN 16 \
    --genomeFastaFiles /cta/users/oybeker/GRCh38_index/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
    --genomeDir /cta/users/oybeker/GRCh38_index/index \
    --sjdbOverhang 100 \
    --sjdbGTFfile /cta/users/oybeker/GRCh38_index/Homo_sapiens.GRCh38.107.gtf \
    --limitGenomeGenerateRAM 75000000000
