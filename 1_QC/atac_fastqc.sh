#!/bin/bash -l

pair1=$1
shift
pair2=$1
shift
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=$out.fastqc.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC-Seq Quality"
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
module load fastqc
#module load trim_galore
#trim_galore -q 20 --paired  --three_prime_clip_R1 2 --three_prime_clip_R2 2 -o . --gzip --fastqc --length 35 $pair1 $pair2
fastqc -f fastq -o . --noextract $pair1 $pair2
