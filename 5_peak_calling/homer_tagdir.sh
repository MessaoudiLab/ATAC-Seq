#!/bin/bash -l

out=$1
shift
bamin=$1
shift

module load samtools

# Configure pathway to Homer
/bigdata/messaoudilab/ssure003/Projects/Maob_Mom_CD14_ATAC/paper-jan2019/scripts/Homer/bin/makeTagDirectory $out $bamin
