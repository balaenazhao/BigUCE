library(ape)
library(phangorn)
library(phytools)
library(TreeDist)

#### after running ete3 ###
data<- read.csv("RF_improved_methods_V2.csv",header=TRUE)
matrix<- xtabs(nRF ~ source + reference, data=data)

dist<- as.dist(matrix)

write.nexus.dist(dist, file = "RF_matrix_improved_methods_V2.nex", append = FALSE, upper = FALSE,
                 diag = TRUE, digits = getOption("digits"), taxa = TRUE)

#### estimate NJ tree using PAUP* ###
#### paup NJ_distance.nex
