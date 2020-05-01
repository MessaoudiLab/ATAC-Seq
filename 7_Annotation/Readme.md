# Annotating using ChipSeeker

After read mappings and peak callings, the peak should be annotated to answer the biological questions. 
Annotation also create the possibility of integrating expression profile data to predict gene expression regulation. 
ChIPseeker(Yu, Wang, and He 2015) was developed for annotating nearest genes and genomic features to peaks. 

ChIPseeker is an R package for annotating ChIP-seq data analysis. 
It supports annotating ChIP peaks and provides functions to visualize ChIP peaks coverage over chromosomes and profiles of peaks binding to TSS regions.

## Prerequisites
### R module in computer cluster
To access the included R module in the computer cluster, simply execute "R" in the command line.

To exit the R module and return to the unix shell, execute "q()" in the command line.

### Peak file
The peak file must be a GRanges object rather than the .bed format. 

To convert to a GRanges object, the columns in the bed file must be in proper sequence.
The first three columns must be "chromosome, start, stop"
Additionally, make sure to add "chr" to the beginning of each value in the chromosome column if you're going to use a reference genome in UCSC format.
The *awk* function can be used to reorder the columns and recursively add "chr".

Follow the following code to import the peak file and convert in R once the bed file is ready.

```
library(GenomicRanges)
bed <- read.delim("/directory/pathway/file")
bed
colnames(bed)[1:3] <- c("chromosome", "start", "stop")
peak <- makeGRangesFromDataFrame(bed, keep.extra.columns = TRUE)
```

### Reference genome
The reference genome must be in a TxDb object.
If it's in a GFF or GTF format, follow the following code to convert the object to TxDb.

```
library(GenomicFeatures)
txdb <- makeTxDbFromGFF("/directory/pathway/file", organism = Homo sapiens)
```

## Installation
```
install.packages("BiocManager")
library(BiocManager)
BiocManager :: install("ChIPseeker")
library(ChIPseeker)
```

## Step 1: Peak Annotation
```
peakAnno <- annotatePeak(peak, tssRegion = c(-1000,100), TxDb = txdb, annoDb = "org.Hs.eg.db")
write.table(as.data.frame(peakAnno), "annotated_peaks.txt", sep ="\t", quote = FALSE, row.names = FALSE)
```

## Step 2: Plot Annotation Pie Chart
```
pdf("AnnoPie.pdf")
plotAnnoPie(peakAnno)
dev.off()
```

[For more Information](https://www.bioconductor.org/packages/release/bioc/vignettes/ChIPseeker/inst/doc/ChIPseeker.html)
