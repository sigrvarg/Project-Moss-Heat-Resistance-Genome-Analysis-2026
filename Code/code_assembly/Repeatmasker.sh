#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 8:00:00 		# time limit
#SBATCH -J repmask    #Job name
#SBATCH -c 2 		# number of cores
#SBATCH --mem 35G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

#load module
module load RepeatMasker/4.2.1-foss-2024a

assembly=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Repeatmasker
lib=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Repeatmodeler/moss_database.db-families.fa

#run masker: -xsmall is masking repeats in lower case, -pa is the cores, -gff is output format, -nolow ignore low complexity
RepeatMasker -xsmall -lib $lib $assembly -pa 2 -gff -nolow -dir $outdir

