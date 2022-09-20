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
3. [Mamba](https://github.com/mamba-org/mamba) and [STAR](https://github.com/alexdobin/STAR) should be installed prior to running the pipeline

 ### Steps
 1. Install [mamba](https://github.com/mamba-org/mamba)
 2.  Clone the repository
 
			git clone https://github.com/zgr2788/AlignPip-crossBBR.git
4. Put the `sampleTable.csv` you would like to use within the main directory
5. Run `make` and follow the steps
6. Adjust settings through config.yaml
7. **(Optional)** Run `dag.sh` to get a directed acyclic graph (DAG) of the jobs
8. Set up all cluster variables in `pip.sh`, defaults are for SLURM manager
9. Run job through `pip.sh` or on local through `snakemake` 

### Appendices
#### Sample DAG
<img src="https://github.com/zgr2788/AlignPip-crossBBR/blob/main/dag_minimal.png"/> 

#### Notes 
A total of **480 runs** were downloaded with this pipeline of which **213** were **single-end** and **267** were **paired-end** runs.
