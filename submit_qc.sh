#!/bin/bash
#SBATCH --time=24:00:00
cd /cluster/scratch/gomest/systems_genomics/rawdata
pwd
source /cluster/home/gomest/miniconda3/etc/profile.d/conda.sh
conda activate systems_genomics
fastqc --outdir fastqc *.fastq.gz &> fastqc/output_logs.txt
pwd
