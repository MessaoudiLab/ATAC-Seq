#!/bin/bash -l

input=$1
shift
out=$1
shift
#echo $filename
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=$out.alignment.stdout
#SBATCH --mail-user=useremail@address.com
#SBATCH --mail-type=ALL
#SBATCH --job-name="ATAC Peak Calling"
#SBATCH -p highmem # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

#Load the packages
module load python
#Peak calling using MACS2. Calls peaks per samples and creates a bedgraph file for further down-stream differential peak analysis. B and SPMR ask MACS2 to generate pileup signal of fragment pileup per million reads in bedGraph format.
macs2 callpeak --name $out -t $input --outdir $out.peaks --nomodel -q 0.01 --keep-dup all -B --SPMR --shift 100 --extsize 200

#Measure fold enrichment. 
#macs2 bdgcmp -t $out.peaks/$out_treat_pileup.bdg -c $out/$out_control_lambda.bdg -o $out.peaks/$out_FE.bdg -m FE
#Measure log likelihood ratios
#macs2 bdgcmp -t $out.peaks/$out_treat_pileup.bdg -c $out/$out_control_lambda.bdg -o $out.peaks/$out_LR.bdg  -m logLR -p 0.00001
