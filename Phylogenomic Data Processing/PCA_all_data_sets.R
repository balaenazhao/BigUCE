library("FactoMineR")
library("factoextra")
library("corrplot")

setwd("~/Dropbox/Avian_Tree_of_Life/7_filtering_data/Final_filtering/All_datasets/")

files <- list.files()

for (f in files) {
    ##Here I think you have to chance to get the singletons tables. That are already complete.
    table <- read.csv(f)
    re_table <- table[, grep("N_UCE", colnames(table)):grep("uces_single", colnames(table))]
    row.names(re_table) <- table$species_name
    re_tablePCA <- PCA(re_table, graph = FALSE, ncp=ncol(re_table))
    #here you have to adjust the directions to where you gonna save it
    write.csv(re_tablePCA$svd$U, (paste(f, "_1_PCA_scores.csv", sep = "")))
    #IMPORTANT
    #principle component contribution to total variation
    p1 <- fviz_eig(re_tablePCA, addlabels = TRUE, ylim = c(0, 75))
    var <- get_pca_var(re_tablePCA)
    #IMPORTANT
    #variable contribution for each principle component
    corrplot(var$contrib, is.corr = FALSE)
    #IMPORTANT
    #variable correlation plot
    p3 <- fviz_pca_var(re_tablePCA, col.var = "contrib",
                       gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                       repel = TRUE # Avoid text overlapping
    )
    #IMPORTANT
    #PCA1 vs PCA2
    ##add proj on the main table
    table$Proj <- gsub("_.*", "", table$Sample_ID)
    p4 <- fviz_pca_ind(re_tablePCA, alpha.ind = 0.5,
                       geom.ind = "point", # show points only (nbut not "text")
                       col.ind = table$Proj, # color by groups
                       addEllipses = F, # Concentration ellipses
                       legend.title = "Groups"
    )+ scale_shape_manual(values=c(1:24))
    pdf(paste(f, "_1_main_stats_PCA.pdf")) # Create a new pdf device
    print(p1)
    corrplot(var$contrib, is.corr = FALSE)
    print(p3)
    print(p4)
    dev.off() # Close the pdf device
  }


setwd("/Users/balaena/Downloads/postdoc/BigUCE/summary_statistics/filtered_datasets/")
data<- read.csv(file="indv_0_sites_0_loci_0_1_main_stats_final.csv",header=T)
pca<- PCA(data[,7:17])
summary(pca)


