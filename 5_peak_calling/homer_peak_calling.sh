#!/bin/bash -l

tagdir=$1
shift
out=$1
shift
gsize=$1
shift

module load samtools
module load bedtools

# Find Peaks
# Configure path to Homer and options
/bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/Homer/bin/findPeaks $tagdir -o $out -gsize $gsize minDist 150 -region -fdr 0.05

# Convert to Bed file
/bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/Homer/bin/pos2bed.pl $out | bedtools sort | bedtools merge > $out.peaks.bed


