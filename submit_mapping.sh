#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=5G

cd /cluster/scratch/gomest/systems_genomics
if [ ! -e mapping_transcriptome ]; then
 mkdir mapping_transcriptome
fi
if [ ! -e rsem ]; then
 mkdir rsem
fi

mkdir -p genome/rsem_mm39_gencode39
rsem-prepare-reference --gtf genome/gencode.vM39.annotation.gtf \
 genome/mm39.fa \
 genome/rsem_mm39_gencode39/rsem_mm39_gencode39

for id in `cat SRR_Acc_List.txt`; do
 echo "start to process sample $id"
 echo " mapping started"
 mkdir -p mapping_transcriptome/$id
 STAR --genomeDir genome/star-index \
 --runThreadN 10 \
 --readFilesIn rawdata/trimmed_dedup/${id}*.fastq.gz \
 --readFilesCommand zcat \
 --sjdbGTFfile genome/gencode.vM39.annotation.gtf \
 --quantMode TranscriptomeSAM \
 --outSAMtype BAM SortedByCoordinate \
 --outFileNamePrefix mapping_transcriptome/$id/
 echo " mapping done"
 echo "rsem started"
 mkdir -p rsem/$id
 num_fa=`ls -1 rawdata/trimmed_dedup/${id}*.fastq.gz | wc -l`
 if [ $num_fa -eq 1 ]; then
 rsem-calculate-expression --alignments \
 -p 10 \
mapping_transcriptome/$id/Aligned.toTranscriptome.out.bam \
 genome/rsem_mm39_gencode39/rsem_mm39_gencode39 \
rsem/$id/$id
 else
 rsem-calculate-expression --alignments \
 --paired-end \
-p 10 \
-q \
mapping_transcriptome/$id/Aligned.toTranscriptome.out.bam \
 genome/rsem_mm39_gencode39/rsem_mm39_gencode39 \
rsem/$id/$id
 fi
 echo " rsem done"
done
