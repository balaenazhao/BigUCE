library(readxl)
library(ggplot2)
library(scales)
library(dplyr)
library(ComplexHeatmap)
library(ggpubr)


########## plot basic stats for datasets ###############

stats<- read_excel("summary_stats_datasets.xlsx",sheet="Sheet1")
stats1<- stats[-c(28), ]
stats2<- as.matrix(stats1 %>% select(5:9))
rownames(stats2)<- stats1$dataset

stats3<- stats1 %>% mutate(gap = -gap,
                          missing50 = -missing50)
stats4<- as.matrix(stats3 %>% select(5:9))
rownames(stats4)<- stats1$dataset

  
pdf(file = "heatmap_cluster.pdf", width = 8, height = 7) 
heatmap(stats4,scale="column")
dev.off()

pdf(file = "heatmap_nocluster.pdf", width = 6, height = 10) 
Heatmap(stats_scale, cluster_rows = FALSE, col = col_fun)
dev.off()

###############################################################



########## plot PIS vs. clade recovery for datasets ###############
data<- read_excel("syst_trees_clade_recovery_summary.xlsx",sheet="fasttree")

p0 <- ggplot(data, aes(x=inf_sites, y=sum, shape=loci, color=sites, size=indv)) +
  geom_point() + scale_color_brewer(palette="Dark2") + theme_minimal()

pdf(file = "legend.pdf", width = 7, height = 7) 
p0
dev.off()

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


x<- ggarrange(genus_inf, highlevel_inf,allclades_inf,
          nrow = 1,
          ncol = 3,
          legend = "none")

pdf(file = "inf_sites_jitter.pdf", width = 11, height = 3.3) 
x
dev.off()

###############################################################

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

y<- ggarrange(genus_gap, highlevel_gap,allclade_gaps,
              nrow = 1,
              ncol = 3,
              legend = "none")

pdf(file = "gap_jitter.pdf", width = 11, height = 3.3) 
y
dev.off()
