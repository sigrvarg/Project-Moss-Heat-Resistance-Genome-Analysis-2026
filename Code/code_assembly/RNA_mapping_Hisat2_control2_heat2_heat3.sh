#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 1:40:00 		# time limit
#SBATCH -J hisat2    #Job name
#SBATCH -c 16 		# number of cores
#SBATCH --mem 15G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

# load module
module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22.1-GCC-13.3.0

#work in temporary directory
cd $SNIC_TMP

#proposition from chatgpt for making sure everything fails correctly- no empty .bam files
set -euo pipefail

# paths to files needed
genome=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta
control_2_f1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2/Control_2_f1_paired.fq.gz
control_2_r2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2/Control_2_r2_paired.fq.gz
heat_2_f1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/Heat_2_f1_paired.fq.gz
heat_2_r2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/Heat_2_r2_paired.fq.gz
heat_3_f1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/Heat_3_f1_paired.fq.gz
heat_3_r2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/Heat_3_r2_paired.fq.gz

#build hisat2 index used for aligning later, where genome_index is the basename for created indexes
hisat2-build $genome genome_index

#hisat on control 2 
hisat2 -p 16 -x genome_index -1 $control_2_f1 -2 $control_2_r2 | samtools sort -o control_2_sorted.bam
#index the sorted .bam file
samtools index control_2_sorted.bam
#copy from temporary to own directory
cp control_2_sorted.bam* /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/

#hisat on heat 2
hisat2 -p 16 -x genome_index -1 $heat_2_f1 -2 $heat_2_r2 | samtools sort -o heat_2_sorted.bam
#index the sorted .bam file
samtools index heat_2_sorted.bam
#copy from temporary to own directory
cp heat_2_sorted.bam* /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/

#hisat on heat 3 
hisat2 -p 16 -x genome_index -1 $heat_3_f1 -2 $heat_3_r2 | samtools sort -o heat_3_sorted.bam
#index the sorted .bam file
samtools index heat_3_sorted.bam
#copy from temporary to own directory
cp heat_3_sorted.bam* /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/
