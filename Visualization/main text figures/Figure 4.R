library(ggplot2)
library(gridExtra)
library(tidyr)
library(dplyr)
library(RColorBrewer)

########## plot presence/absence matrix of clades ###########
clade<- read.csv("./clade_monophyly.csv")
clades<- c("Palaeognathae","Notopalaeognathae","Novaeratitae","Dinocrypturi","Galloanserae","Neoaves","Mirandornithes","Columbimorphae","Pteroclimesites","Otidimorphae","Musophagotides","Strisores","Vanescaves","Sedentaves","Letornithes","Daedalornithes","Phaethoquornithes","Phaethontimorphae","Aequornithes","Feraequornithes","Procellariimorphae","Pelecanimorphae","Pelecanes","Telluraves","Afroaves","Coraciimorphae","Cavitaves","Eucavitaves","Picocoraciades","Picodynastornithes","Australaves","Eufalconimorphae","Psittacopasseres")
Ylabels<- rev(clades)
p2<- ggplot(clade, aes(x=factor(tree, level=c("Full_RAxML","Full_IQTREE","indv_0_sites_50_loci_70","indv_0_sites_90_loci_50","indv_25_sites_90_loci_70","indv_50_sites_50_loci_50","indv_50_sites_50_loci_70","indv_50_sites_90_loci_90","supertree","DivideConquer")), 
                  y=factor(clade,level=Ylabels),
                  fill = presence, fsize=)) + geom_tile(color = "white") + 
  scale_fill_manual(values=c("#F0F0F0","#9ECAE1"),labels = c("Non-monophyletic","Monophyletic"))
pdf(file = "presence_absence_matrix.pdf", width = 6, height = 10)
p2 + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),axis.text=element_text(size=13))
dev.off()

