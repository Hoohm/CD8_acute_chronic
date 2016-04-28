
#The RData contains three dataframes. One annotation, one expression and one corrected expression. The RUV one is centered around zero. It hought it would be best to have both to test out. I'm afraid the zero centered will mess with the data if we use combat
load(Zehn_data.RData)
###Mouse human mapping. (I'm sorry but I actually could not download it from biomart, the server was down or something)
load()
##First step: Simple PCA, see if our different phenotypes actually group. I doubt it since the biggest difference would probably be the human/mouse factor. Maybe we can subset our data in order to work on genes that might be more related to the phenotype than the species.