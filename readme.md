### Acute/Chronic CD8 Project

---

##### **HCV Data** 
**Date: (04-28-2016)**


##### Data Load
 - Loaded CEL files
 - Annotated with custom CDF from     [BrainArray](http://brainarray.mbni.med.umich.edu/Brainarray/Database/CustomCDF/genomic_curated_CDF.asp)
 - Annotated with clinical data
 
##### Processing
 - Normalized data using fRMA (_output: log2 transformed_)
 - Replaced Array IDs with human readable IDs
 - Replaced probe set IDs with gene symbols - 
(_Main reason for this is that human ENSEMBL gene IDs do not correspond to mouse ENSEMBL gene IDs, so we'll have to use ortholog IDs from bioMart to map them, but that's something that I couldn't do tonight._)
 - Subset the data using phenotypic constraints
 - Removed batch effects (ComBat) with _outcome_ and _time frame_ as covars
 - Saved data as ExpressionSet object (_unscaled_)