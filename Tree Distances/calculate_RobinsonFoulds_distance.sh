#!/bin/sh

######## create tree pairs for comparison ########
touch ./*.tre
f=(*.tre)
for ((i = 0; i < ${#f[@]}; i++))
do 
for ((j = i + 1; j < ${#f[@]}; j++))
do 
echo "${f[i]} - ${f[j]}"
done
done

######## calculate RF distance using ete3 ########
######## examples of three tree files ##########
module load ete3
ete3 compare -r tree1.tre -t tree2.tre --unrooted --taboutput
ete3 compare -r tree1.tre -t tree2.tre --unrooted --taboutput
ete3 compare -r tree2.tre -t tree3.tre --unrooted --taboutput
