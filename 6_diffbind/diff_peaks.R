#NOT OPTIMIZED TO BE RAN AS A FUNCTION

library(DiffBind)

targets <- dba(sampleSheet="targets.csv")

# Choose whether to re-center peaks around summits; this step will take some time
# Default count score is TMM normalized, can change to raw
targets.count <- dba.count(targets, summits=250)
#targets.count <- dba.count(targets, summits=250, score=DBA_SCORE_READS)

# Retrieve Consensus Peak Set
targets.peakset <- dba.peakset(dba.count, bRetrieve = TRUE)

# Establish which column to base contrast
targets.contrast <- dba.contrast(targets.count, categories=DBA_CONDITION)
# categories: DBA_ID, DBA_TISSUE, DBA_FACTOR, DBA_CONDITION, DBA_TREATMENT
#	DBA_REPLICATE

# Perform differential analysis
targets.analyze <- dba.analyze(targets.contrast)

# Retrieve differentially bound sites
targets.DB <- dba.report(targets.analyze)
write.table(targets.DB, "deseq.text", sep = "\t", quote = FALSE, row.names = FALSE)

# Plot Correlation Heatmap
pdf("Cluster.pdf")
plot(targets.analyze, contrast=1)
dev.off()

# Plot PCA (adjust label if necessary)
pdf("PCA.pdf")
dba.plotPCA(targets.analyze, contrast=1, label=DBA_REPLICATE)
dev.off()

# Plot MA
pdf("MA.pdf")
dba.plotMA(targets.analyze)

# Plot Volcano
pdf("Volc.pdf")
dba.plotVolcano(targets.analyze)
dev.off()

# Plot Heatmap of binding affinity
pdf("Heat.pdf")
dba.plotHeatmap(targets.analyze, contrast=1, correlations=FALSE)
dev.off()

corvals <- dba.plotHeatmap(targets, contrast=1, correlations=FALSE)
write.table(corvals, "binding_affinity_heat.txt", sep = "\t", quote = FALSE, row.names = FALSE)


