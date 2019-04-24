# Read Alignment using Bowtie2 and Samtools

```
atac_mapping_hg38.sh pair1 pair2 out

# out: output name prefix
```

This script aligns highthroughput sequencing data to a determined reference genome and outputs a bam file by default.
The directory pathway to a reference genome must be adjusted appropriately. 
After alignment, samtools will sort and index the newly created bam file. 

This script sets bowtie2 to the "very-sensitive" preset, will only look for concordant reads, and will allow a maximum fragment length of 2000bp by default.

