# Differential Binding Analysis in R

The script included in this folder is a distilled version of the full manual, adjusted to work with the computer cluster.

Most changes address how to export the resulting plots and visuals from the analysis.

The last change differentiates the object name that information is saved under, during each step. 
Doing so ensures that the user doesn't accidentally overwrite an object with errors or incorrect information.
The first major step of the process, labeled "3.2 Counting reads" in the full manual, can take hours to complete.

## Introduction
## Prerequisites
### R module in computer cluster
To access the included R module in the computer cluster, simply execute "R" in the command line.

To exit the R module and return to the unix shell, execute "q()" in the command line.

### Targets file
The targets file is a csv formatted matrix containing the information describing the experimental conditions as well as the directory pathways for the read files required.
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
* “raw”: text file file; peak score is in fourth column
* “bed”: .bed file; peak score is in fifth column
* “narrow”: default peak.format: narrowPeaks file
* “macs”: MACS .xls file
* “swembl”: SWEMBL .peaks file
* “bayes”: bayesPeak file
* “peakset”: peakset written out using pv.writepeakset
* “fp4”: FindPeaks v4
