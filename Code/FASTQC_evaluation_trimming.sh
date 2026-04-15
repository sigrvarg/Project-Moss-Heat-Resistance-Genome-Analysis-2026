#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 0:20:00 		# time limit
#SBATCH -J fastqc_evaluation    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 20G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

## Load modules required for script commands
module load FastQC/0.12.1-Java-17

## Run FASTQC
fastqc -o /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_trimming_evaluation_FastQC /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_preprocessing_trimmomatic/Illumina_preprocessing_trimmomatic_2/*2.fastq.gz
