
# AlignPip-crossBBR
Bulk RNA-Seq alignment + quantification pipeline using [STAR](https://github.com/alexdobin/STAR) for alignment and [featureCounts-Rsubread](https://bioconductor.org/packages/release/bioc/html/Rsubread.html) for quantification

## Design
Sample tables which contain the SRA accessions and read info (paired/single end) with replicates separated by ";" were curated. This pipeline accepts such input and processes through the following steps:


 1. Downloads the accessions and writes the fastq files.
 2. Aligns the fastq files to the [GRCh38 Homo Sapiens genome - Release 107 / Primary Assembly](http://ftp.ensembl.org/pub/release-107/fasta/homo_sapiens/) generated through [STAR](https://github.com/alexdobin/STAR).
 3.  Reports the counts extracted by [featureCounts on Rsubread](https://bioconductor.org/packages/release/bioc/html/Rsubread.html).

## Running the pipeline
### Assumptions
1. The **26th column** of the sampleTable (indexing starts from 1) should contain the SRA run accessions **(SRRXXXXXX) replicates separated by ";"**
2. One column within the sampleTable should contain the read type info (factor with levels **SINGLE** or **PAIRED**)

 ### Steps
 1. Install [mamba](https://github.com/mamba-org/mamba)
 2.  Clone the repository

			git clone https://github.com/zgr2788/AlignPip-crossBBR.git
4. Put the `sampleTable.csv` you would like to use within the main directory
5. Run `make` and follow the steps
6. Adjust settings through config.yaml
7. **(Optional)** Run `dag.sh` to get a directed acyclic graph (DAG) of the jobs
8. Set up all cluster variables in `pip.sh`, delete all `module load` statements from `Modules/SRActions/Snakefile` && `Modules/Align/Snakefile`. This step is necessary as the pipeline was originally meant to be run on the TOSUN Cluster at Sabancı.
9. Fastq files should be downloaded.gz format
**Option 1**  
`downloadTable{Layout}.sh` scripts are highly recommended if [Aspera Connect](https://www.biostars.org/p/9528910/) is installed. With Aspera installed, do the following:

			bash Modules/SRActions/downloadTable{Layout}.sh {path/to/runlist} {path/to/sshkey}
	If Aspera fails for downloads, `failed{layout.txt}` files will be generated for ease.
	 **Option 2**
	 The `Modules/SRActions/fastqWrite.sh` file needs to be configured to give **a conda environment with [parallel-fastq-dump](https://github.com/rvalieris/parallel-fastq-dump)** and also **a local install of [sra-toolkit](https://github.com/ncbi/sra-tools)**. The reason being that the current conda install of parallel-fastq-dump does not install an updated sra-toolkit.  
11. Run job through `pip.sh` or on local through `snakemake`

### Appendices
#### Sample DAG
<img src="https://github.com/zgr2788/AlignPip-crossBBR/blob/main/dag_minimal.png"/>

#### Notes
A total of **323 experiments** were downloaded with this pipeline

	156 PAIRED
    15  SC (Single Fastq File)
    152 SINGLE
To reproduce the alignments, use STAR version 2.7.0 and Rsubread version 2.8.2 with the sampleTable provided.
