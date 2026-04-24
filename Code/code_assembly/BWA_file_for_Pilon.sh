#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 1:30:00 		# time limit 1h bwa
#SBATCH -J bwa_evaluation    #Job name
#SBATCH -c 2 		# number of cores, bwa
#SBATCH --mem 64G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

reference=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Nanopore_assembly_Flye_1/flye_output_1/assembly.fasta
read_1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_preprocessing_trimmomatic/Illumina_preprocessing_trimmomatic_2/chr3_R1_paired_2.fastq.gz
read_2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing_SLURM/Illumina_preprocessing_trimmomatic/Illumina_preprocessing_trimmomatic_2/chr3_R2_paired_2.fastq.gz

## Load modules required for script commands
module load bwa-mem2/2.3-GCC-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Indexing the reference sequence (Requires 28N GB memory where N is the size of the reference sequence).
bwa-mem2 index $reference
# Mapping with bwa-mem2, piped to sorting and indexing
bwa-mem2 mem -t 2 $refindex $read_1 $read_2 | samtools sort -@ 2 -o out.bam
samtools index -b out.bam 

  
