#' ---
#' title: "Project Functions"
#' author: "David Wolski"
#' date: Apr 28th, 2016"
#' ---
#' This script contains functions needed in the analysis.

# Load arrays and annotate with pheno data ------------------------------------
load_arrays <- function(x, custom_cdf = custom_cdf, ...) {
  dat <- ReadAffy(celfile.path = paste0(data_path, x), ...)
  dat@cdfName <- custom_cdf[[dat@cdfName]]
  pheno <- read.csv(file = paste0(pheno_path, x, "_pheno.txt"), 
                    row.names = 1, sep = "\t",
                    stringsAsFactors = FALSE)
  pData(dat) <- pheno[colnames(dat),]
  dat
}

# replace gene identifier in your expression set ------------------------------
replace_geneid <- function(eset, method = "SYMBOL"){
  db <- get(paste0(annotation(eset),".db"))
  featureNames(eset) <- gsub("_at", "", featureNames(eset))
  annot_frame <- AnnotationDbi::select(db, keys=featureNames(eset),
                                       columns=c("SYMBOL","GENENAME"),
                                       keytype="ENTREZID")
  featureNames(eset) <- annot_frame[,method]
  eset
}

# Replace sample identifier in your expression set ----------------------------
replace_sampleid <- function(eset, features) {
  new_id <- paste_custom(pData(eset),features)
  pData(eset)$array.name <- sampleNames(eset)
  sampleNames(eset) <- new_id
  eset <- eset[,order(sampleNames(eset))]
  eset
} 

# Paste variable columns ------------------------------------------------------
paste_custom <- function(x, v, ...) {
  apply(x[,v], 1, paste, collapse = "_")
}

# Custom Batch removal, currently only for one batch --------------------------

byebatch <- function(x = eset, batchvar, covars, ...) {
  pheno <- pData(x)
  edata <- exprs(x)
  batch <- paste0(pheno[,batchvar])
  if (length(unique(batch))> 1) {
    formel <- as.formula(paste("~ ",paste(covars,collapse="+")))
    mod <- model.matrix(formel , data = pheno)
    combat_edata <- ComBat(dat = edata, batch = batch, mod = mod)
    exprs(x) <- combat_edata
  }
  else {
    exprs(x) <- edata    
  }
  return(x)
}

