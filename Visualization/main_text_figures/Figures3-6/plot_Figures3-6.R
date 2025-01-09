library(readxl)
library(ggplot2)
library(scales)
library(dplyr)
library(ComplexHeatmap)
library(ggpubr)
library(RColorBrewer)

########## plot sum stats for datasets in Figure 3 ###############

stats<- read_excel("summary_stats_datasets.xlsx",sheet="Sheet1")
stats1<- stats[-c(28), ]
stats3<- stats1 %>% mutate(gap = -gap,
                          missing50 = -missing50)
stats4<- as.matrix(stats3 %>% select(5:9))
rownames(stats4)<- stats1$dataset

#### generate heatmap with z-transformed stats with clusters ####
pdf(file = "heatmap_clusters_FigureS9.pdf", width = 7, height = 8) 
ComplexHeatmap::Heatmap(
  matrix = stats4 %>% t() %>% pheatmap:::scale_rows() %>% t(),
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)
)
dev.off()

ordered_names<- read.table("ordered datasets.txt",header=FALSE) %>% pull()
stat4_ordered <- stats4[ordered_names,]
table(rownames(stat4_ordered)==ordered_names)

#### generate heatmap with five stats ####
total_sites<- ComplexHeatmap::Heatmap(
  matrix = stat4_ordered[,1],cluster_rows = FALSE,
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)[10:90])
inf_sites<- ComplexHeatmap::Heatmap(
  matrix = stat4_ordered[,2],cluster_rows = FALSE,
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)[10:90])
loci_num<- ComplexHeatmap::Heatmap(
  matrix = stat4_ordered[,3],cluster_rows = FALSE,
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)[10:90])
gap<- ComplexHeatmap::Heatmap(
  matrix = stat4_ordered[,4],cluster_rows = FALSE,
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)[10:90])
missing_data<- ComplexHeatmap::Heatmap(
  matrix = stat4_ordered[,5],cluster_rows = FALSE,
  col = colorRampPalette(brewer.pal(n = 7, name = "RdYlBu"))(100)[10:90])

merged<- loci_num + total_sites + inf_sites + missing_data + gap

pdf(file = "heatmap_merged.pdf", width = 9, height = 5.9) 
ComplexHeatmap::draw(merged, gap=unit(0,"mm"))
dev.off()


########## plot PIS vs. clade recovery for datasets ###############
data<- read_excel("syst_trees_clade_recovery_summary.xlsx",sheet="fasttree")

data2<- data %>% 
  dplyr::mutate(
    indv_size = case_when(
      indv == "indv0" ~ "z",
      indv == "indv50" ~ "y",
      indv == "indv75" ~ "x"
    )
  ) %>%
  dplyr::relocate(
    indv_size, .after = indv
  )
  
data2 <- data2 %>% dplyr::mutate(indv = factor(indv, level = c("indv75","indv50","indv0")))

p <- ggplot(data2, aes(x=inf_sites, y=sum, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 10000, height = 0.1)
allclades_inf<- p + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + 
  theme_minimal()

p1 <- ggplot(data2, aes(x=inf_sites, y=genus, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 10000, height = 0.1)
genus_inf<- p1 + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + theme_minimal()

p2 <- ggplot(data2, aes(x=inf_sites, y=highlevel, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 10000, height = 0.1)
highlevel_inf<- p2 + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + theme_minimal()

pdf(file = "inf_sites_jitter.pdf", width = 11, height = 3.3) 
ggarrange(genus_inf, highlevel_inf,allclades_inf,nrow = 1,ncol = 3,legend = "none")
dev.off()

###### plot missing data vs clade recovery######
data<- read_excel("syst_trees_clade_recovery_summary.xlsx",sheet="fasttree")
data2<- data %>% 
  dplyr::mutate(
    indv_size = case_when(
      indv == "indv0" ~ "z",
      indv == "indv50" ~ "y",
      indv == "indv75" ~ "x"
    )
  ) %>%
  dplyr::relocate(
    indv_size, .after = indv
  )

data2 <- data2 %>% dplyr::mutate(indv = factor(indv, level = c("indv75","indv50","indv0")))

p <- ggplot(data2, aes(x=gap, y=sum, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 0.2, height = 0.2)
allclade_gaps<- p + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + theme_minimal()

p1 <- ggplot(data2, aes(x=gap, y=genus, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 0.2, height = 0.2)
genus_gap<- p1 + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + theme_minimal()

p2 <- ggplot(data2, aes(x=gap, y=highlevel, shape=loci_model, color=sites, size=indv)) +
  geom_jitter(width = 0.2, height = 0.2)
highlevel_gap<- p2 + scale_shape_manual(values=c(1,16,2,17,0,15)) + scale_color_brewer(palette="Dark2") + 
  scale_x_continuous(labels = label_comma()) + theme_minimal()

pdf(file = "gap_jitter.pdf", width = 11, height = 3.3) 
ggarrange(genus_gap, highlevel_gap,allclade_gaps,nrow = 1,ncol = 3,legend = "none")
dev.off()

