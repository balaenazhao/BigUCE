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
######## some examples below ########
module load ete3

ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/C12_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/01_F70_i0s50l70_parsCstart_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/C12_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/02_G50_i0s50l50_parsB_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/C12_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/11_F90_i50s90l90_parsC_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/C12_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/12_F70_i50s90l70_parsDstart_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/C12_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/17_F50_i25s90l50_parsC_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/C14_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/C12_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/C18_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/C14_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/D8_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/C18_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/D8_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S11_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/D9_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/S13_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/S11_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S13_MP_supertree_rooted.tre -t improved_methods_V2/S16_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S13_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S13_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S13_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/S13_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S16_MP_supertree_rooted.tre -t improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S16_MP_supertree_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S16_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/S16_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/S9_MP_supertree_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/S19_MP_supertree_trimmed_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/S9_MP_supertree_rooted.tre -t improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre --taboutput
ete3 compare -r improved_methods_V2/S9_MP_supertree_rooted.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
ete3 compare -r improved_methods_V2/full-raxml-itol-export_2758_reconciled.tre -t improved_methods_V2/fulldata_parsD_rooted.tre --taboutput
