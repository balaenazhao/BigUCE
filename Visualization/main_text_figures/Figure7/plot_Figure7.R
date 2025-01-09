library(ggplot2)
library(tidyr)
library(dplyr)
library(readxl)

####### plot divergence time and relative divergence times across different studies in Figure 7 ########

rel_time<- read_excel("relative rates.xlsx",sheet="Sheet1")
div_time<- read_excel("relative rates.xlsx",sheet="Sheet2")


#### relative time to Neognathae ####
data_rel <- pivot_longer(rel_time,cols=2:13,names_to = "clade",values_to = "divergence")   # reshape original data
data_rel$clade <- factor(data_rel$clade,                                    # Change ordering manually
                          levels = c("Palaeognathae","Neognathae","Galloanseres",
                                     "Neoaves","Strisores","Aequornithes",
                                     "Telluraves","Eucavitaves","Picodynastornithes",
                                     "Passeriformes","suboscines","oscines"))
data_rel$analysis <- factor(data_rel$analysis,                                    # Change ordering manually
                         levels = c("RAxML full tree","fulldata_parsD","G50_i0s50l50_parsB",
                                    "S2","T6","hybrid divide-and-conquer","hybrid supertree",
                                    "Claramunt et al. (2015)","Claramunt et al. (2024)",
                                    "Kimball et al. (2019)","Kuhl et al. (2021)","Prum et al. (2015)",
                                    "Stiller et al. (2024)","Wu et al. (2024)"))

pdf(file = "Rel divergence time - 12 clades.pdf", width = 14, height = 5)
ggplot(data_rel, aes(fill=analysis, y=divergence, x=clade)) + 
  geom_bar(stat="identity",position=position_dodge(width=0.8),width = 0.45) + 
  scale_fill_manual(values=c("#6aa4d5", 
                             "#c096c4", 
                             "#62c2c2", 
                             "#0173b5",
                             "#a5d497",
                             "#edd385",
                             "#e2827a",
                             "#dadada","#cccccc","#b3b3b3","#999999","#808080","#666666",
                             "#525252")) + 
  theme_minimal() +
  geom_hline(yintercept=0.602892102, linetype="dashed",color = "black", linewidth=0.5) + # Palaeognathae 54.2 0.602892102
  geom_hline(yintercept=1, linetype="dashed",color = "black", linewidth=0.5) + # Neognathae 89.9
  geom_hline(yintercept=0.905450501, linetype="dashed",color = "black", linewidth=0.5) + # Galloanseres 81.4 0.905450501
  geom_hline(yintercept=0.714126808, linetype="dashed",color = "black", linewidth=0.5) #Brocklehurst & Field (2024) Neoaves 64.2 0.714126808
dev.off()


#### absolute divergence time ####

data_div <- pivot_longer(div_time,cols=2:13,names_to = "clade",values_to = "divergence")   # reshape original data
data_div$clade <- factor(data_div$clade,                                    # Change ordering manually
                         levels = c("Palaeognathae","Neognathae","Galloanseres",
                                    "Neoaves","Strisores","Aequornithes",
                                    "Telluraves","Eucavitaves","Picodynastornithes",
                                    "Passeriformes","suboscines","oscines"))
data_div$analysis <- factor(data_div$analysis,                                    # Change ordering manually
                            levels = c("RAxML full tree","fulldata_parsD","G50_i0s50l50_parsB",
                                       "S2","T6","hybrid divide-and-conquer","hybrid supertree",
                                       "Claramunt et al. (2015)","Claramunt et al. (2024)",
                                       "Kimball et al. (2019)","Kuhl et al. (2021)","Prum et al. (2015)",
                                       "Stiller et al. (2024)","Wu et al. (2024)"))

pdf(file = "Absolute divergence time - 12 clades.pdf", width = 14, height = 5)
ggplot(data_div, aes(fill=analysis, y=divergence, x=clade)) + 
  geom_bar(stat="identity",position=position_dodge(width=0.8),width = 0.45) + 
  scale_fill_manual(values=c("#6aa4d5", 
                             "#c096c4", 
                             "#62c2c2", 
                             "#0173b5",
                             "#a5d497",
                             "#edd385",
                             "#e2827a",
                             "#dadada","#cccccc","#b3b3b3","#999999","#808080","#666666",
                             "#525252")) + 
  theme_minimal() +
  geom_hline(yintercept=54.2, linetype="dashed",color = "black", linewidth=0.5) + # Palaeognathae 54.2 0.602892102
  geom_hline(yintercept=89.9, linetype="dashed",color = "black", linewidth=0.5) + # Neognathae 89.9
  geom_hline(yintercept=81.4, linetype="dashed",color = "black", linewidth=0.5) + # Galloanseres 81.4 0.905450501
  geom_hline(yintercept=64.2, linetype="dashed",color = "black", linewidth=0.5) #Brocklehurst & Field (2024) Neoaves 64.2 0.714126808
dev.off()
