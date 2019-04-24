#!/bin/bash -l
pair1=$1
shift
pair2=$1
shift
fiveprime=$1
shift
threeprime=$1
shift
readlength=$1
shift
quality=$1
shift

#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=$out.trimgalore.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC-Seq Trimming
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
module load fastqc
module load trim_galore
trim_galore -q $quality --paired --clip_R1 $fiveprime --clip_R2 $fiveprime --three_prime_clip_R1 $threeprime --three_prime_clip_R2 $threeprime -o . --gzip --fastqc --length $readlength $pair1 $pair2
