#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 22:00:00 #reasonable for edith		# time limit
#SBATCH -J pilon_polishing    #Job name
#SBATCH -c 2 		# number of cores
#SBATCH --mem 20G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

module load Pilon/1.24-Java-17

genome=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Nanopore_assembly_Flye_1/flye_output_1/assembly.fasta
    ##here remember -bam not reated yet, spec path when know output!
PE_fragment=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/BWA_file_creation/*.bam
output=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon 

##run pilon on .bam file
pilon --genome $genome --frags $PE_fragment --outdir output
