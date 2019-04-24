args <- commandArgs(TRUE)
inFile <- args[1]
basename <- tools::file_path_sans_ext(inFile)
outFile <- paste(basename, ".shift.bam", sep="")

library(ATACseqQC)
library(BSgenome.Hsapiens.UCSC.hg38)
gal <- readBamFile(inFile, asMates=TRUE)
shiftbam <- shiftGAlignmentsList(gal, positive = 4L, negative = 5L)
export(shiftbam, outFile)
