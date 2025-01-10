library(phytools)
library(seqinr)
library(plyr)
library(tidyverse)
library(phytools)
library(phylotools)
#library(ips)
library(parallel)
library(MASS)
library(dplyr)
setwd("/home/gthomesilva/nas4/Avian_Tree_of_Life/7_filtering_data_final/Final_datasets/All_datasets")
#loading main table
main <- read.csv("../../all_genomes_IOC.csv")
main <- main[,c(2,6,8,9)] #sample, family, name, tip
terminal <- main$Tip_Name

folders <- list.dirs(full.names=F)
folders <- folders[2:length(folders)]

for (f in folders) {
    main <- read.csv(paste(f, "_1_main_stats.csv", sep = ""))
    folder <- paste(f, "/", sep = "")
    uces <- list.files(folder, pattern = "*.fas", full.names = F)
    uces <- unique(gsub(".log", "", uces))
    #uce<- uces[2:4]
    #######
    #######
    #######
    #######
    singletons <- function(uce){
      system(paste("~/nas3/miniconda2/bin/snp-sites ", folder, uce, " -v -b -o ", uce, ".vcf", sep = ""))
      system(paste("perl -pi -w -e 's/\\t(\\d)/\\t\\1\\/\\1/g; s/^(\\d\\t)\\d\\//\\1/g' ", uce, ".vcf", sep = ""))
      system(paste("perl -pi -w -e 's/1\\/1/\\.\\/\\./g if /\\t\\*\\t/; s/1\\/1/\\.\\/\\./g if /\\t\\*,\\w/; s/2\\/2/\\.\\/\\./g if /\\t\\w,\\*,/; s/3\\/3/\\.\\/\\./g if /\\t\\w,\\w,\\*/; s/4\\/4/\\.\\/\\./g if /\\t\\w,\\w,\\w,\\*/; s/5\\/5/\\.\\/\\./g if /\\t\\w,\\w,\\w,\\w,\\*/ ' ", uce, ".vcf", sep = ""))
      system(paste("vcftools --vcf ", uce, ".vcf --indv-freq-burden --out ", uce, sep = ""))
      #system(paste("cat ", uce, ".ifreqburden | awk '{print $1,$4/2}' > ", uce, ".single", sep = ""))
      ###somar as colunas do indburden pra obter o numero de variantes em cada individuo.
      sing <- as.data.frame(read.csv(paste(uce, ".ifreqburden", sep = ""), header = T, sep = "\t"))
      sing2 <- sing[c(1,4)]
      sing <- sing[2:ncol(sing)]
      sing <- rowSums(sing, na.rm = T)
      sing <- cbind(sing2, sing-sing2$X2)
      sing <- sing[-1,]
      uce2 <- gsub("_mafft_dup_removed_trimmed_clean.fasta", "", uce)
      colnames(sing) <- c("Tip_Name", paste(uce2, "sing", sep = ""), paste(uce2, "all", sep = ""))
      system(paste("rm ", uce, ".*",sep = ""))
      main3 <- join(main, sing, "Tip_Name")
      return(main3[,c(13,14)])
    }
    numCores <- 48
    all_data2 <- mclapply(uces, singletons, mc.cores = numCores) %>% bind_cols()
    uces_PI <- rowMeans(all_data2[,grep("all", colnames(all_data2))], na.rm = T)
    uces_PISD <- apply(all_data2[,grep("all", colnames(all_data2))],1, sd, na.rm = TRUE)
    uces_PItot <- rowSums(all_data2[,grep("all", colnames(all_data2))], na.rm = T)
    uces_single <- rowSums(all_data2[,grep("sing", colnames(all_data2))], na.rm = T)
    main2 <- cbind(main, uces_PI, uces_PISD, uces_PItot, uces_single)
    main2 <- main2[order(main2$Sample_ID),]
    write.csv(main2, paste(f, "_1_main_stats_final.csv", sep = ""))
  }