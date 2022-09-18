# Paired end reads count script
#
# @zgr2788


args <- commandArgs(trailingOnly = TRUE)


# Init libs
library("Rsubread")
library("BiocParallel")

tableText <- args[1]
annotFile <- args[2]
threads <- as.numeric(args[3])

# Register threads
register(MulticoreParam(threads))

# Get filenames
sampleTable <- scan(tableText, sep = "\n", what = "")
filenames <- paste0("Paired/", sampleTable, "/", sampleTable, ".bam")

# Run featureCounts
fc <- featureCounts(files = filenames, annot.ext = annotFile, isGTFAnnotationFile = TRUE, isPairedEnd = TRUE, nthreads = threads)
colnames(fc$counts) <- sampleTable

# Write and exit
write.csv(fc$counts, "Paired/counts_paired.csv")
