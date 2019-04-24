#!/bin/bash -l

bamfile=$1
shift
out=$1
#echo $filename
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=3
#SBATCH --mem-per-cpu=3G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=$out.alignment.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC-Seq Processing"
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
module load samtools
module load picard
samtools view -b $bamfile 1 10 11 12 13 14 15 16 17 18 19 2 20 21 22 3 4 5 6 7 8 9 >  $out.temp.bam
samtools index $out.temp.bam
picard MarkDuplicates I=$out.temp.bam  O=$out.rmdup.bam M=$out.rmdup.metrics.txt REMOVE_DUPLICATES=TRUE
samtools index $out.rmdup.bam
samtools idxstats $out.rmdup.bam > $out_rmdup_idxstats.txt
rm $out.temp.bam
rm $out.temp.bam.bai
