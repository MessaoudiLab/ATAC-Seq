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
