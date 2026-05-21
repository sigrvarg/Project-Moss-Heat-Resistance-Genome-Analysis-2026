#!/bin/bash

#SBATCH -A uppmax2026-1-61  #project code 
#SBATCH -M pelle
#SBATCH -t 0:30:00 		# time limit
#SBATCH -J featcount    #Job name
#SBATCH -c 1 		# number of cores
#SBATCH --mem 32G   # requested memory
#SBATCH -o %j.out			# File to which standard output will be written
#SBATCH -e %j.err 		# File to which standard error will be written

#BAM files
c1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Control_1_f1_sorted.bam
c2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/control_2_sorted.bam
c3=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Control_3_f1_sorted.bam
h1=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/Heat_1_f1_sorted.bam
h2=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/heat_2_sorted.bam
h3=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/RNA_Mapping/heat_3_sorted.bam

#Annotation file
genomic_feature_annotation=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/BRAKER3/braker_3/braker.gtf

#output directory
outdir=/home/siva5061/Project-Moss-Heat-Resistance-Genome-Analysis-2026/Analysis/Assembly/FeatureCounts/FeatureCounts_1

module load Subread/2.1.1-GCC-13.3.0

#run featurecounter, -t exon is default, -p paired end data, -g gene_id default for "attribute type used to group features"
featureCounts -T 1 \
    -p \
    -a $genomic_feature_annotation \
    -o $outdir/featureCounts_results.txt \
    --countReadPairs \
    $c1 $c2 $c3 $h1 $h2 $h3
