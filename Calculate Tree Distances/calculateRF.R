library(ape)
library(phangorn)
library(phytools)
library(TreeDist)

#### after running ete3 ###
data<- read.csv("RF.csv",header=TRUE)
matrix<- xtabs(nRF ~ source + reference, data=data)

dist<- as.dist(matrix)

write.nexus.dist(dist, file = "Robinson_Foulds_distances.nex", append = FALSE, upper = FALSE,
                 diag = TRUE, digits = getOption("digits"), taxa = TRUE)

#### estimate NJ tree using PAUP* ###


