#' ---
#' title: "Load Data"
#' author: "David Wolski"
#' date: Apr 28th, 2016"
#' ---
#' This script will only work with the raw data in ./data/ which is stored 
#' locally.

# Options ---------------------------------------------------------------------

# Load Packages
library(affy) # for Affymetrix chips

# Source functions
source(file = "./R/hu-functions.R")

# Set global options
options(stringsAsFactors = FALSE)

# Code ------------------------------------------------------------------------

# Set microarray raw data and phenotype paths
data_path <- "~/Syncplicity Folders/Work/Data/Microarray/MultiVirus/raw data/"
pheno_path <- "~/Syncplicity Folders/Work/Data/Microarray/MultiVirus/phenodata/"

# Set list of data sets to be used
virus_list <- list(HCVn = "HCV_new")

# Define custom CDF files
custom_cdf <- list("HG-U133A_2" = "HGU133A2_Hs_ENTREZG")

# Load microarray data with custom cdf (Brainarray)
virus_dat <- lapply(virus_list, load_arrays, custom_cdf = custom_cdf)

# Save data to .RData to be used in downstream analysis
save(virus_dat, file = "output/input_data.RData")


