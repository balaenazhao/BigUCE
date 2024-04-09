#!/bin/sh

######## create tree pairs for comparison ########
touch ./*.tre
f=(*.tre)
for ((i = 0; i < ${#f[@]}; i++))
do 
for ((j = i + 1; j < ${#f[@]}; j++))
do 
echo "${f[i]} - ${f[j]}" >> pairs.txt
done
done

######### Use sed to create ete3 commands ########
sed -i 's/^/ete3 compare -r /g' pairs.txt  # replace the beginning of each line
sed -i 's/ - / -t /g' pairs.txt  # replace the dash between two trees
sed -i 's/$/ --unrooted --taboutput/g' pairs.txt #replace the tail of each line
## If trees are rooted, use the --unrooted flag


######## calculate RF distance using ete3 ########
ete3 compare -r full-raxml-itol-export_2759.tre -t full.concatenated.IQTREE_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_0_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_0_sites_90_loci_50_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_25_sites_90_loci_70_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_50_sites_50_loci_50_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r full-raxml-itol-export_2759.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_0_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_0_sites_90_loci_50_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_25_sites_90_loci_70_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_50_sites_50_loci_50_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r full.concatenated.IQTREE_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t indv_0_sites_90_loci_50_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t indv_25_sites_90_loci_70_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t indv_50_sites_50_loci_50_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_0_sites_50_loci_70_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t indv_25_sites_90_loci_70_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t indv_50_sites_50_loci_50_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_0_sites_90_loci_50_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t indv_50_sites_50_loci_50_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_25_sites_90_loci_70_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t indv_50_sites_50_loci_70_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_50_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t indv_50_sites_90_loci_90_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_50_loci_70_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run1_Jetz_Bigbird.rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r indv_50_sites_90_loci_90_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run2_Jetz_BigBird_Familybackbone.rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run1_Jetz_Bigbird.rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run3_Jetz_BigBird_Genusbackbone.rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run2_Jetz_BigBird_Familybackbone.rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run4_optimal_NoBackbone_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run3_Jetz_BigBird_Genusbackbone.rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run4_optimal_NoBackbone_rooted.tre -t run5_bootstrap_NoBackbone_rooted.tre --taboutput
ete3 compare -r run4_optimal_NoBackbone_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r run4_optimal_NoBackbone_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run4_optimal_NoBackbone_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run4_optimal_NoBackbone_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run5_bootstrap_NoBackbone_rooted.tre -t run6_optimal_FamilyBackbone_rooted.tre --taboutput
ete3 compare -r run5_bootstrap_NoBackbone_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run5_bootstrap_NoBackbone_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run5_bootstrap_NoBackbone_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run6_optimal_FamilyBackbone_rooted.tre -t run7_optimal_GenusBackbone_rooted.tre --taboutput
ete3 compare -r run6_optimal_FamilyBackbone_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run6_optimal_FamilyBackbone_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run7_optimal_GenusBackbone_rooted.tre -t run8_FamBackbone2v1_rooted.tre --taboutput
ete3 compare -r run7_optimal_GenusBackbone_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput
ete3 compare -r run8_FamBackbone2v1_rooted.tre -t run9_GenusBackbone2v1_rooted.tre --taboutput

