#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 60:00:00 		# time limit
#SBATCH -J nanopore_assembly_1    #Job name
#SBATCH -c 2 		# number of cores
#SBATCH --mem 90G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

## Change directories to where we want the output
cd /home/siva5061/Analysis/Preprocessing_SLURM/Nanopore_assembly_Flye_1/Assembly_Flye_1

## Load modules required for script commands
module load Flye/2.9.6-GCC-13.3.0

## Run Flye
flye \
  --nano-raw /crex/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/reads/genomics_chr3_data/chr3_clean_nanopore.fq.gz \
  --out-dir flye_output_1 \
  --threads 2
