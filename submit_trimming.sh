#!/bin/bash
#SBATCH --job-name=(fast?)p
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=8G
#SBATCH --output=my_job.%j.out
#SBATCH --error=my_job.%j.err

cd /cluster/scratch/gomest/systems_genomics/rawdata/trimmed_dedup
source /cluster/home/gomest/miniconda3/etc/profile.d/conda.sh
conda activate systems_genomics
for file in ../*_1.fastq.gz; do
 file2="${file/_1/_2}"
 fastp --dedup --adapter_sequence CTGTCTCTTATACACATCT -l 25 -i $file -I $file2  -o "./$(basename "${file/_1/_1T}")" -O "./$(basename "${file/_1/_2T}")"
 fastqc --outdir fastqc "./$(basename "${file/_1/_1T}")"  "./$(basename "${file/_1/_2T}")"
done
