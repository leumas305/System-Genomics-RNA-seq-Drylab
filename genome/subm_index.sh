sbatch --time=23:30:00 --ntasks=10 --mem-per-cpu=5G --wrap='STAR --runThreadN 10 --runMode genomeGenerate --genomeDir star-index --genomeFastaFiles mm39.fa'

