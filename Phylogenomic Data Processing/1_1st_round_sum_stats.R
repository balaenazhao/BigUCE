library(phytools)
library(seqinr)
library(plyr)
library(tidyverse)
library(phylotools)
library(parallel)
library(MASS)
library(dplyr)
#####Summary Stats per individual
setwd("/home/gthomesilva/nas4/Avian_Tree_of_Life/7_filtering_data_final/Final_datasets/All_datasets")
#loading main table
main <- read.csv("../../all_genomes_IOC.csv")
main <- main[,c(2,6,8,9)] #sample, family, name, tip
terminal <- main$Tip_Name

folders <- list.dirs(full.names=F)
folders <- folders[2:length(folders)]

for (f in folders) {
    folder <- paste(f, "/", sep = "")
    uces <- list.files(folder, full.names = F, pattern = ".fas")
    #uce=uces[102]
    basic_stats <- function(uce){
      fas <- seqinr::read.fasta(paste(folder,uce, sep = ""), seqtype = "DNA", set.attributes = T)
      fas1 <- read.FASTA(paste(folder,uce, sep = ""), type = "dna")
      data <- as.data.frame(as.numeric(summary(del.gaps(fas1))[,1]))
      data$gc <- NA
      for (i in 1:nrow(data)) {
        gc <- round(as.numeric(summary(fas[[i]])[3]), digits = 2)
        data$gc[i] <- gc
      }
      uc <- gsub("_mafft_dup_removed_trimmed_clean.fasta", "", uce)
      l=as.numeric(max(data$`as.numeric(summary(del.gaps(fas1))[, 1])`))
      gap <- l-as.numeric(data$`as.numeric(summary(del.gaps(fas1))[, 1])`)
      data$gap <- gap
      colnames(data) <- c(paste(uc, "_length", sep = ""), paste(uc, "_gc", sep = ""), paste(uc, "_gap", sep = ""))
      data$Tip_Name <- names(fas)
      main2 <- join(main, data, "Tip_Name")
      print(uce)
      return(main2[,c(5,6,7)])
    }
    #uces <- uces[100:105]
    numCores <- 24
    all_data <- mclapply(uces, basic_stats, mc.cores = numCores) %>% bind_cols()
    uces_lenght <- rowMeans(all_data[,grep("leng", colnames(all_data))], na.rm = T)
    uces_lenghtSD <- apply(all_data[,grep("leng", colnames(all_data))],1, sd, na.rm = TRUE)
    GC_cont <- rowMeans(all_data[,grep("gc", colnames(all_data))], na.rm = T)
    GC_contSD <- apply(all_data[,grep("gc", colnames(all_data))],1, sd, na.rm = TRUE)
    gaps <- rowMeans(all_data[,grep("gap", colnames(all_data))], na.rm = T)
    gapsSD <- apply(all_data[,grep("gap", colnames(all_data))],1, sd, na.rm = TRUE)
    N_UCE <- apply(all_data[,grep("leng", colnames(all_data))], 1, function(x) length(which(x >= 1)))
    main3 <- cbind(main, N_UCE, uces_lenght, uces_lenghtSD, GC_cont, GC_contSD, gaps, gapsSD)
    main3 <- main3[order(main3$Sample_ID),]
    table_name <- paste(f, "_1_main_stats.csv", sep = "")
    #table_dir <- paste(table_name, sep = "")
    write.csv(main3, table_name)
  }