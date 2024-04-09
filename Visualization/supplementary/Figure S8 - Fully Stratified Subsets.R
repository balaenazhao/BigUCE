library(ComplexHeatmap)
library(magrittr)
library(dplyr)
library(readr)

####### read in data file that contains 2670 taxa and the subsets they belong #######
####### present: 1; absent: NA #######
mat <- read_csv("./subsets.csv")
gr <- colnames(mat)[2:ncol(mat)]
tx <- mat$taxon
mt <- mat[,2:ncol(mat)] %>% 
  t() %>%
  as.matrix()
colnames(mt) <- 1:ncol(mt)
rownames(mt) <- gr
mt[is.na(mt)] <- 0 # replace NAs with O

####### read in subset taxonomic group information #######
group_info <- readxl::read_xlsx("./group_info.xlsx")
order_names <- str_replace(tx,"_.*","")

####### create presence/absence matrix to be drawn as a heatmap #######
ha <- data.frame("order" = order_names) %>%
  dplyr::left_join(group_info) %>%
  dplyr::mutate(group = fct_relevel(group, unique(group_info$group)))

rownames(ha) <- 1:ncol(mt)

####### apply selected color palette #######
col_pal <- c(
  "OUTGROUP" = "black",
  "Palaeognathae" = "#875692",
  "Galloanserae" = "#f38400",
  "Strisores" = "#a1caf1",
  "Otidimorphae" = "#be0032",
  "Columbimorphae" = "#c2b280",
  "GRUIFORMES" = "#848482",
  "Mirandornithes" = "#008856",
  "CHARADRIIFORMES" = "#e68fac",
  "Phaethoquornithes" = "#0067a5",
  "OPISTHOCOMIFORMES" = "#f99379",
  "ACCIPITRIFORMES" = "#604e97",
  "STRIGIFORMES" = "#f6a600",
  "Coraciimorphae" = "#b3446c",
  "CARIAMIFORMES" = "#dcd300",
  "FALCONIFORMES" = "#882d17",
  "PSITTACIFORMES" = "#8db600",
  "Acanthisittidae" = "#654522",
  `PASSERIFORMES-suboscine` = "#e25822",
  `PASSERIFORMES-oscine` = "#52c9daff"
)

####### Top color bar #######
top_ha <- HeatmapAnnotation(
  df = ha %>% dplyr::select(group),
  col = list(group = col_pal),
  annotation_legend_param = list(
    group = list(direction = "vertical", 
                 by_row = TRUE,
                 nrow = 4)
  )
)

####### Draw heatmap #######
pdf("./subset_occurrence.pdf", width = 12, height = 8)
ht <- Heatmap(matrix = mt,
        col = c("white","#3483b1ff"),
        heatmap_legend_param = list(
          title = "occurrence", at = c(0, 1), 
          labels = c("absent", "present")
        ),
        cluster_columns = FALSE,
        cluster_rows = FALSE,
        show_column_names = FALSE,
        row_names_side = "left",
        top_annotation = top_ha)

ComplexHeatmap::draw(ht, annotation_legend_side = "bottom")
dev.off()

