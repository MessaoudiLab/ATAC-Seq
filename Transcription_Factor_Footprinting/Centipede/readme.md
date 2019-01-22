# Centipede **(INCOMPLETE)**

## Introduction
CENTIPEDE is a computational method to infer if a region of the genome is bound by a particular TF. It uses information from a DNase-Seq experiment about the profile of reads surrounding a putative TF binding site. Further, it is able to incorporoate prior information such as sequence conservation across species.

Use of a computer cluster is highly recommended as this data analysis requires a genome reference file and a .bam file, both of which will be several gigabytes in size. 
## Prerequisite Software

### Meme Suite
Meme suite is installed on the cluster, but for unknown reasons, this workflow currently only functions if the data processing of the Meme suite is completed on a local computer.

Go to the MEME Suite download page to find the latest version of software:
http://meme-suite.org/doc/download.html
```
wget http://meme-suite.org/meme-software/4.10.1/meme_4.10.1_4.tar.gz tar xf meme_4.10.1_4.tar.gz
cd meme_4.10.1
./configure --prefix=$HOME/meme --with-url="http://meme-suite.org"
make
make install
```
Add the $HOME/meme/bin folder to your PATH after you execute the above commands. You’ll probably want
to add this line to your .bashrc or similar. export PATH="$PATH:$HOME/meme/bin"

### Centipede
CENTIPEDE is an R package, so you must download and install R if you don’t already have it installed. Next, install CENTIPEDE with these commands in your shell (not in R):
```
wget http://download.r-forge.r-project.org/src/contrib/CENTIPEDE_1.2.tar.gz 
R CMD INSTALL CENTIPEDE_1.2.tar.gz
```
Start an R session and load the package:
```
library(CENTIPEDE)
library(CENTIPEDE.tutorial)
```

### Rsamtools
Rsamtools is an R package available through bioconductor as well as being availabe through the cluster.
```
source("http://bioconductor.org/biocLite.R")
biocLite("Rsamtools")
```

### Bedtools
Bedtools is already installed on the cluster, but does need to be loaded for every new session
```
module load bedtools
module list
```

## Prereqisite Data
1. **Position Weight Matrix**: a probability table describing TF motifs; [search here](https://ccg.vital-it.ch/pwmtools/pwmbrowse.html)
2. **Reference Genome**: .fa file of the subject species genome
3. **.bed data file**: sequencing data derived from prior atac-seq analysis; filtered for statistically significant peaks preferred

## Step 1: PWM > Meme file
```
Directory/Pathway/matrix2meme < <(tail -n+2 PWM.txt | cut -f2-) > PWM.meme
cat PWM.meme
```
example pathway: meme/libexec/meme-5.02/matrix2meme

Upload the meme file to the cluster through cyberduck and you can now work exclusively in the cluster.

## Step 2: Find Putative TF binding Sites
Prepare reference genome and atac-seq data files; reference genome should be .fa and data set should be compressed into .gz

Obtain nucleotide sequences within peaks:
```
genome=ReferenceGenome.fa
data_gz=Data.gz
data_fasta=Data.fa

bedtools getfasta -fi $genome -bed $data_gz -fo $data_fasta
```

Search for sequences within these peaks that match the PWM (do this on local cpu):
```
meme=PWM.meme
sites=PWM.fimo.txt.gz

Directory/Pathway/fimo --text --parse-genomic-coord $meme $dnase_fasta | gzip > $sites

zcat $sites | head
```

## Determine if TF sites are bound
Start and R session in cluster:
```
library(Rsamtools)
library(CENTIPEDE)
library(CENTIPEDE.tutorial)
```

Count read start positions within (100) bp up or downstream of PWM match sites that were determined statistically significant by FIMO (P < 1e-4).
```
cen <- centipede_data(bamfile = ".bam", fimo_file = "fimo.txt.gz", pvalue = 1e-4, flank_size = 100)

head(cen$regions)
```
The cen object will contain 2 objects: 
  1. **regions**: dataframe with one row for each PWM region
  2. **mat**: matrix with read counts for each PWM region.

Do note how many columns **mat** object contains. In the coming plot object, the first half of the columns represent the positive strand while the second half of the columns represent the negative strand.
Do note which row you would like to plot in **mat**object.

```
plot(cen$mat[#row,], xlab = "Position", ylab = "Read Start Sites", type = "h",
  + col = rep(c("blue", "red"), each = 213))
abline(v = c(100, 113, 313, 326) + 0.5, lty = 2)
abline(v = 213 + 0.5)
```
Pay attention to argument **each** as it refers to the midway point between positive and negative strands; similarly the numbers in abline functions need to also correspond with motif length.

To see how many read starts occur in each region:
```
rowSums(cen$mat)[1:10]
```

### Compute posterior probability that a TF is bound:
```
library(CENTIPEDE)
fit <- fitCentipede(Xlist=list(DNase=cen$mat),Y=as.matrix(data.frame(Intercept=rep(1,nrow(cen$mat)))))
```

How many sites have a posterior probability of 1?
```
sum(fit$PostPr == 1)
```

Plot heatmap of count matrix
```
imageCutSitesCombined(cen$mat [fit$PostPr == 1,])
```
### Plot footprint estimated by Centipede
```
plotProfile(fit$LambdaParList[[1]], Mlen = #)
```
where **Mlen** is length of Motif

## Discussion
This tutorial does not deviate to much from the original as the only changes needed to be made regarded the cpu interface on which this workflow would work. The cluster is the primary interface, but currently the functions of MEME suite in creating the fimo text file does not work in the cluster.

Additionally, make sure that all files are indexing the chromosomes similarly as some files may call them "chr #" or just by the #.
## References
Original tutorial in repository

Written by Brian Ligh
