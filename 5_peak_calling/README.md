# Peak Calling using Macs2
```
macs2_peak.sh bamfile out

# bamfile: input bam file
# out: output name prefix
```

Model-based Analysis of ChIP-Seq identifies transcript factor binding sites.
MACS captures the influence of genome complexity to evaluate the significance of enriched ChIP regions, 
and MACS improves the spatial resolution of binding sites through combining the information of both sequencing tag position and orientation.
MACS can be easily used for ChIP-Seq data alone, or with control sample with the increase of specificity.

By default, the aligned reads are extended to a fixed-size of 200 bp and shifted by 100 bp.
The function will create a folder filled with peak files of different formats including excel, narrowpeak, and bed.

[Github page for MACS2](https://github.com/taoliu/MACS)

# Peak Calling using Homer

Peak Calling in Homer is broken up among 3 scripts

```
homer_tagdir.sh bamfile out

# bamfile: input .bam file
# out: output name prefix
```
This function will index the read alignments into a more organized directory. This sorting method also provides numerical summaries of the dataset. The created tag directory will be the primary source of data used in the following functions.

[For more information](http://homer.ucsd.edu/homer/ngs/tagDir.html)

```
homer_peakcalling.sh tagdir out gsize

# tagdir: input tag directory
# out: output name prefix
# gsize: estimate size of genome for that specific tag directory
```
This function will call peaks from the tag directory and create 2 output peak files, one of them being a .bed file. The 
