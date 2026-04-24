#!/bin/bash

#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -t 0:30:00
#SBATCH -J C2_RNA_trimmomatic_chr3_2
#SBATCH -c 4  #extra cores because it failed before, others should be fine
#SBATCH --mem 8G
#SBATCH -o %j.out
#SBATCH -e %j.err

# Go to output directory
cd /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2

# Load module
module load Trimmomatic/0.39-Java-17

# Input-files
F1=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data/Control_2_f1.fq.gz
R2=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data/Control_2_r2.fq.gz

#loop är inte bra, kan istället enl nic göra en slurm för varjepar av filer och köra dem parallellt
trimmomatic PE \
-threads 4 \
$F1 $R2 \
Control_2_f1_paired.fq.gz Control_2_f1_unpaired.fq.gz \
Control_2_r2_paired.fq.gz Control_2_r2_unpaired.fq.gz \
ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

  
