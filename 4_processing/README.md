# QC for alignments

```
atac_processing.sh bamfile out

# bamfile: input bam formatted file
# out: output name prefix
```

The samtools module is used to remove all reads aligned to mitochondria, sex chromosomes, etc.
The Picard module is then used to remove PCR duplicates.
By default, the samtools filter is set for humans, keeping reads asigned to the first 22 pairs of chromosomes.
After each step, the bam file is re-indexed.

```
atac_shift.sh bamfile

# bamfile: input bam formatted file, after first processing step
```

The ATACseqQC package in R is used to shift the aligned reads.
By default, the positive strand is shifted 4 bp and the negative strand is shifted 5 bp.
The sh file is used to call the R script when submitting memory intensive jobs to the cluster.
  
