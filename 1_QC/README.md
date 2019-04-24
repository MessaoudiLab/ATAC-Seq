# Quality Control using FastQC

```
atac_fastqc.sh pair1 pair2
```

FastQC reads a set of sequence files and produces from each one a quality control report consisting of a number of different modules, each one of which will help to identify a different potential type of problem in your data.
One command of this function will produce an individual report for the input read and its pair if pair-ended. 

Default settings for this script format the output in a fastq format, compressed.
Compressed files can be extracted using the "gunzip" command.
The report will be coded in html so it can be viewed using an internet browser.

### 
