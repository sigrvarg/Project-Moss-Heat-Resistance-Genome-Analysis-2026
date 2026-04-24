#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 2:30:00 		# time limit
#SBATCH -J BUSCO_assembl_eval    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 15G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

#load module busco
module load BUSCO/5.8.2-gfbf-2024a

#go to directory here want the output
cd /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Evaluation/BUSCO

input=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta

#run BUSCO on assembly
busco -i $input -l viridiplantae_odb10 -m genome -o BUSCO_run_4
