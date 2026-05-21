#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 1:00:00 		# time limit
#SBATCH -J hisat2    #Job name
#SBATCH -c 16 		# number of cores
#SBATCH --mem 15G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

# load module
module load HISAT2/2.2.1-gompi-2024a
module load SAMtools/1.22.1-GCC-13.3.0

#work in temporary directory
cd $SNIC_TMP

# paths to files needed
genome=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/Illumina_polishing_pilon/pilon.fasta
reads_f1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/*f1_paired.fq.gz
control_2_f1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2/Control_2_f1_paired.fq.gz
control_2_r2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_2/Control_2_r2_paired.fq.gz

#build hisat2 index used for aligning later, where genome_index is the basename for created indexes
hisat2-build $genome genome_index

# run hisat2 # should the output be converted to a .bam file for BRAKER3!
for r1 in $reads_f1
do
    base=$(basename $r1 _paired.fq.gz)

    #exclude the bad run from this and do outside loop instead
    if [[ $base == Control_2* ]]; then
    continue
    fi

    #for each _f1 file find the corresponding _r2 file
    r2_base=${base/_f1/_r2}
    r2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Preprocessing/RNA_preprocessing/RNA_trimmomatic/trimmomatic_1/${r2_base}_paired.fq.gz

    hisat2 -p 16 -x genome_index -1 $r1 -2 $r2 | samtools sort -o ${base}_sorted.bam

    #index the sorted .bam file
    samtools index ${base}_sorted.bam

    cp ${base}_sorted.bam* /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/
done 

#hisat on control 2 only
hisat2 -p 16 -x genome_index -1 $control_2_f1 -2 $control_2_r2 | samtools sort -o control_2_sorted.bam

#index the sorted .bam file
samtools index control_2_sorted.bam

cp control_2_sorted.bam* /home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/
