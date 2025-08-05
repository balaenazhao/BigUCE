library(ape)
library(phytools)
library(tidyverse)

setwd("/Users/balaena/Downloads/postdoc/BigUCE/Divergence_time/revision/")

tips<- read.csv("tips.csv",header=TRUE)

### check tree tips ###
raxml<- read.tree(file="RAxML-NG_fulldata_all_calibrations.tre")
fullfast<- read.tree(file="fulldata_parsD_rooted.tre-all-calibrations-1.tre")
I0s50l50<- read.tree(file="02_G50_i0s50l50_parsB_rooted.tre-all-calibrations-1.tre")
run2<- read.tree(file="brOPT_GTRR4_run2_Jetz_BigBird_Familybackbone.supertree_rooted_2751-all-calibrations-1.tre")
run9<- read.tree(file="brOPT_GTRR4_run9_GenusBackbone2v1_supertree_rooted_2758-all-calibrations-1.tre")
D9<- read.tree(file="brOPT_GTRR4_D9_MP_supertree_rooted-all-calibrations-1.tre")
S19<- read.tree(file="brOPT_GTRR4_S19_MP_supertree_trimmed_rooted-all-calibrations-1.tre")

setdiff(raxml$tip.label,tips$tips)
setdiff(tips$tips,fullfast$tip.label)
setdiff(tips$tips,I0s50l50$tip.label)
setdiff(tips$tips,run2$tip.label)
setdiff(tips$tips,run9$tip.label)
setdiff(tips$tips,D9$tip.label)
setdiff(tips$tips,S19$tip.label)

### read through tree files and store them in trees ####
tree_files <- list.files(path = ".", pattern = ".tre", full.names = TRUE)
trees <- lapply(tree_files, read.tree)
class(trees) <- "multiPhylo"
names(trees) <- basename(tree_files)
names(trees)


make_taxon_groups <- function(df, level, exclude = "x") {
  df_valid <- df[df[[level]] != exclude, ]
  split(df_valid$tips, df_valid[[level]])
}

genus_groups  <- make_taxon_groups(tips, "Genus")
family_groups <- make_taxon_groups(tips, "Family")
order_groups <- make_taxon_groups(tips, "Order")
level0_groups <- make_taxon_groups(tips, "level0")
level1_groups <- make_taxon_groups(tips, "level1")
level2_groups <- make_taxon_groups(tips, "level2")
level3_groups <- make_taxon_groups(tips, "level3")
level4_groups <- make_taxon_groups(tips, "level4")
level5_groups <- make_taxon_groups(tips, "level5")
level6_groups <- make_taxon_groups(tips, "level6")
level7_groups <- make_taxon_groups(tips, "level7")


taxon_groups <- c(
  setNames(genus_groups, paste0("genus_", names(genus_groups))),
  setNames(family_groups, paste0("family_", names(family_groups))),
  setNames(order_groups, paste0("order_", names(order_groups))),
  setNames(level0_groups, paste0("highlevel_", names(level0_groups))),
  setNames(level1_groups, paste0("highlevel_", names(level1_groups))),
  setNames(level2_groups, paste0("highlevel_", names(level2_groups))),
  setNames(level3_groups, paste0("highlevel_", names(level3_groups))),
  setNames(level4_groups, paste0("highlevel_", names(level4_groups))),
  setNames(level5_groups, paste0("highlevel_", names(level5_groups))),
  setNames(level6_groups, paste0("highlevel_", names(level6_groups))),
  setNames(level7_groups, paste0("highlevel_", names(level7_groups)))
)

extract_group_summary <- function(tree, group_name, taxa) {
  taxa_present <- intersect(taxa, tree$tip.label)
  if (length(taxa_present) < 2) return(NULL)  # Skip if too few taxa
  
  is_mono <- is.monophyletic(tree, taxa_present)
  mrca_node <- getMRCA(tree, taxa_present)
  if (is.null(mrca_node)) return(NULL)
  
  node_age <- max(nodeHeights(tree)) - nodeheight(tree, mrca_node)
  
  tibble(
    Group = group_name,
    Monophyletic = is_mono,
    MRCA_Age = node_age
  )
}


results <- list()

for (i in seq_along(trees)) {
  tree <- trees[[i]]
  tree_name <- names(trees)[i]
  
  for (grp in names(taxon_groups)) {
    row <- extract_group_summary(tree, grp, taxon_groups[[grp]])
    if (!is.null(row)) {
      row$Tree_ID <- paste0("Tree_", i)
      row$Filename <- tree_name
      results[[length(results) + 1]] <- row
    }
  }
}

summary_df <- bind_rows(results)
write_csv(summary_df, "per_tree_mrca_summary.csv")

#### summarize group variation ####
#### only using clades that are monophyletic ####
mono_df <- summary_df %>%
  filter(Monophyletic == TRUE)

mono_df <- mono_df %>%
  mutate(Level = case_when(
    str_starts(Group, "genus_") ~ "Genus",
    str_starts(Group, "family_") ~ "Family",
    str_starts(Group, "order_") ~ "Order",
    str_starts(Group, "highlevel_") ~ "Highlevel",
    TRUE ~ "Other"
  ))

clade_variation <- mono_df %>%
  group_by(Group, Level) %>%
  summarise(
    N_Trees = n(),
    Mean_Age = mean(MRCA_Age, na.rm = TRUE),
    SD_Age   = sd(MRCA_Age, na.rm = TRUE),
    Var_Age  = var(MRCA_Age, na.rm = TRUE),
    .groups = "drop"
  )

level_summary <- clade_variation %>%
  group_by(Level) %>%
  summarise(
    Mean_SD = mean(SD_Age, na.rm = TRUE),
    Median_SD = median(SD_Age, na.rm = TRUE),
    Max_SD = max(SD_Age, na.rm = TRUE),
    n_Clades = n()
  )

clade_variation <- clade_variation %>%
  mutate(Level = factor(Level, levels = c("Genus", "Family", "Order", "Highlevel")))
iqr_stats <- clade_variation %>%
  group_by(Level) %>%
  summarise(
    Q1 = quantile(SD_Age, 0.25, na.rm = TRUE),
    Q3 = quantile(SD_Age, 0.75, na.rm = TRUE),
    IQR = Q3 - Q1,
    Upper = Q3 + 1.5 * IQR,
    Lower = Q1 - 1.5 * IQR,
    .groups = "drop"
  )

clade_with_outliers <- clade_variation %>%
  left_join(iqr_stats, by = "Level") %>%
  mutate(
    is_outlier = SD_Age > Upper | SD_Age < Lower
  )

label_counts <- clade_with_outliers %>%
  group_by(Level) %>%
  summarise(n = n_distinct(Group), .groups = "drop") %>%
  mutate(Level_n = paste0(Level, " (n = ", n, ")"))
label_counts

pdf(file="variation_plot.pdf",height=7,width=6)
ggplot(clade_with_outliers, aes(x = Level, y = SD_Age)) +
  geom_boxplot(outlier.shape = NA, fill = "gray90") + 
  geom_point(
    data = filter(clade_with_outliers, is_outlier),
    shape = 21, fill = "black", size = 2
  ) +
  geom_text(
    data = filter(clade_with_outliers, is_outlier),
    aes(label = Group),
    hjust = -0.2,
    size = 3,
    check_overlap = FALSE
  ) +
  ylab("SD of MRCA Age (monophyletic clades)") +
  theme_minimal()

dev.off()

