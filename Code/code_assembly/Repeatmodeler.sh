#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 4:00:00 		# time limit
#SBATCH -J repmod    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 8G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

#load module
module load RepeatModeler/2.0.7-foss-2024a
module load RECON

assembly=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Repeatmodeler

#make library
BuildDatabase -name moss_database.db $assembly

#run on the library
RepeatModeler -database moss_database.db -threads 1 -dir $outdir
