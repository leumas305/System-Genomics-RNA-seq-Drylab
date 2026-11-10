cd /home/scratch/gomest/systems_genomics
mkdir -p rawdata
cd rawdata
prefetch --option-file ../SRR_Acc_List.txt
fastq-dump --gzip --split-3 SRR*/*.sra
cd ..
mkdir -p genome
cd genome
wget https://hgdownload.soe.ucsc.edu/goldenPath/mm39/bigZips/mm39.fa.gz
gzip -d mm39.fa.gz
wget -O gencode.vM39.annotation.gtf.gz https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M39/gencode.vM39.annotation.gtf.gz
gzip -d gencode.vM39.annotation.gtf.gz
cd ..
mkdir -p /rawdata/trimmed_dedup
