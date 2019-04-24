# Read Alignment using Bowtie2 and Samtools

```
atac_mapping_hg38.sh pair1 pair2 out

# out: output name prefix
```

Highthroughput sequencing data aligns to a determined reference genome.
The directory pathway to a reference genome must be adjusted appropriately.
After alignment, samtools will sort and index the output into a bam file.

This script sets bowtie2 to the "very-sensitive" preset, will only look for concordant reads, and will allow a maximum fragment length of 2000bp by default.

### Options for bowtie2
```
module load bowtie2
bowtie2 --h
```
http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml

### Options for samtools

http://www.htslib.org/doc/samtools.html
