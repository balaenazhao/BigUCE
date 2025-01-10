conda activate twist
module load parallel-20171122


python ../tools/AMAS/amas/AMAS.py convert -d dna -f fasta -i Final_trimmed_clean/*.fasta -u phylip -c 20

mkdir phylip
mv *.phy phylip
cd phylip

conda deactivate

##Creating a statstable for each loci
python ../Alignment_Assessment-master/Alignment_Assessment_v2.py ../phylip

mkdir miss_indv_0
cp *.phy miss_indv_0/


##filteringout ind. with <50% locus completeness (select flag 'b' and give a number for the amount o MD, in this case '50'
python ../Alignment_Refiner-master/Alignment_Refiner_v2.py ../phylip/ Alignment_Assessment/Master_Alignment_Assessment.txt b 50
#b
#25

mv Output_Refinement/ miss_indv_25

python ../Alignment_Refiner-master/Alignment_Refiner_v2.py ../phylip/ Alignment_Assessment/Master_Alignment_Assessment.txt b 50
#b
#50
mv Output_Refinement/ miss_indv_50

rm *.phy

#Converting back to fasta
cd /home/gthomesilva/nas4/Avian_Tree_of_Life/7_filtering_data_final
conda activate twist
module load parallel-20171122
mkdir Final_datasets

for i in 0 25 50; do
	mkdir Final_datasets/miss_indv_$i
	cd Final_datasets/miss_indv_$i
	python ../../../tools/AMAS/amas/AMAS.py convert -d dna -f phylip -i ../../phylip/miss_indv_$i/*.phy -u fasta -c 20
	cd ../../
done

cd Final_datasets
conda activate phyluce
for i in 0 25 50; do
for z in 50 70 90; do
mkdir miss_indv_$i/missing_sites_$z
cd miss_indv_$i/missing_sites_$z
ls ../*.fas | sed 's/-out.fas//g; s/\.\.\///g' | parallel -j 20 trimal -in ../{}-out.fas -out {}.trim.fas -fasta -gt 0.$z
cd ../../
done
done


for i in 0 25 50; do
mkdir miss_indv_$i/missing_sites_00
cd miss_indv_$i
mv *.fas missing_sites_00
cd ../
done

total=$(grep -h \> miss_indv_50/missing_sites_90/*.fas | sort | uniq | wc -l)
t50=total/2

module load parallel-20171122

for i in 0 25 50; do
for z in 50 70 90; do
for w in 50 70 90; do
mkdir miss_indv_$i/missing_sites_$z/missing_loci_$w
cd miss_indv_$i/missing_sites_$z
grep -c \> *.fas | perl -pi -w -e 's/:/\t/g' > loci.txt
th=$((x=$w, r=$total / 100, t=r * w))
awk -F"\t" -v awkvar=$th '$2>awkvar {print $1}' loci.txt | parallel cp {} missing_loci_$w/
cd ../../
done
done
done

for i in 0 25 50; do
for z in 50 70 90; do
mkdir miss_indv_$i/missing_sites_$z/missing_loci_00
cd miss_indv_$i/missing_sites_$z
mv *.fas missing_loci_00
cd ../../
done
done


mkdir All_datasets

for i in 0 25 50; do
for z in 50 70 90; do
for w in 50 70 90; do
cp -r miss_indv_$i/missing_sites_$z/missing_loci_$w/ All_datasets/indv_$i\_sites_$z\_loci_$w
done
done
done