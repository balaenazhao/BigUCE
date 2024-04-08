library(ggplot2)
library(gridExtra)
library(tidyr)
library(dplyr)
library(RColorBrewer)


########## plot number of non-monophyly ###########
mono_data<- read.csv("./non-mono.csv")
data <- mono_data                                                 # Replicate original data
data$Tree <- factor(data$Tree,                                    # Change ordering manually
                  levels = c("1_OptimalTrees","2_BootstrapTrees","3_OptimalTrees+FamilyBackbone4v1",
                             "4_OptimalTrees+FamBackbone2v1","5_OptimalTrees+GenusBackbone4v1",
                             "6_OptimalTrees+GenusBackbone2v1","7_full_RAxML","8_full_IQ-TREE",
                             "9_Filter: indv_0_sites_50_loci_70","10_Filter: indv_25_sites_90_loci_70",
                             "11_Filter: indv_50_sites_90_loci_90","12_Filter: indv_50_sites_50_loci_50",
                             "13_Filter: indv_50_sites_50_loci_70","14_Filter: indv_0_sites_90_loci_50",
                             "15_PublishedTrees+Jetz+BigBird+Familybackbone","16_PublishedTrees+Jetz+BigBird+Genusbackbone",
                             "17_PublishedTrees+Jetz+BigBird"))
p<- ggplot(data, aes(fill=clade, y=number, x=Tree)) + 
  geom_bar(position="stack", stat="identity") + scale_fill_manual(values = c("#9ECAE1", "#4292C6", "#084594"))

pdf(file="R_plot_nonMono.pdf",width=10, height=6)
p
dev.off()

########## plot CPU hours ###########
CPU<- read.csv("./CPU time.csv")
my_table <- tableGrob(CPU)
pdf(file = "CPU.pdf", width = 12, height = 6)
grid.arrange(my_table)
dev.off()
