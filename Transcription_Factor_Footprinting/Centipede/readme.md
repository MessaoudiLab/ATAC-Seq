# Centipede

## Introduction
CENTIPEDE is a computational method to infer if a region of the genome is bound by a particular TF. It uses information from a DNase-Seq experiment about the profile of reads surrounding a putative TF binding site. Further, it is able to incorporoate prior information such as sequence conservation across species.

Use of a computer cluster is highly recommended as this data analysis requires a genome reference file and a .bam file, both of which will be several gigabytes in size. 
## Prerequisite Software

### Meme Suite

### Centipede
Go to the MEME Suite download page to find the latest version of software:
http://meme-suite.org/doc/download.html

wget http://meme-suite.org/meme-software/4.10.1/meme_4.10.1_4.tar.gz tar xf meme_4.10.1_4.tar.gz
cd meme_4.10.1
./configure --prefix=$HOME/meme --with-url="http://meme-suite.org" make
make install
Add the $HOME/meme/bin folder to your PATH after you execute the above commands. You’ll probably want
to add this line to your .bashrc or similar. export PATH="$PATH:$HOME/meme/bin"

### Rsamtools

### Bedtools

## Prereqisite Data
1. **Position Weight Matrix**: a probability table describing TF motifs; [search here](https://ccg.vital-it.ch/pwmtools/pwmbrowse.html)
2. **Reference Genome**: .fa file of the subject species genome
3. **.bed data file**: sequencing data derived from prior atac-seq analysis; filtered for statistically significant peaks preferred

## References
