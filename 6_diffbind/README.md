# Differential Binding Analysis in R

The script included in this folder is a distilled version of the full manual, adjusted to work with the computer cluster.

Most changes address how to export the resulting plots and visuals from the analysis.

The last change differentiates the object name that information is saved under, during each step. 
Doing so ensures that the user doesn't accidentally overwrite an object with errors or incorrect information.

## Prerequisites
### R module in computer cluster
To access the included R module in the computer cluster, simply execute "R" in the command line.

To exit the R module and return to the unix shell, execute "q()" in the command line.

### Targets file
The targets file is a csv formatted matrix containing the information describing the experimental conditions as well as the directory pathways for the read files required. Reference targets_file_example.csv in this folder.

The first six columns of the targets file are listed as follows:
1. Sample ID
2. Tissue
3. Factor
4. Condition
5. Treatment
6. Replicate

These columns will serve as potential explanatory variables for the analysis. Unused cells are labeled as "NA."

The seventh column, "bamReads," contains the corresponding .bam formatted aligned reads for each sample. A full directory pathway is recommended to prevent the code from breaking should the user work from multiple directories. 

The eigth and ninth columns are only applicable if the user has a control bam file for the samples. In which case, "ControlID" will contain the ID's and "bamControl" will contain the file.

The tenth column, "Peaks," contains the peak file for the sample. The user can choose to use one of either the .narrowPeak, .xls, or .bed files from the output of the MACS2 function from the previous step. A full directory pathway is recommended.

The eleventh and final column, "PeakCaller," denotes the format of the corresponding peak file. The options are as follows:
* **raw**: text file file; peak score is in fourth column
* **bed**: .bed file; peak score is in fifth column
* **narrow**: default peak.format: narrowPeaks file
* **macs**: MACS .xls file
* **swembl**: SWEMBL .peaks file
* **bayes**: bayesPeak file
* **peakset**: peakset written out using pv.writepeakset
* **fp4**: FindPeaks v4

## Installation
```
install.packages("BiocManager")
library(BiocManager)
BiocManager :: install("DiffBind")
library(DiffBind)
```

## Step 1: Import Files into R
```
targets <- dba(sampleSheet="targets_file_example.csv")
```
This function simply saves the csv formatted targets file as a "dba object."
New information will be appended to this object in the following functions.

## Step 2: Counting Reads
```
targets.count <- dba.count(targets, summits=200)
```
This function calculates a binding matrix with scores based on read counts for every sample (affinity scores), rather than confidence scores for only those peaks called in a specific sample (occupancy scores).

The "summits" argument will recenter each peak with extensions of a determined number of base pairs on each side. In this example, the peaks will be recentered with an interval of 401 bp, 200 on each side.

The function will use RPKM normalized scores by default, but can be changed to raw read counts with the argument, "score = DBA_SCORE_READS."
Additional options for the score argument can be found in the bioconductor documentation.

Two columns will be appended to the object as a result: "Intervals" and "FRiP," denoting the consensus length peakset and FRiP score.

**Note**: This step will take around 5-10 minutes for each sample.  

## Step 3: Establishing a Contrast
```
targets.contrast <- dba.contrast(targets.count, categories=DBA_CONDITION)
```
This function establishes a contrast based on one of the metadata columns.

Full list of category labels used in this function and others to call metadata:
* DBA_ID
* DBA_TISSUE
* DBA_FACTOR
* DBA_CONDITION
* DBA_TREATMENT
* DBA_REPLICATE
* DBA_CALLER

## Step 4: Performing the Differential Analysis
```
targets.analyze <- dba.analyze(targets.contrast)
```
This function will run a DESeq2 analysis using the binding affinity matrix and established contrast. The resulting dba object will show the number of statistically significant peaks out of the consensus set (FDR < 0.5). 

```
targets.report <- dba.report(targets.analyze)
write.table(targets.report, "deseq.txt", sep = "\t", quote = FALSE, row.names = FALSE)
```
The dba.report function will retrieve the differentially bound sites and format a GRanges object. 
The value columns show the mean read concentration over all the samples (the default calculation uses log2 normalized ChIP read counts with control read counts subtracted) and the mean concentration over the first group and second group. 
The Fold column shows the difference in mean concentrations between the two groups, with a positive value indicating increased binding affinity in the first group and a negative value indicating increased binding affinity in the second group.
The final two columns give confidence measures for identifying these sites as differentially bound, with a raw p-value and a multiple testing corrected FDR in the final column.

## Step 5: Plotting
1. Plot Correlation Heatmap
```
pdf("Cluster.pdf")
plot(targets.analyze, contrast=1)
dev.off()
```
2. Plot PCA (adjust label if necessary)
```
pdf("PCA.pdf")
dba.plotPCA(targets.analyze, contrast=1, label=DBA_REPLICATE)
dev.off()
```
3. Plot MA
```
pdf("MA.pdf")
dba.plotMA(targets.analyze)
dev.off()
```
4. Plot Volcano
```
pdf("Volc.pdf")
dba.plotVolcano(targets.analyze)
dev.off()
```
5. Plot Heatmap of binding affinity
```
pdf("Heat.pdf")
dba.ploHeatmap(targets.analyze, contrast=1, correlations=FALSE)
dev.off()
```

## References
* [DiffBind tutorial](http://bioconductor.org/packages/release/bioc/vignettes/DiffBind/inst/doc/DiffBind.pdf)
* [Bioconductor Manual](https://bioconductor.org/packages/devel/bioc/manuals/DiffBind/man/DiffBind.pdf)

written by: Brian Ligh




