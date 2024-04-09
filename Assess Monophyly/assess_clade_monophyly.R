library(ape)
library(MonoPhy)

####### read and prune outgroup; tested on a single tree first #######
phy <- read.tree("x_rooted.tre")
is.rooted(phy)
outgroup<- c("OUTGROUP_Alligatoridae_Alligator_mississippiensis","OUTGROUP_Gavialidae_Gavialis_gangeticus")
tree<- drop.tip(phy,tip=outgroup,trim.internal=TRUE)
is.rooted(tree)

####### create a list for all the target rooted trees #######
folder <- c(".")
trees <- list.files(folder, full.names = F, pattern = "rooted.tre")

####### test monophyly for the genus level ####### 
####### iterate through all the trees ####### 

sink("Genus_output.txt",append=T)

for (i in trees) {
  directory<- paste(folder, "/", i, sep = "")
  phy<- read.tree(directory)
  tree<- drop.tip(phy,tip=outgroup,trim.internal=TRUE) ### read in tree and drop outgroup
  
  ### matche the tip names on the tree
  ### extra names are taxa that are in the main table but not in the tree
  taxonomy <- read.csv("./taxonomy_file.csv", header=TRUE)
  extra_names <- taxonomy[is.na(match(as.character(taxonomy$Tip_Name),tree$tip.label)),]
  taxonomy <- taxonomy[!is.na(match(as.character(taxonomy$Tip_Name),tree$tip.label)),]
  
  ### select the taxonomic level: Order, Family, Genus, or level0-7
  ### here tested on Genus level
  Genus <- as.data.frame(taxonomy[,c(2, grep("Genus", colnames(taxonomy)))]) ### 2 is the column number of "Tip_Name"; might need to change if formatted differently
  test_Genus <- AssessMonophyly(tree, Genus)
  
  ### print out results depending on needs
  print(i)
  print(GetSummaryMonophyly(test_Genus))
  #print(GetResultMonophyly(test_Genus))
  #print("intruders")
  #print(GetIntruderTips(test_Genus))
  #print("outliers")
  #print(GetOutlierTips(test_Genus))
}

sink()

####### select a different taxonomic level: Order, Family, Genus, or level0-7 #######
####### sink to a new file #######



