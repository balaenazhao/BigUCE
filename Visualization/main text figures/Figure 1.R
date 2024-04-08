library(ggtree)
library(ape)
library(geiger)
library(ggplot2)
library(treeio)

new_tree<- read.tree("genus_tree.tre")

########### get MRCA node number ###########
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
oscineNum<- getMRCA(new_tree,oscine)
suboscineNum<- getMRCA(new_tree,suboscine)
AustralavesNum<- getMRCA(new_tree,Australaves)
AfroavesNum<- getMRCA(new_tree,Afroaves)
StrisoresNum<- getMRCA(new_tree,Strisores)
GalloanseraeNum<- getMRCA(new_tree,Galloanserae)
PalaeognathaeNum<- getMRCA(new_tree,Palaeognathae)
PhaethoquornithesNum<- getMRCA(new_tree,Phaethoquornithes)
ColumbimorphaeNum<- getMRCA(new_tree,Columbimorphae)
OtidimorphaeNum<- getMRCA(new_tree,Otidimorphae)
MirandornithesNum<- getMRCA(new_tree,Mirandornithes)

########### plot fan tree with major groups color shaded ###########
data<- read.csv(file="./tip state.csv",header=TRUE)
data_tree <- full_join(new_tree, data, by='label')
p<- ggtree(data_tree, layout="fan") + 
  geom_hilight(node=AustralavesNum, fill="#7bbcc4d9", alpha=.6) +
  geom_hilight(node=AfroavesNum, fill="#f9fa9ccc", alpha=.6) +
  geom_hilight(node=StrisoresNum, fill="#c7ab6ecc", alpha=.6) +
  geom_hilight(node=GalloanseraeNum, fill="#b68dafcc", alpha=.6) +
  geom_hilight(node=PalaeognathaeNum, fill="#47976fff", alpha=.6) +
  geom_hilight(node=PhaethoquornithesNum, fill="#45b4f8bf", alpha=.6) +
  geom_hilight(node=ColumbimorphaeNum, fill="#d9dbf4ff", alpha=.6) +
  geom_hilight(node=OtidimorphaeNum, fill="#f88b7cbf", alpha=.6) +
  geom_hilight(node=MirandornithesNum, fill="#ffb2d2ff", alpha=.6)

########### add in clade name as color stripes surrounding the genus tree ###########
clade<- as.matrix(data[,3])
rownames(clade) <- data[,1]
colnames(clade)[1] <- "clade"
col_clade<- c("#7bbcc4d9","#f9fa9ccc","#c7ab6ecc","#b68dafcc","#47976fff","#45b4f8bf","#d9dbf4ff","#f88b7cbf","#ffb2d2ff","lightgray","lightgray","lightgray")
breaks_clade<- c("Australaves","Afroaves","Strisores","Galloanserae","Palaeognathae","Phaethoquornithes","Columbimorphae","Otidimorphae","Mirandornithes","CHARADRIIFORMES","GRUIFORMES","OPISTHOCOMIFORMES")
p1<- gheatmap(p, clade, offset=0.005,width=0.05, colnames = FALSE) +
  scale_color_manual(values = col_clade, breaks = breaks_clade) +
  scale_fill_manual(values = col_clade, breaks = breaks_clade,name="clade")

########### add in genus monophyly as color bars surrounding the genus tree ###########
mono<-as.matrix(data[,7])
rownames(mono) <- data[,1]
colnames(mono)[1] <- "monophyly"
col_mono<- c("#4682b4ff","#b22222ff","#D7D7D7")
breaks_mono<- c("mono","non-mono","monotypic")

pdf(file="R_plot_output.pdf",width=10, height=10)

gheatmap(p, mono, offset=0.005,width=0.05, colnames = FALSE) +
  scale_color_manual(values = col_mono, breaks = breaks_mono) +
  scale_fill_manual(values = col_mono, breaks = breaks_mono,name="Monophyly")

dev.off()


############### plot supplementary tree figure with tip labels ###########

pdf(file="Figure S5 genus tree.pdf",width=10, height=10)

p + geom_tiplab(aes(angle=angle), color='black',size=0.6)

dev.off()
