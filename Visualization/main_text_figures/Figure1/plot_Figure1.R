library(ggtree)
library(ape)
library(geiger)
library(ggplot2)
library(treeio)

#### generate genus level phylogeny using RAxML-NG time tree #####
tree<- read.tree("full-raxml-itol-calibrations_2758.tre")

####### preparing time tree for plot ########
outgroup<- c("OUTGROUP_Alligatoridae_Alligator_mississippiensis","OUTGROUP_Gavialidae_Gavialis_gangeticus")
fulltree<- drop.tip(tree,outgroup,trim.internal=TRUE)

###### keep only one species to represent a monophyletic genus ########
source("/Users/balaena/Downloads/postdoc/BigUCE/Divergence_time/redundant_sp.R")
genus_tree<- drop.tip(fulltree,redundant_sp,trim.internal=TRUE)

################### for non-monophyletic genera #######################
################### dropping taxa to keep one for each clade ##########
source("/Users/balaena/Downloads/postdoc/BigUCE/Divergence_time/non_mono_sp.R")
new_tree<- drop.tip(genus_tree,non_mono_sp,trim.internal=TRUE)
write.tree(new_tree,file="genus_tree.tre")
### run modify_genus_name.sh in macOS command line ###

#########################################################################
### read in above genus tree ###
genus_tree<- read.tree("genus_tree.tre")

###### get MRCA number for major clades ########

oscine<- c("Menura","Ficedula")
suboscine<- c("Pitta","Antilophia")
Australaves<- c("Cariama","Ficedula")
Afroaves<- c("Accipiter","Ceyx")
Strisores<- c("Topaza","Eurostopodus")
Galloanserae<- c("Gallus","Anas")
Palaeognathae<- c("Rhea","Struthio")
Phaethoquornithes<- c("Eurypyga","Egretta")
Columbimorphae<- c("Columba","Mesitornis")
Otidimorphae<- c("Chlamydotis","Cuculus")
Mirandornithes<- c("Phoenicopterus","Podiceps")

oscineNum<- getMRCA(genus_tree,oscine)
suboscineNum<- getMRCA(genus_tree,suboscine)
AustralavesNum<- getMRCA(genus_tree,Australaves)
AfroavesNum<- getMRCA(genus_tree,Afroaves)
StrisoresNum<- getMRCA(genus_tree,Strisores)
GalloanseraeNum<- getMRCA(genus_tree,Galloanserae)
PalaeognathaeNum<- getMRCA(genus_tree,Palaeognathae)
PhaethoquornithesNum<- getMRCA(genus_tree,Phaethoquornithes)
ColumbimorphaeNum<- getMRCA(genus_tree,Columbimorphae)
OtidimorphaeNum<- getMRCA(genus_tree,Otidimorphae)
MirandornithesNum<- getMRCA(genus_tree,Mirandornithes)


##### plot fan tree with major groups color shaded
data<- read.csv(file="tip state.csv",header=TRUE)
data_tree <- full_join(genus_tree, data, by='label')
p<- ggtree(data_tree, layout="fan") + 
  geom_hilight(node=AustralavesNum, fill="#7bbcc4d9", alpha=.6) +
  geom_hilight(node=AfroavesNum, fill="#f9fa9ccc", alpha=.6) +
  geom_hilight(node=StrisoresNum, fill="#c7ab6ecc", alpha=.6) +
  geom_hilight(node=GalloanseraeNum, fill="#b68dafcc", alpha=.6) +
  geom_hilight(node=PalaeognathaeNum, fill="#47976fff", alpha=.6) +
  geom_hilight(node=PhaethoquornithesNum, fill="#45b4f8bf", alpha=.6) +
  geom_hilight(node=ColumbimorphaeNum, fill="#d9dbf4ff", alpha=.6) +
  geom_hilight(node=OtidimorphaeNum, fill="#f88b7cbf", alpha=.6) +
  geom_hilight(node=MirandornithesNum, fill="#ffb2d2ff", alpha=.6) +
  geom_hilight(node=CharadriiformesNum, fill="lightgray", alpha=.6) +
  geom_hilight(node=GruiformesNum, fill="lightgray", alpha=.6)


#### add in genus monophyly as color bars surrounding the genus tree
mono<-as.matrix(data[,7])
rownames(mono) <- data[,1]
colnames(mono)[1] <- "monophyly"
col_mono<- c("#4682b4ff","#b22222ff","#D7D7D7")
breaks_mono<- c("mono","non-mono","monotypic")

pdf(file="genus_tree.pdf",width=10, height=10)

gheatmap(p, mono, offset=0.005,width=0.05, colnames = FALSE) +
  scale_color_manual(values = col_mono, breaks = breaks_mono) +
  scale_fill_manual(values = col_mono, breaks = breaks_mono,name="Monophyly")

dev.off()


############### plot supplementary figure for tree with tip labels ###########

pdf(file="Figure S1 RAxML-NG genus time tree.pdf",width=10, height=10)

p + geom_tiplab(aes(angle=angle), color='black',size=0.6)

dev.off()
  
