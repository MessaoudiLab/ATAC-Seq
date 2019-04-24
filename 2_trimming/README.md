# Trim-Galore 

```
atac_trim.sh pair1 pair2 fiveprime threeprime readlength quality

# fiveprime: number of basepairs to cut off fiveprime end
# threeprime: number of basepairs to cut off threeprime end
# readlength: minimum read length to include; suggested value: 20
# quality: Phred score for trimming low-quality ends; suggested value: 20
```

Trim-Galore uses a three step process to improve the quality of high throughput sequencing data before application of data analysis. 
The program will trim a determined number of base pairs from the ends, remove adaptor sequences from the 3' end, and then remove any resulting reads smaller than a determined length.
