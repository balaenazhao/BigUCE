library(ggplot2)
library(gridExtra)
library(tidyr)
library(dplyr)
library(RColorBrewer)

########## plot number of non-monophyly ###########
mono_data<- read.csv("non-mono_improved_methods_V2.csv")
data <- mono_data                                                 # Replicate original data
data$Tree <- factor(data$Tree, levels = c("1_C12_MP_supertree","2_C14_MP_supertree","3_C18_MP_supertree",
                                          "4_D9_MP_supertree","5_D8_MP_supertree","6_full_raxml",
                                          "7_fulldata_parsD","8_02_G50_i0s50l50_parsB","9_01_F70_i0s50l70_parsCstart",
                                          "10_S19_MP_supertree","11_S9_MP_supertree","12_S16_MP_supertree",
                                          "13_S11_MP_supertree","14_S13_MP_supertree","15_12_F70_i50s90l70_parsDstart",
                                          "16_17_F50_i25s90l50_parsC","17_11_F90_i50s90l90_parsC"))
p<- ggplot(data, aes(fill=clade, y=number, x=Tree)) + 
  geom_bar(position="stack", stat="identity") + scale_fill_manual(values = c("#b4bcce", "#d88c9a", "#ede0c5","#728c9a"))

pdf(file="R_nonMono_improved_methods_V2.pdf",width=10, height=6)
p
dev.off()

########## plot CPU hours ###########
CPU<- read.csv("CPU_time_improved_methods_V2.csv")
my_table <- tableGrob(CPU)
pdf(file = "CPU_improved_methods_V2.pdf", width = 12, height = 6)
grid.arrange(my_table)
dev.off()

########## plot presence/absence matrix of high-level clades ###########
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


########## plot divergence time ###########
time<- read_excel("Divergence_GTRR4.xlsx",sheet="Sheet1")
data_time <- pivot_longer(time,cols=2:12,names_to = "clade",values_to = "divergence")       # reshape original data
data_time$clade <- factor(data_time$clade,                                    # Change ordering manually
                    levels = c("Palaeognathae","Neognathae","Galloanseres",
                               "Neoaves","Strisores","Aequornithes","Afroaves",
                               "Telluraves","Passeriformes","suboscines","oscines"))
data_time$tree <- factor(data_time$tree,                                    # Change ordering manually
                          levels = c("RAxML full tree","fulldata_parsD","G50_i0s50l50_parsB",
                                     "S2","T6","D9","S19"))

p2<- ggplot(data_time, aes(fill=tree, y=divergence, x=clade)) + 
  geom_bar(stat="identity",position=position_dodge(width=0.8),width = 0.6) + 
  scale_fill_paletteer_d("rcartocolor::Geyser") +
  theme_minimal()

pdf(file = "Divergence time.pdf", width = 9, height = 3)

p2 + geom_hline(yintercept=66, linetype="dashed",color = "darkgray", size=0.5)

dev.off()
