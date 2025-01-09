library(ggplot2)
library(gridExtra)
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(ComplexHeatmap)
library(readr)
library(readxl)
library(paletteer)


########## plot number of non-monophyly for Figure 2 and Figure 4 ###########
mono_data_init<- read.csv("non-monophyly_initial_exploration.csv")
mono_data_new<- read.csv("non-monophyly_improved_methods_V2.csv")

### initial exploration
#data<- mono_data_init # Replicate original data
#data$Tree <- factor(data$Tree,                                    # Change ordering manually
#                  levels = c("1_OptimalTrees","2_BootstrapTrees","3_OptimalTrees+FamilyBackbone4v1",
#                             "4_OptimalTrees+FamBackbone2v1","5_OptimalTrees+GenusBackbone4v1",
#                             "6_OptimalTrees+GenusBackbone2v1","7_full_RAxML","8_full_IQ-TREE",
#                             "9_Filter: indv_0_sites_50_loci_70","10_Filter: indv_25_sites_90_loci_70",
#                             "11_Filter: indv_50_sites_90_loci_90","12_Filter: indv_50_sites_50_loci_50",
#                             "13_Filter: indv_50_sites_50_loci_70","14_Filter: indv_0_sites_90_loci_50",
#                             "15_PublishedTrees+Jetz+BigBird+Familybackbone","16_PublishedTrees+Jetz+BigBird+Genusbackbone",
#                             "17_PublishedTrees+Jetz+BigBird"))

### improved methods
data<- mono_data_new
data$Tree <- factor(data$Tree, levels = c("1_C12_MP_supertree","2_C14_MP_supertree","3_C18_MP_supertree",
                                          "4_D9_MP_supertree","5_D8_MP_supertree","6_full_raxml",
                                          "7_fulldata_parsD","8_02_G50_i0s50l50_parsB","9_01_F70_i0s50l70_parsCstart",
                                          "10_S19_MP_supertree","11_S9_MP_supertree","12_S16_MP_supertree",
                                          "13_S11_MP_supertree","14_S13_MP_supertree","15_12_F70_i50s90l70_parsDstart",
                                          "16_17_F50_i25s90l50_parsC","17_11_F90_i50s90l90_parsC"))
data$clade <- factor(data$clade, levels = c("Genus","family","order","Highlevel"))
p<- ggplot(data, aes(fill=clade, y=number, x=Tree)) + 
  geom_bar(position="stack", stat="identity") + scale_fill_manual(values = c("#b4bcce", "#d88c9a", "#ede0c5","#728c9a"))

pdf(file="R_nonMono_improved_methods_V2.pdf",width=10, height=6)
p
dev.off()


########## plot CPU hours for Figure 2 and Figure 4 #########

#CPU<- read.csv("CPU time.csv") # initial exploration
CPU<- read.csv("CPU_time_improved_methods_V2.csv")
my_table <- tableGrob(CPU)
pdf(file = "CPU_improved_methods_V2.pdf", width = 12, height = 6)
grid.arrange(my_table)
dev.off()


########## plot presence/absence matrix of clades in Figure 5 ###########
clade<- read.csv("clade_monophyly.csv")
clades<- c("Palaeognathae","Notopalaeognathae","Novaeratitae","Dinocrypturi","Galloanserae","Neoaves","Mirandornithes","Columbimorphae","Pteroclimesites","Otidimorphae","Musophagotides","Strisores","Vanescaves","Sedentaves","Letornithes","Daedalornithes","Phaethoquornithes","Phaethontimorphae","Aequornithes","Feraequornithes","Procellariimorphae","Pelecanimorphae","Pelecanes","Telluraves","Afroaves","Coraciimorphae","Cavitaves","Eucavitaves","Picocoraciades","Picodynastornithes","Australaves","Eufalconimorphae","Psittacopasseres")
Ylabels<- rev(clades)
p2<- ggplot(clade, aes(x=factor(tree, level=c("Full_RAxML","Full_IQTREE","indv_0_sites_90_loci_50",
                                              "indv_50_sites_50_loci_50","supertree","DivideConquer",
                                              "indv0_sites50_loci50_GAMMA","Fulldata_parsD",
                                              "Hybrid_supertree","Hybrid_DQ")), 
                  y=factor(clade,level=Ylabels),
                  fill = presence, fsize=)) + geom_tile(color = "white") + 
  scale_fill_manual(values=c("#F0F0F0","#9ECAE1"),labels = c("Non-monophyletic","Monophyletic"))
pdf(file = "presence_absence_matrix.pdf", width = 6, height = 10)
p2 + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),axis.text=element_text(size=13))
dev.off()

