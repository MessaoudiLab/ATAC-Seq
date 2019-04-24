#!/bin/bash -l

bam=$1
shift

#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=10G
#SBATCH --time=24:00:00     # 1 day and 15 minutes
#SBATCH --output=my.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC alignment"
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
echo $bam
module load samtools
#Pairwise alignment and conversion to bam file format
Rscript /bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/atac-shift.R $bam

