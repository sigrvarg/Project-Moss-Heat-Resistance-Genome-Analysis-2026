#!/bin/bash

#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -t 2:00:00
#SBATCH -J trimmomatic_chr3_2
#SBATCH -c 1
#SBATCH --mem 20G
#SBATCH -o %j.out
#SBATCH -e %j.err

# Go to output directory
cd /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_preprocessing_trimmomatic_2

# Ladda modul
module load Trimmomatic/0.39-Java-17

# Input-filer
R1=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_illumina_R1.fastq.gz
R2=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_illumina_R2.fastq.gz

# Kör Trimmomatic (paired-end)
trimmomatic PE \
  -threads 1 \
  $R1 $R2 \
  chr3_R1_paired_2.fastq.gz chr3_R1_unpaired_2.fastq.gz \
  chr3_R2_paired_2.fastq.gz chr3_R2_unpaired_2.fastq.gz \
  ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
