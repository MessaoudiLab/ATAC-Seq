#!/bin/bash -l

pair1=$1
shift
pair2=$1
shift
out=$1

#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3G
#SBATCH --time=24:00:00     # 1 day and 15 minutes
#SBATCH --output=my.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC alignment"
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
module load bowtie2
module load samtools
module load picard
#Pairwise alignment and conversion to bam file format
bowtie2 -p 10 -t -X 2000 -k 1 --very-sensitive --no-discordant --no-mixed -x ../../ref/Homo_sapiens.GRCh38.dna.primary_assembly.fa -1 $pair1 -2 $pair2 | samtools view -b -S -q 10 -F 3844 - | samtools sort -o $out.concordant.hg38.bam -
samtools index $out.concordant.hg38.bam


