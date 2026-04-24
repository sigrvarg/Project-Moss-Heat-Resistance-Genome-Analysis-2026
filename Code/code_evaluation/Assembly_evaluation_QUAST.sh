#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 0:40:00 		# time limit
#SBATCH -J QUAST_assembl_eval    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 15G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

#load module
module load QUAST/5.2.0-foss-2024a-Python-2.7.18

output=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Evaluation/QUAST
input=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta

#run QUAST
quast.py $input -o $output
