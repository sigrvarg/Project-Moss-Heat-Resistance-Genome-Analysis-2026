#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 0:30:00 		# time limit
#SBATCH -J RNA_fastqc_preprocessing    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 20G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

## Load modules required for script commands
module load FastQC/0.12.1-Java-17

output=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/FastQC
RNA_reads=/crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/transcriptomic_data/*

##is this how you do for  several files to have their own output?
## Run FASTQC
for x in $RNA_reads
	do
	fastqc -o $output "$x"
done
