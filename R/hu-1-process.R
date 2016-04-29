#' ---
#' title: "Data Processing"
#' author: "David Wolski"
#' date: Apr 28th, 2016"
#' ---
#' Process data for analysis use

# Options ---------------------------------------------------------------------

# Load Packages
library(affy) # for Affymetrix chips
library(frma) # frozen RMA
library(genefilter) # gene filtering
library(sva) # Batch effect removal

# Source functions
source(file = "./R/hu-functions.R")

# Set global options
options(stringsAsFactors = FALSE)

# Code ------------------------------------------------------------------------

# Load microarray data.
load(file = "output/input_data.RData")

# Preprocess data with frma
virus_frma <- lapply(virus_dat, frma)
rm(list = grep("..vecs",ls(), value = TRUE)) # remove lingering frma objects

# Optional step filtering on ENTREZIDs too
virus_subdat <- sapply(virus_frma, featureFilter)

# # Get EnsemblIDs for the probes. This part needs revision to make sure we get
# # unique entries for ENSEMBLIDs. In the meantime I'll only retrieve symbols
eset <- lapply(virus_subdat, replace_geneid, method = "SYMBOL")

# Replace array IDs with SampleIDs
eset <- lapply(eset, replace_sampleid, features = c("outcome","sample.name","time.frame"))

# Subset data by phenotypic stratification (dirty :|)
edata <- eset$HCVn
pheno <- pData(edata)
selection <- pheno$outcome!=0 & pheno$weeks < 64 # subset samples
edata <- edata[,selection]

# Remove batch effect from data, preserving time frame and outcome
edata <- byebatch(x = edata, batchvar = "batch", covars = c("outcome","time.frame"))

# Write out the data as RData
save(edata, file = "output/processed_data.RData")
