#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 0:30:00 		# time limit
#SBATCH -J fastqc_preprocessing    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 20G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

##OBS!! this is a rewritten slurm for running FASTQC, the original slurm is missing
## so to document the work this was rewritten, it has not been used to create the output in 
## Illumina_preprocessing_FastQC

## Load modules required for script commands
module load FastQC/0.12.1-Java-17

## Run FASTQC
fastqc -o /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_preprocessing_FastQC /crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/*illumina*
