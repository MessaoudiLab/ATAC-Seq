#!/bin/bash -l

peaks=$1
shift
targettag=$1
shift
backtag=$1
shift
out=$1
shift

module load samtools
module load bedtools

/bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/Homer/bin/getDifferentialPeaks $peaks $targettag $backtag -P 0.05 > $out.positivefc.diffpeaks.txt
/bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/Homer/bin/getDifferentialPeaks $peaks $backtag $targettag -P 0.05 > $out.negativefc.diffpeaks.txt
