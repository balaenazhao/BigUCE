#!/bin/bash
#SBATCH --account=xxxxx
#SBATCH --qos=xxxx
#SBATCH --job-name=supertree_paup
#SBATCH --mail-type=ALL
#SBATCH --mail-user=xxx
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4gb
#SBATCH --time=4-0
#SBATCH -o paup_%j.out

module load paup
paup coding_upweight15.nex
paup coding_upweight20.nex
paup coding_upweight25.nex
paup coding_upweight30.nex
paup coding_upweight35.nex
