#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 2:00:00 		# time limit
#SBATCH -J fastqc_evaluation    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 20G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

## Load modules required for script commands
module load FastQC/0.12.1-Java-17

trim_run1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/*fq.gz
trim_run2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2/*fq.gz
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/FastQC_trimmomatic_evaluation

#run FastQC
for x in $trim_run1 $trim_run2
do 
    fastqc -o $outdir $x
done



